//
//  WTBase64.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/28.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTBase64 : NSObject

+ (NSString *)stringTobase64encode:(NSString *)string;
+ (NSString *)dataTobase64decode:(NSString *)string;
@end
