//
//  WTNetRequest.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/26.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "WTNetRequest.h"

@implementation WTNetRequest {
    AFHTTPSessionManager *manager;
}
+ (WTNetRequest *)sharedInstance {
    static dispatch_once_t onceToken;
    static WTNetRequest *wtnetrequest;
    dispatch_once(&onceToken, ^{
        wtnetrequest = [[WTNetRequest alloc] init];
    });
    return wtnetrequest;
}
- (instancetype)init {
    if (self = [super init]) {
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return self;
}
- (void)postRegistandphone:(NSString *)phone andCheckCode:(NSString *)checkCode andphonemac:(NSString *)maccode andpw:(NSString *)passward androleId:(NSString *)roleId {
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:phone forKey:@"telephone"];
    [dict setObject:checkCode forKey:@"appCode"];
    [dict setObject:maccode forKey:@"telMac"];
    [dict setObject:roleId forKey:@"roleId"];
    [dict setObject:@"0" forKey:@"sex"];
    /*
     MD5
     */
    [dict setObject:[WTMD5 MD5toup32bate:passward] forKey:@"pwd"];
    NSString *postdatajson = [WTCJson dictionaryToJson:dict];
    //[WTBase64 stringTobase64encode:postdatajson]
    [outDict setObject:postdatajson forKey:@"postDate"];
    NSLog(@"%@", [self createRequestUrl:RegistUrl]);
    [manager POST:[self createRequestUrl:RegistUrl] parameters:outDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *body = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [WTCJson dictionaryWithJsonString:body];
        NSLog(@"---%@", dict);//resMsg
        NSDictionary *dictt = [WTCJson dictionaryWithJsonString:[dict objectForKey:@"resDate"]];
        if (self.delegate && [self.delegate conformsToProtocol:@protocol(NetDelegate)]) {
            [self.delegate catchBody:dictt andRecode:[NSString stringWithFormat:@"%@", [dict objectForKey:@"resCode"]] andRemessage:[NSString stringWithFormat:@"%@", [dict objectForKey:@"resMsg"]]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
            NSLog(@"%@", error.userInfo);
            
            if (self.delegate && [self.delegate conformsToProtocol:@protocol(NetDelegate)]) {
                [self.delegate errorBody:error.userInfo];
            }
        }];
}
/*
 获取短信验证
 */
//- (void)getRegistandphone:(NSString *)phone {
//    NSMutableDictionary *outDict = [self makeDict];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [dict setObject:phone forKey:@"telephone"];
//    NSString *postdatastring = [WTCJson dictionaryToJson:dict];
//    [outDict setObject:postdatastring forKey:@"postDate"];
//    [manager GET:[self createRequestUrl:SendMessage] parameters:outDict progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//        NSString *body = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSDictionary *dict = [WTCJson dictionaryWithJsonString:body];
//        NSLog(@"---%@", dict);
//        if (self.delegate && [self.delegate conformsToProtocol:@protocol(NetDelegate)]) {
//            [self.delegate catchBody:dict];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (self.delegate && [self.delegate conformsToProtocol:@protocol(NetDelegate)]) {
//            [self.delegate catchBody:error.userInfo];
//        }
//    }];
//}


//- (void)getRegistWithSuccess:(void (^)(AFHTTPSessionManager *operation, id responseObject))success
//                     failure:(void (^)(AFHTTPSessionManager *operation, NSError *error))failure andphone:(NSString*)phone andCheckCode:(NSString*)checkCode andphonemac:(NSString *)maccode andpw:(NSString *)passward {
//    NSMutableDictionary *outDict = [self makeDict];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [dict setObject:phone forKey:@"telephone"];
//    [dict setObject:checkCode forKey:@"appCode"];
//    [dict setObject:maccode forKey:@"telMac"];
///*
// MD5
// */
//    [dict setObject:[WTMD5 MD5toup32bate:passward] forKey:@"pwd"];
//    NSString *postdatajson = [WTCJson dictionaryToJson:dict];
//    //[WTBase64 stringTobase64encode:postdatajson]
//    [outDict setObject:postdatajson forKey:@"postDate"];
//    [manager POST:[NSString stringWithFormat:@"%@%@", RequestHeader, RegistUrl] parameters:outDict progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error.userInfo);
//    }];
//}
//- (void)getSendMessageWithSuccess:(void(^)(AFHTTPSessionManager *operation, id responseObject))success failure:(void (^)(AFHTTPSessionManager *operation, NSError *error))failure andphone:(NSString*)phone {
//    NSMutableDictionary *outDict = [self makeDict];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [dict setObject:phone forKey:@"telephone"];
//    NSString *postdatastring = [WTCJson dictionaryToJson:dict];
//    [outDict setObject:postdatastring forKey:@"postDate"];
//    [manager GET:[self createRequestUrl:SendMessage] parameters:outDict progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    }];
//}
- (NSString *)createRequestUrl:(NSString *)urls {
    
    return [NSString stringWithFormat:@"%@%@", RequestHeader, urls];
}
- (NSMutableDictionary *)makeDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:AppKEY forKey:@"appKey"];
    [dict setObject:[TimeGet getTimeNow] forKey:@"ts"];
    [dict setObject:@"1" forKey:@"signer"];
    [dict setObject:@"1" forKey:@"deviceType"];
    [dict setObject:@"1" forKey:@"version"];
    [dict setObject:@"2" forKey:@"appType"];
    [dict setObject:@"1" forKey:@"token"];
    [dict setObject:@"1" forKey:@"userId"];
//    [dict setObject:<#(nonnull id)#> forKey:@"postDate"];
    return dict;
}



@end
