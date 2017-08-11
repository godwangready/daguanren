//
//  BaseViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
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
