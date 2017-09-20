//
//  BaseViewController.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol BaseVCdelegate <NSObject>
//
//- (void)rightAction;
//
//@end
@interface BaseViewController : UIViewController
//@property (nonatomic, assign)id<BaseVCdelegate>delegate;
- (void) hideTabBar;
- (void) showTabBar;
- (void) wtTopViewWithBackString:(NSString *)backstring andTitlestring:(NSString *)titlestring;
//- (void) wtTopViewWithBackString:(NSString *)backstring andTitlestring:(NSString *)titlestring andrighttitle:(NSString *)titlestring;
- (NSString *)createRequestUrl:(NSString *)urls;
- (NSMutableDictionary *)makeDict;

//base64编码
- (NSString *)encodeBase64Data:(NSData *)data;
//base64解码
- (NSData *)decodeBase64Data:(NSData *)data;
//计算文字高度 字号14
- (CGFloat)wtCalculatedHeight:(NSString *)string;
//获取视频的缩略图
- (UIImage *)getThumbnailImage:(NSString *)videoPath;
//身份证校验
- (BOOL)judgeIdentityStringValid:(NSString *)identityString;
@end
