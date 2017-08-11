//
//  CMMUtility.h
//  JUXIU_iOS
//
//  Created by Homosum on 16/7/20.
//  Copyright © 2016年 JuXiuSheQu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CMMUtility : NSObject
+(void)showNote:(NSString *)content;

+ (void)showNoteWithError:(NSError *)error;

+ (void)showNoteMsgWithError:(NSError *)error;


//postWait
+(void)postWait;
// show temp login view
+(void)showTMPLogin;

// show alert view with delegate and alert String
+(void)showAlertWith:(NSString *)alertStr target:(id)target tag:(int)tag;

+(void)showSucessWith:(NSString*)str;

// show network Indicator
+(void)showWaitingAlertView;

// hide network Indicator
+(void)hideWaitingAlertView;
+(void)showFailureWith:(NSString*)str;
//image转data
+(NSData*)imageConvertToData:(UIImage*)image;

//保存image到本地沙盒
+(void)saveImage:(UIImage*)image andName:(NSString*)imageName;

//从沙盒中取image
+(UIImage*)fetchImageWithName:(NSString*)imageName;
+(UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;
@end
