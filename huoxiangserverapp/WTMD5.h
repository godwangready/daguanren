//
//  WTMD5.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/26.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTMD5 : NSObject
+ (NSString *)MD5tolow32bate:(NSString *)password;
+ (NSString *)MD5toup32bate:(NSString *)password;
@end
