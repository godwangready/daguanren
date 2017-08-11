//
//  WTNewRequest.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/28.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(NSDictionary *data);
typedef void (^FailureBlock)(NSError *error);
@interface WTNewRequest : NSObject
@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailureBlock failureBlock;

/**
 *  发送get请求
 *
 *  @param urlString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)getWithURLString:(NSString *)urlString parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;
/**
 *  发送post请求
 *
 *  @param urlString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)postWithURLString:(NSString *)urlString parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@end
