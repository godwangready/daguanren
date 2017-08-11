//
//  CMMUtility.m
//  JUXIU_iOS
//
//  Created by Homosum on 16/7/20.
//  Copyright © 2016年 JuXiuSheQu. All rights reserved.
//

#import "CMMUtility.h"
#import <SVProgressHUD.h>
#import "UIColor+Hex.h"



#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
@implementation CMMUtility

+ (void)showNoteWithError:(NSError *)error {
    
    
    
    NSString *errorMsg = [error.userInfo objectForKey:kNetWorErrorMsg];
    NSLog(@"%@",errorMsg);
    
    if (!QM_IS_STR_NIL(errorMsg)) {
        UIAlertView *alertInstance  = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertInstance show];
        
        
        
        
    }
}

//不可以购买时显示的错误信息提示
+ (void)showNoteMsgWithError:(NSError *)error {
    NSString *errorMsg = [error.userInfo objectForKey:kNetWorErrorMsg];
    [SVProgressHUD showErrorWithStatus:errorMsg];
}

+(void)showNote:(NSString *)alertContent
{
    [self hideWaitingAlertView];

    UIAlertView *alertInstance  = [[UIAlertView alloc] initWithTitle:@"提示" message:alertContent delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertInstance show];
    
    
    
    
    
}

+(void)showTMPLogin {
    //    [[AppDelegate appDelegate] handleUserNotNotLoginError];
}

+(void)showAlertWith:(NSString *)alertStr target:(id)target tag:(int)tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:alertStr delegate:target cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = tag;
    alertView.delegate = target;
    [alertView show];
}

+ (void)showSuccessMessage:(NSString *)message {
    [SVProgressHUD showSuccessWithStatus:message];
}


+(void)showWaitingAlertView
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:@"#4F6852"]];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD show];
    
    
}

+(void)hideWaitingAlertView
{
    

    [SVProgressHUD dismiss];
}
+(NSData*)imageConvertToData:(UIImage *)image
{
    NSData*data;
    if (UIImagePNGRepresentation(image) == nil) {
        
        data = UIImageJPEGRepresentation(image, 1);
         NSLog(@"存1data%@",data);
    } else {
        
        data = UIImagePNGRepresentation(image);
         NSLog(@"存2data%@",data);
    }
      NSLog(@"存0data%@",data);
    return data;
}
+(void)saveImage:(UIImage *)image andName:(NSString *)imageName
{
    NSData*data=[self imageConvertToData:image];
    NSString*directioyPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString*dataPath=[directioyPath stringByAppendingString:[NSString stringWithFormat:@"%@.dat",imageName]];
    NSLog(@"datapath1%@",dataPath);
    NSLog(@"存data%@",data);
//   BOOL isSuccess=[data writeToFile:dataPath atomically:YES];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:imageName];
//    NSLog(@"%d",isSuccess);
    
    
}
+(UIImage*)fetchImageWithName:(NSString*)imageName
{
    NSString*directioyPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString*dataPath=[directioyPath stringByAppendingString:[NSString stringWithFormat:@"%@.dat",imageName]];
     NSLog(@"datapath2%@",dataPath);
//    NSData*data=[NSData dataWithContentsOfFile:dataPath];
    NSData*data=[[NSUserDefaults standardUserDefaults] objectForKey:imageName];
//     NSLog(@"取data%@",data);
    return [self dataConvertToImage:data];
}
+(UIImage*)dataConvertToImage:(NSData*)data
{
    return [[UIImage alloc] initWithData:data];
}
+(void)postWait
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:@"#4F6852"]];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
       [SVProgressHUD show];
}
+(void)showSucessWith:(NSString *)str
{
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD showSuccessWithStatus:str];
}
+(void)showFailureWith:(NSString*)str
{
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD showErrorWithStatus:str];

}
+(UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
