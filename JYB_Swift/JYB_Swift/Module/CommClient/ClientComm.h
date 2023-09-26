//
//  ClientComm.h
//  JYB_Swift
//
//  Created by kim on 2023/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ClientCommDelegate  <NSObject>

// 处理服务器返回的数据
- (void)processResponseData:(NSString *)recStr;

@end



/// 客户端通信类 只用于处理与服务端的通信
@interface ClientComm : NSObject

@property (nonatomic, weak) id<ClientCommDelegate> delegate;

// 发送消息
- (void)sendMessage:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
