//
//  WTNetRequest.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/26.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetDelegate <NSObject>

- (void)catchBody:(NSDictionary *)dict andRecode:(NSString *)recode andRemessage:(NSString *)rems;
- (void)errorBody:(NSDictionary *)dict;
//andRemessage:(NSString *)rems
@end

@interface WTNetRequest : NSObject
@property (nonatomic, assign) id<NetDelegate>delegate;
+(WTNetRequest *) sharedInstance;
- (void)postRegistandphone:(NSString*)phone andCheckCode:(NSString*)checkCode andphonemac:(NSString *)maccode andpw:(NSString *)passward androleId:(NSString *)roleId;
//- (void)getRegistandphone:(NSString*)phone;
//- (void)getRegistWithSuccess:(void (^)(AFHTTPSessionManager *operation, id responseObject))success
//                           failure:(void (^)(AFHTTPSessionManager *operation, NSError *error))failure andphone:(NSString*)phone andCheckCode:(NSString*)checkCode andphonemac:(NSString *)maccode andpw:(NSString *)passward;
//- (void)getSendMessageWithSuccess:(void(^)(AFHTTPSessionManager *operation, id responseObject))success failure:(void (^)(AFHTTPSessionManager *operation, NSError *error))failure andphone:(NSString*)phone;
@end
