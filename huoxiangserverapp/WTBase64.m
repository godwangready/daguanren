//
//  WTBase64.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/28.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "WTBase64.h"

@implementation WTBase64
// Create NSData object
+ (NSString *)stringTobase64encode:(NSString *)string {
    NSData *nsdata = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    return base64Encoded;
}

+ (NSString *)dataTobase64decode:(NSString *)string {
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:string options:0];
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    return base64Decoded;
}

@end
