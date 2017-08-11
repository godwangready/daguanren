//
//  TimeGet.m
//  MiYao
//
//  Created by Homosum on 16/7/15.
//  Copyright © 2016年 JuXiuSheQu. All rights reserved.
//

#import "TimeGet.h"

@implementation TimeGet
+(NSString*)getTimeNow{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return strDate;
}
@end
