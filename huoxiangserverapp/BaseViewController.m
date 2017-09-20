//
//  BaseViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
//身份证校验
- (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            [CMMUtility showFailureWith:@"请输入有效身份证号码"];
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            [CMMUtility showFailureWith:@"请输入有效身份证号码"];
            return NO;
        }
    }
    return YES;
}
- (void)wtTopViewWithBackString:(NSString *)backstring andTitlestring:(NSString *)titlestring {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 30, 18)];
    [backButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", backstring]] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KscreeWidth / 2) - 50, 30, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [NSString stringWithFormat:@"%@", titlestring];
    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:titleLabel];
}
#pragma mark - 计算高度
- (CGFloat)wtCalculatedHeight:(NSString *)string {
    NSString *messageString1 = [NSString stringWithFormat:@"%@", string];
    CGSize messagesize1 = [messageString1 boundingRectWithSize:CGSizeMake(KscreeWidth - 150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return messagesize1.height;
}

/*
 固参加密
 */
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
//    [dict setObject:@"2" forKey:@"appType"];
    NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *apptoken = [NSUserDefaults standardUserDefaults];
    if ([userid objectForKey:@"userid"]) {
        [dict setObject:[NSString stringWithFormat:@"%@", [userid objectForKey:@"userid"]] forKey:@"userId"];
    }else {
        [dict setObject:@"" forKey:@"userId"];
    }
    if ([apptoken objectForKey:@"apptoken"]) {
        [dict setObject:[NSString stringWithFormat:@"%@", [apptoken objectForKey:@"apptoken"]] forKey:@"token"];

    }else {
        [dict setObject:@"" forKey:@"token"];
    }
    //    [dict setObject:<#(nonnull id)#> forKey:@"postDate"];
    return dict;
}
//base64加密
- (NSString *)encodeBase64Data:(NSData *)data {
    return [data base64EncodedStringWithOptions:NSUTF8StringEncoding];
}
//base64解密
- (NSData *)decodeBase64Data:(NSData *)data {
    return [[NSData alloc] initWithBase64EncodedData:data options:NSUTF8StringEncoding];
}
//同步存储状态, 登录 修改密码 注册
/*
 NSUserDefaults *userID = [NSUserDefaults standardUserDefaults];
 [userID setObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"userId"]] forKey:@"userid"];
 [userID setObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"appToken"]] forKey:@"apptoken"];
 [userID synchronize];
 */

/*
 - (void)viewWillAppear:(BOOL)animated {
 [self.navigationController setNavigationBarHidden:YES animated:NO];
 [self hideTabBar];
 [super viewWillAppear:animated];
 }
 - (void) viewWillDisappear:(BOOL)animated {
 [self.navigationController setNavigationBarHidden:NO animated:YES];
 [self showTabBar];
 [super viewWillDisappear:animated];
 }
 */

//- (void) wtTopViewWithBackString:(NSString *)backstring andTitlestring:(NSString *)titlestring andrighttitle:(NSString *)titlestring {
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
//    topView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:topView];
//    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 30, 18)];
//    [backButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", backstring]] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(newbackAction) forControlEvents:UIControlEventTouchUpInside];
//    [topView addSubview:backButton];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KscreeWidth / 2) - 50, 30, 100, 20)];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = [NSString stringWithFormat:@"%@", titlestring];
//    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
//    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    [topView addSubview:titleLabel];
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake((KscreeWidth - 100 - 20), 30, 100, 20);
//    [rightButton setTitle:@"新增商品" forState:UIControlStateNormal];
//    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
//    rightButton.titleLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:16];
//    [rightButton.titleLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
//    [rightButton addTarget:self action:@selector(baserightAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:rightButton];
//}
//- (void) baserightAction {
//    if (self.delegate && [self.delegate conformsToProtocol:@protocol(BaseVCdelegate)]) {
//        [self.delegate rightAction];
//    }
//}
- (UIImage *)getThumbnailImage:(NSString *)videoPath {
    if (videoPath) {
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath: videoPath] options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        // 设定缩略图的方向
        // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的
        gen.appliesPreferredTrackTransform = YES;
        // 设置图片的最大size(分辨率)
        gen.maximumSize = CGSizeMake(300, 169);
        CMTime time = CMTimeMakeWithSeconds(5.0, 600); //取第5秒，一秒钟600帧
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        if (error) {
            UIImage *placeHoldImg = [UIImage imageNamed:@"posters_default_horizontal"];
            return placeHoldImg;
        }
        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        return thumb;
    } else {
        UIImage *placeHoldImg = [UIImage imageNamed:@"posters_default_horizontal"];
        return placeHoldImg;
    }
}
- (void) newbackAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}
/*
 @计算时间差
 */
- (NSString *)timeToDeadline:(NSString *)timedate {
    NSTimeInterval time= ([timedate doubleValue]+28800) / 1000.0;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,设置需要的格式
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    NSLog(@"%@", currentDateStr);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"%@",currentTimeString);
    
    NSInteger timeDifference = [currentTimeString integerValue] - [currentDateStr integerValue];
    NSString *timeDifferences = [NSString stringWithFormat:@"%ld", timeDifference / 60 / 60];
    if ([timeDifferences integerValue] == 0) {
        timeDifferences = @"刚刚";
        return timeDifferences;
    }
    if ([timeDifferences integerValue] > 24) {
        timeDifferences = [NSString stringWithFormat:@"%ld", [timeDifferences integerValue] % 24];
        timeDifferences = [NSString stringWithFormat:@"%@天前", timeDifferences];
        return timeDifferences;
    }else {
        timeDifferences = [NSString stringWithFormat:@"%@小时前", timeDifferences];
        return timeDifferences;
    }
    //    NSLog(@"%@", timeDifferences);
}

/*
 #pragma mark Keyboard
 -(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo//计算键盘的高度
 {
 CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
 CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
 return keyboardEndingFrame.size.height;
 }
 
 -(void)keyboardWillAppear:(NSNotification *)notification
 {
 CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
 self.fhbButton2SuperY.constant = self.fhbButton2SuperYOrig + change;
 }
 
 
 -(void)keyboardWillDisappear:(NSNotification *)notification
 {
 self.fhbButton2SuperY.constant = self.fhbButton2SuperYOrig;
 }
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
