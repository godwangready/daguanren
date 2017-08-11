//
//  WTNewRequest.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/28.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "WTNewRequest.h"

@implementation WTNewRequest
+ (void)getWithURLString:(NSString *)urlString parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.requestSerializer.timeoutInterval = ;
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        if (successBlock) {
            NSString *body = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *dict = [WTCJson dictionaryWithJsonString:body];
            NSLog(@"---%@", dict);
            NSDictionary *dictt = [WTCJson dictionaryWithJsonString:[dict objectForKey:@"resDate"]];
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            successBlock(dictt);
        }
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { if (failureBlock) {
        failureBlock(error);
        NSLog(@"网络异常 - T_T%@", error);
    }
         }];
    
 
}
+ (void)postWithURLString:(NSString *)urlString parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.requestSerializer.timeoutInterval = outTime;
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 60.f;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        if (successBlock) {
            NSString *body = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *dict = [WTCJson dictionaryWithJsonString:body];
            NSLog(@"---%@", dict);
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            successBlock(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            NSLog(@"网络异常 - T_T%@", error);
        }
    }];
    

    
}
@end
