//
//  WTCJson.h
//  JUXIU_iOS
//
//  Created by Homosum on 16/10/19.
//  Copyright © 2016年 JuXiuSheQu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTCJson : NSObject
+(NSDictionary*)dictionaryWithJsonString:(NSString*)josnString;
+(NSString*)dictionaryToJson:(NSDictionary *)dic;
+(NSString*)encodeString:(NSString*)unencodedString;
+(NSString*)decodeString:(NSString*)encodedString;



@end
