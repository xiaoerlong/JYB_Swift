//
//  ClientComm.m
//  JYB_Swift
//
//  Created by kim on 2023/8/4.
//

#import "ClientComm.h"

#import "MarketDataProtocol_CMS.h"
#include "WrapperEVP.h"
#include "WrapperRSA.h"
#include "ClientSecurityMng.h"


@interface ClientComm () <NSStreamDelegate>
{
    STCClientSecurityMng csm; // 加密类
}
@property (nonatomic, strong) NSThread *workingThread;
@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, assign) BOOL keepRunning;

@property (nonatomic, strong) NSInputStream *inputStream; // 读
@property (nonatomic, strong) NSOutputStream *outputStream; // 写

@property (nonatomic, strong) NSMutableData *writeBuf;
@property (nonatomic, strong) NSMutableData *readBuf;
@property (nonatomic, assign) NSInteger writeByteIndex;
@property (nonatomic, assign) NSInteger readByteIndex;

@property (nonatomic, assign, readonly) BOOL isConnected; // 是否连接
@property (nonatomic, strong) NSDate *lastEventDate;

@end

@implementation ClientComm
- (instancetype)init {
    self = [super init];
    if (self) {
        self->csm = STCClientSecurityMng();
        self.writeBuf = [NSMutableData data];
        self.readBuf = [NSMutableData data];
        
        self.condition = [[NSCondition alloc] init];
        self.condition.name = @"ClientComm";
        
        self.workingThread = [[NSThread alloc] initWithTarget:self selector:@selector(connectToServer) object:nil];
        self.workingThread.name = @"com.commClient.thread";
    }
    return self;
}

/**
 每次发送消息过来，先判断是否连接，如果未连接就先连接
 连接完成定时 1 分钟调用 ping
 挑战服务器
 当碰到 readStreamErrorOccurred 时定时重连服务器
 */


- (void)sendMessage:(NSString *)msg {
    [self.condition lock];
    // 1.判断 TCP 是否连接（三次握手完成）
    if (!self.isConnected) {
        // 等待连接
        [self.workingThread start];
        
        // 当时间到时返回 NO
        if (![self.condition waitUntilDate:[NSDate dateWithTimeIntervalSinceNow:15]]) {
            NSLog(@"TCP 连接超时");
            [self.condition unlock];
            return;
        };
        // 挑战服务器失败
        if (![self challengeService]) {
            NSLog(@"挑战服务器失败");
            [self.condition unlock];
            return;
        }
    }
    [self.condition unlock];
    
    
    // 2.发送消息
    NSString *reqXML = msg;
    if (!reqXML) {
        NSLog(@"发送数据为 nil");
        return;
    }
    NSLog(@"发送数据:\n%@", reqXML);
    
    const char *cXML = [reqXML UTF8String];
    int xmlLen = (int)strlen(cXML);
    NSMutableData *data = [[NSMutableData alloc] init];
    int pkgSize = sizeof(int)+sizeof(short)+sizeof(int)+xmlLen;
    [data appendBytes:&pkgSize length:sizeof(pkgSize)];
    unsigned short msgTp = 51000;
    [data appendBytes:&msgTp length:sizeof(msgTp)];
    [data appendBytes:&xmlLen length:sizeof(xmlLen)];
   
    if (cXML == NULL)
        cXML = "";
    [data appendBytes:cXML  length:xmlLen];
    
    BOOL ret = [self EncrptAndSend:(BYTE*)[data bytes] Size:(int)[data length] encrypt:YES];
}



- (BOOL) EncrptAndSend:(BYTE*) pSrcPkg Size:(int) PkgSize encrypt:(BOOL) Encrypt
{
    if( pSrcPkg==NULL || PkgSize<=0 )
        return FALSE ;
    
    if( Encrypt==FALSE )
    {
        MDPHead* pHead = (MDPHead*)pSrcPkg ;
#pragma unused(pHead)
        NSLog( @"send pkg: %d\n", pHead->type) ;
        [self sendData:pSrcPkg size:PkgSize];
        return  YES;
    }
    
    BYTE Temp[1024*10] ;
    
    BOOL BigPkg = FALSE ;
    BYTE* pEncrpyBuf = Temp ;
    int  EncrpyBufSize = sizeof(Temp) ;
    if(  PkgSize>=sizeof(Temp)-512 )
    {
        BigPkg = TRUE ;
        pEncrpyBuf = new BYTE[PkgSize+512] ;
        EncrpyBufSize  = PkgSize+512 ;
    }
    
    MDPHead* pCrptyPkg  = (MDPHead*)pEncrpyBuf ;
    BYTE*    pCrptyData = pEncrpyBuf+sizeof(MDPHead) ;
    
    EncrpyBufSize -= sizeof(MDPHead) ;
    self->csm.Encrypt( pSrcPkg, PkgSize, pCrptyData, EncrpyBufSize ) ;
    
    pCrptyPkg->pkgSize = sizeof(MDPHead)+EncrpyBufSize ;
    pCrptyPkg->type    = _MDPType_CMS_EncryptPkg ;
    [self sendData:pEncrpyBuf size:pCrptyPkg->pkgSize];
    BOOL ret =  YES;//m_DataStream.Write( pEncrpyBuf, pCrptyPkg->pkgSize ) ;
    if( BigPkg==TRUE )
    {
        delete [] pEncrpyBuf ;
        pEncrpyBuf = NULL ;
    }
    return ret ;
}

// 连接服务器
- (void)connectToServer {
    CFReadStreamRef readStream = NULL;
    CFWriteStreamRef writeStream = NULL;
    
    // 203.85.34.230:10001
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"203.85.34.230", 10001, &readStream, &writeStream);
    
    self.inputStream = (__bridge NSInputStream*)readStream;
    self.outputStream = (__bridge NSOutputStream*)writeStream;
    
    CFRelease(readStream);
    CFRelease(writeStream);
    
    self.inputStream.delegate = self;
    self.outputStream.delegate = self;
    
    // 添加到 runloop 中
    [self.inputStream scheduleInRunLoop:NSRunLoop.currentRunLoop forMode:NSRunLoopCommonModes];
    [self.outputStream scheduleInRunLoop:NSRunLoop.currentRunLoop forMode:NSRunLoopCommonModes];
    
    // 开启
    [self.inputStream open];
    [self.outputStream open];
    
    // 执行 runloop，以便子线程保活
    NSRunLoop *runloop = NSRunLoop.currentRunLoop;
    [runloop addPort:[[NSMachPort alloc] init] forMode:NSDefaultRunLoopMode];
    [runloop run];
    
    // 添加定时器 执行 ping 操作
    NSDictionary *type = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:-1] forKey:@"TimerType"];
    // TODO: 释放 timer
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(pingTimer:) userInfo:type repeats:YES];
}

// MARK: 客户端挑战
- (BOOL)challengeService {
    [self challenge];
    if (![self.condition waitUntilDate:[NSDate dateWithTimeIntervalSinceNow:15]]) {
        return NO;
    }
    // 二次挑战
    [self challengePass]; // 发送完后应该没有应答
    return YES;
}

// 第一次挑战服务端
- (void)challenge {
    CMS_CLIENT_CHALLENGE_SERVER pkg;
    pkg.PkgSize = sizeof(CMS_CLIENT_CHALLENGE_SERVER) ;
    pkg.Type    = _MDPType_CMS_Client_Challenge_Server ;
    
    CHALLENGE_INFO info ;
    memset( &info, 0, sizeof(info) ) ;
    memcpy( info.HeadMark, "asia", 4 ) ;
    memcpy( info.EndMark, "asia", 4 ) ;
    char key1[50] = {0};
    char key2[50] = {0} ;
    STCWrapperEVP::GenKey( key1 ) ;
    STCWrapperEVP::GenKey( key2 ) ;
    memcpy( info.ChallengeInfo, (LPCSTR)key1, 24 );
    memcpy( info.Key, (LPCSTR)key2, 24 );
    
    int DestSize = sizeof(pkg.EncryptInfo) ;
    self->csm.Encrypt_RSA( (BYTE*)&info, sizeof(info), pkg.EncryptInfo, DestSize ) ;
    self->csm.m_EVP.SetKey( key2 ) ;
    memcpy( (BYTE*)&(self->csm.m_ChallengeInfo), (BYTE*)&info, sizeof(CHALLENGE_INFO) ) ;
    [self sendData:(BYTE*)&pkg size:pkg.PkgSize];
}

// 第二次挑战服务端
- (BOOL) challengePass{
    
    CMS_CLIENT_CHALLENGE_SERVER pkg ;
    pkg.Type    = _MDPType_CMS_ChallengePass ;
    
    int DestSize = sizeof(pkg.EncryptInfo) ;
    self->csm.Encrypt( (BYTE*)&self->csm.m_ChallengeInfo, sizeof(self->csm.m_ChallengeInfo), pkg.EncryptInfo, DestSize ) ;
    pkg.PkgSize = sizeof(CMS_CLIENT_CHALLENGE_SERVER)-sizeof(pkg.EncryptInfo)+DestSize ;
    
    [self sendData:(BYTE*)&pkg size:pkg.PkgSize];
    
    return TRUE;
}

// MARK: ping
- (void)pingTimer:(NSTimer *)timer {
    NSLog(@"%@", timer.userInfo);
    if ([self.lastEventDate timeIntervalSinceNow] > -60) {
        NSLog(@"距离上次steam event 在 60s 内,不需要发送 ping 消息");
        return;
    }
    if (!self.isConnected) {
        return;
    }
    NSLog(@"----ping----");
    RSAHead ping;
    
    ping.PkgSize = sizeof(RSAHead);
    ping.type = _MDPTPT_PingRequest;
    ping.arraySize = -1;
    
    [self sendData:&ping size:sizeof(ping)];
}

- (void)stopRunLoop {
    CFRunLoopStop(CFRunLoopGetCurrent());
    
    // Finish any clean-up tasks here
    
    // Exit the thread
    [self.workingThread cancel];
}

- (void)stopChatSession {
    [self.inputStream close];
    [self.outputStream close];
}


// MARK: NSStreamDelegate
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    self.lastEventDate = [NSDate date];
    switch (eventCode) {
        case NSStreamEventEndEncountered:
            NSLog(@"NSStreamEventEndEncountered");
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"NSStreamEventErrorOccurred");
            [aStream close];
            [aStream removeFromRunLoop:NSRunLoop.currentRunLoop forMode:NSDefaultRunLoopMode];
            break;
        case NSStreamEventHasBytesAvailable:
            NSLog(@"NSStreamEventHasBytesAvailable");
            [self readData];
            break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"NSStreamEventHasSpaceAvailable");
            break;
        case NSStreamEventOpenCompleted:
            // inputStream 和 outputStream 都会调用
            [self.condition signal];
            break;
        default:
            break;
    }
}

// MARK: 读&写数据
/// 向流中写入数据
/// - Parameters:
///   - data: 写入的数据起始地址
///   - size: 写入的数据长度
- (void)sendData:(const void*)data size:(int)size {
    [self.writeBuf appendBytes:data length:size];
    if (![self.outputStream hasSpaceAvailable]) {
        return;
    }
    if (self.writeBuf.length < 0) {
        return;
    }
    
    while (self.outputStream.hasSpaceAvailable) {
        uint8_t* writeBytes = (uint8_t *)[self.writeBuf mutableBytes]; // 使用字节指针指向字节流地址
        writeBytes += _writeByteIndex; // 移动指针到读取位置
        
        // 剩余可写数据与 1024 对比
        NSInteger read_len = MIN(1024, self.writeBuf.length - _writeByteIndex); // 取一段数据读取 1024 /  data_len - _writeByteIndex
        
        // 创建一个字节数组存储要读取的数据
        uint8_t buf[read_len];
        memcpy(buf, writeBytes, read_len); // 将 writeBytes 从当前的读取位置开始，在内存中指定 read_len 长度的数据复制给 buf
        // 向流中写入这段数据 返回写入数据的长度
        NSInteger len = [self.outputStream write:buf maxLength:read_len];
        if (len <= 0) {
            NSLog(@"no more buffer to write");
            break;
        }
        _writeByteIndex += len; // 修改记录指针位置的变量
        // 判断数据是否写完
        if (len >= self.writeBuf.length) {
            NSLog(@"当前数据发送完毕,字节数:%ld", self.writeBuf.length);
            // 清理
            self.writeBuf.length = 0;
            _writeByteIndex = 0;
            
            break;
        }
    }
}


/// 从流中读取数据
- (void)readData {
    // 因为返回的数据包含 header 和 body，所以要先解析 header
    // header 前 4 个字节,表示包大小的值
    
    NSInteger readPkgSize = 0;
    
    // 1.读取 header 的 4 个字节
    if (self.readBuf.length < sizeof(int)) {
        uint8_t head_buf[4];
        while (self.inputStream.hasBytesAvailable && self.readBuf.length < sizeof(int)) {
            // 读取数据到 head_buf，读取的长度是 sizeof(int) - self.readBuf.length
            // 读取成功后会返回实际读取的字节数
            NSInteger len = [self.inputStream read:head_buf maxLength:(sizeof(int) - self.readBuf.length)];
            if (len > 0) {
                [self.readBuf appendBytes:(const void *)head_buf length:len];
                _readByteIndex += len;
            }
        }
        
        // 流中的数据读取完毕或者 header 数据量足够
        if (self.readBuf.length < sizeof(int)) {
            NSLog(@"header 不足 4 个字节");
            return;
        }
        
        // 从 head 中获取整包的字节数
        readPkgSize = *(int *)[self.readBuf mutableBytes]; // 取到该地址里面的值
    }
    
    // 2.读取 body 数据
    while (self.inputStream.hasBytesAvailable) {
        NSInteger left_data_len = readPkgSize - _readByteIndex; // 剩余可读数据
        if (left_data_len < 0) {
            NSLog(@"无更多数据可读");
            break;;
        }
        uint8_t* body_buf = (uint8_t *)malloc(left_data_len * sizeof(uint8_t));
        NSInteger len = [self.inputStream read:body_buf maxLength:left_data_len];
        if (len <= 0) {
            NSLog(@"没有更多数据可读");
            free(body_buf);
            break;
        }
        [self.readBuf appendBytes:body_buf length:len];
        _readByteIndex += len;
        if (self.readBuf.length == readPkgSize) {
            NSLog(@"读取数据完毕:%ld", readPkgSize);
            _readByteIndex = 0;
            break;
        }
    }
    
    // 判断当前缓冲区的数据是否与返回的包大小一致
    if (self.readBuf.length != readPkgSize) {
        // 不一致
        NSLog(@"读取到缓冲区的数据量:ld\n包大小:%ld", self.readBuf.length, readPkgSize);
        // 清空缓冲区
        [self.readBuf resetBytesInRange:NSMakeRange(0, self.readBuf.length)];
        self.readBuf.length = 0;
        _readByteIndex = 0;
        return;
    }
    
    // 一致
    NSLog(@"开始解析缓冲区数据");
    [self procRcvData:self.readBuf];
    // 清空缓冲区
    [self.readBuf resetBytesInRange:NSMakeRange(0, self.readBuf.length)];
    self.readBuf.length = 0;
    _readByteIndex = 0;
}

// MARK: 解析数据
// 全部数据
- (void)procRcvData:(NSMutableData *)data {
    // 前 4 个字节是包大小
    // 然后 2 个字节是类型
    char *pRecvBuf = (char*)[data mutableBytes];
    MDPHead *pHead = (MDPHead*)pRecvBuf;
    
    [self ProcRecPackage:pRecvBuf Size:(pHead->pkgSize)];
}


// 解析 body 数据包
- (void)ProcRecPackage:(char * )pPkgBuf
                   Size:(int)pkgSize {
    MDPHead* pHead = (MDPHead*)pPkgBuf ;
    NSLog( @"ProcRecPackage type: %d\n", (unsigned short)pHead->type) ;
    switch( (unsigned short)pHead->type )
    {
            //////////////////////////////////////////////////////////////////////////////////////////////

        case _MDPType_CMS_Server_Challenge_Client:    // server 挑战信包
            [self Proc_CMS_Server_Challenge_Client:pPkgBuf Size:pkgSize];
            break ;

        case _MDPType_CMS_EncryptPkg:    // 加密包
            [self ProcCMS_EncryptPkg:pPkgBuf Size:pkgSize];
            break ;

        ///< 51000请求包, 51001应答包, 51002推送包
        case 51001:
            [self onProcRcvPackage:pPkgBuf+sizeof(MDPHead)+4 size:*((int*)(pPkgBuf+sizeof(MDPHead)))];
            break;
//        case 51002:
//            [self.externProc onProcRcvPackage:pPkgBuf+sizeof(MDPHead)+4 size:*((int*)(pPkgBuf+sizeof(MDPHead)))];
//            break;
        default:
            break ;
    }
}

// 收到服务端返回的挑战信息
- (BOOL) Proc_CMS_Server_Challenge_Client:(char * )pPkgBuf    Size:(int)pkgSize
{
    // 服务端返回的struct PkgSize Type
    CMS_CLIENT_CHALLENGE_SERVER* pPkg = (CMS_CLIENT_CHALLENGE_SERVER*)pPkgBuf ;
    if( pPkg->Type!=_MDPType_CMS_Server_Challenge_Client )
        return FALSE ;
    
    BYTE temp[1024];
    int tempSize = 1024;
    int dataSize = pPkg->PkgSize-sizeof(int)-sizeof(short); // 得到数据段的大小
    // 对 data 数据解密 到 temp 中
    if (self->csm.Decrypt(pPkg->EncryptInfo, dataSize, temp, tempSize) == FALSE) {
        NSLog(@"数据解密失败");
        return FALSE;
    }
    // 解密后得到 CHALLENGE_INFO
    CHALLENGE_INFO* pCI = (CHALLENGE_INFO *)temp;
    
    // 校验数据
    if( memcmp( pCI->HeadMark, "asia", 4 )!=0 || memcmp( pCI->EndMark, "asia", 4 )!=0 )
    {
        return FALSE ;
    }
    if( memcmp( pCI->ChallengeInfo, self->csm.m_ChallengeInfo.ChallengeInfo, 24 )!=0 )
    {
        return FALSE ;
    }
    
    char NewKey[24] ;
    memset( NewKey, 0, sizeof(NewKey) ) ;
    memcpy( NewKey, pCI->Key, 24 ) ;
    self->csm.m_EVP.SetKey( NewKey ) ; // 设置新的 Key
    memcpy( &(self->csm.m_ChallengeInfo), pCI, sizeof(CHALLENGE_INFO) ) ;
    
    NSLog( @"client Challenge Server OK!\r\n" ) ;
    
    // 告诉线程不用等待
    [self.condition signal];
    
    return TRUE ;
    
}


// 收到服务端返回的加密信息
- (BOOL) ProcCMS_EncryptPkg:(char * )pPkgBuf    Size:(int)pkgSize
{
    MDPHead* pHead = (MDPHead*)pPkgBuf ;
    if( pHead->type!=_MDPType_CMS_EncryptPkg )
        return FALSE ;
    int SrcSize = pHead->pkgSize-sizeof(MDPHead) ;
    if( SrcSize<=0 )
        return FALSE ;
    BYTE* pEncrptData = (BYTE*)(pPkgBuf+sizeof(MDPHead) ) ;
    //if( m_Trader.m_ChallengeStage!=_CS_CHALLENGE_PASS )
    //    return ;
    
    BYTE temp[1024*40] ;
    BYTE *ptmp=NULL;
    
    BOOL isdelete=FALSE;
    int  TempSize =1024*40;
    
    
    if (pkgSize>=(1024*40))
    {
        ptmp = new BYTE[1024*1024];
        TempSize =1024*1023;
        isdelete=TRUE;
        memset(ptmp, 0, 1024*1024);
    }
    
    else
        ptmp = temp;
    
    // Ω‚∞¸.
    if( self->csm.m_EVP.Decrpt( pEncrptData, SrcSize, ptmp, TempSize )==FALSE )
        return FALSE ;
    
    //ProcRecPackage( (char*)temp, TempSize ) ;
    [self ProcRecPackage:(char*)ptmp Size:TempSize];
    
    if (ptmp!=NULL && isdelete)
        delete [] ptmp;
    
    return TRUE ;
}

// 解析应答包
- (void) onProcRcvPackage:(char*)buf size:(int)sz{
    if (buf == NULL || sz <= 0) {
        return;
    }
    NSData *rcvData = [NSData dataWithBytes:buf length:sz];
    
    NSLog(@"收到--%@",[[NSString alloc] initWithData:rcvData encoding:NSUTF8StringEncoding]);
    
    // 解析推送数据
    char *buf1 = (char*)malloc(sz+1);
    memcpy(buf1, [rcvData bytes], sz);
    buf1[sz] = '\0';
    BOOL isPushData = [self parseReceivingData:buf1];
    if (isPushData) {
        return;
    }
    
    // 解析其他数据
    // 发送给代理处理数据
    if (self.delegate && [self.delegate respondsToSelector:@selector(processResponseData:)]) {
        [self.delegate processResponseData:[[NSString alloc] initWithData:rcvData encoding:NSUTF8StringEncoding]];
    }
}

#pragma mark 解析推送数据
-(BOOL)parseReceivingData:(char *)buf{
    NSMutableString *strRes = [[NSMutableString alloc] initWithUTF8String:(const char*)buf];
    if(strRes.length == 0) {
        strRes = [[NSMutableString alloc] initWithFormat:@"%s",(const char*)buf];
    }
    
    if (strRes == nil) {
        strRes = [[NSMutableString alloc] init];
    }
    
    //目前不知道该怎么解才好
    
//    STHttpTradeClass *tC = nil;
    //踢出 - 无对应的类 - 直接发通知
    if([strRes containsString:@"kickoff"]){
        dispatch_async(dispatch_get_main_queue(), ^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_ATrade_UserQuilt object:nil];
        });
        return YES;
    }
    //委托推送
    else if([strRes containsString:@"today_order_notify"]){
        dispatch_async(dispatch_get_main_queue(), ^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_ATrade_Enturst object:nil];
        });
        return YES;
    }
    
    //成交推送
    else if([strRes containsString:@"today_trade_notify"]){
        dispatch_async(dispatch_get_main_queue(), ^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_ATrade_Record object:nil];
        });
        return YES;
    }
    
    //资金推送
    else if([strRes containsString:@"cash_notify"]){
        return YES;
    }
    
    //出入金推送
    else if([strRes containsString:@"cash_io_notify"]){
        return YES;
    }
    return NO;
}

// MARK: Private
// 判断是否连接
- (BOOL)isConnected {
    if (self.inputStream && self.outputStream) {
        return YES;
    }
    return NO;
}
@end
