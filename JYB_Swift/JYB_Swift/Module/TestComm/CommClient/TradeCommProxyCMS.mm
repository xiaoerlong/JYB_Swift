//
//  TradeCommProxyCMS.m
//  JYB_Swift
//
//  Created by kim on 2023/8/4.
//

#import "TradeCommProxyCMS.h"
#import "MarketDataProtocol_CMS.h"
#include "WrapperEVP.h"
#include "WrapperRSA.h"
#include "ClientSecurityMng.h"

@implementation TradeCommProxyCMS
- (BOOL) challenge{
    
    CMS_CLIENT_CHALLENGE_SERVER pkg;
    pkg.PkgSize = sizeof(CMS_CLIENT_CHALLENGE_SERVER) ;
    pkg.Type    = _MDPType_CMS_Client_Challenge_Server ;
    
    CHALLENGE_INFO info ;
    memset( &info, 0, sizeof(info) ) ;
//    if([[TradeManager shareTradeManager].Atrade_CurBroker isEqualToString:@"JCF"]) {
//        memcpy( info.HeadMark, "znja", 4 ) ;
//        memcpy( info.EndMark, "znja", 4 ) ;
//    } else if([[TradeManager shareTradeManager].Atrade_CurBroker isEqualToString:@"VLC"]) {
//        memcpy( info.HeadMark, "hasg", 4 ) ;
//        memcpy( info.EndMark, "hasg", 4 ) ;
//    } else {
//        memcpy( info.HeadMark, "asia", 4 ) ;
//        memcpy( info.EndMark, "asia", 4 ) ;
//    }
    memcpy( info.HeadMark, "asia", 4 ) ;
    memcpy( info.EndMark, "asia", 4 ) ;
    char key1[50] = {0};
    char key2[50] = {0} ;
    STCWrapperEVP::GenKey( key1 ) ;
    STCWrapperEVP::GenKey( key2 ) ;
    memcpy( info.ChallengeInfo, (LPCSTR)key1, 24 );
    memcpy( info.Key, (LPCSTR)key2, 24 );
    
    int DestSize = sizeof(pkg.EncryptInfo) ;
//    self.comm.m_CSM->Encrypt_RSA( (BYTE*)&info, sizeof(info), pkg.EncryptInfo, DestSize ) ;
//    self.comm.m_CSM->m_EVP.SetKey( key2 ) ;
//    memcpy( (BYTE*)&(self.comm.m_CSM->m_ChallengeInfo), (BYTE*)&info, sizeof(CHALLENGE_INFO) ) ;
//    
//    [self.comm SendData :(BYTE*)&pkg Size: pkg.PkgSize ];
    
    return TRUE;
}

@end
