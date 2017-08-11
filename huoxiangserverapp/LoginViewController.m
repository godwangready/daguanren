//
//  LoginViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "LoginViewController.h"
#import "WTSafe.h"
#import "SetPersentMessageViewController.h"
#import "RegistViewController.h"
#import "NewPasswordViewController.h"
#import <AFNetworking.h>
#import "WTCJson.h"
#import "MainViewController.h"
#import "TeacherTabBarController.h"
#import "ChangeRegistViewController.h"
@interface LoginViewController ()<UITextFieldDelegate> {
    AFHTTPSessionManager *manager;
}
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetButton;
@property (weak, nonatomic) IBOutlet UIButton *nowRegist;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 45 / 2;
    self.forgetButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.nowRegist.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTF.delegate = self;
    self.passWordTF.delegate = self;
    self.passWordTF.secureTextEntry = YES;
//    self.forgetButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    self.nowRegist.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    // Do any additional setup after loading the view from its nib.
}
//登录
- (IBAction)loginAction:(UIButton *)sender {
    if (_phoneTF.text.length != 0 && _passWordTF.text.length != 0) {
        if (_passWordTF.text.length >= 8 && _passWordTF.text.length <= 16) {
            //请求
        }else {
            [CMMUtility showFailureWith:@"请正确填写信息"];
        }
    }else {
        [CMMUtility showNote:@"请完整填写信息"];
    }
    [self postLoginandphone:[NSString stringWithFormat:@"%@", _phoneTF.text] andpw:[NSString stringWithFormat:@"%@", _passWordTF.text]];
}
#warning mark - 永远登录
//login
- (void)postLoginandphone:(NSString *)phone andpw:(NSString *)passward {
    
//    [_phoneTF resignFirstResponder];
//    [_passWordTF resignFirstResponder];
//    MainViewController *mainVC = [[MainViewController alloc] init];
//    mainVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//渐入
//    //UIModalTransitionStyleFlipHorizontal  旋转
//    //UIModalTransitionStyleCoverVertical   从下往上默认
//    [mainVC.tabBar setTintColor:[UIColor orangeColor]];
//    [mainVC.tabBar setBarTintColor:[UIColor whiteColor]];
//    [self presentViewController:mainVC animated:YES completion:nil];
//    return;
    
    _loginButton.userInteractionEnabled = NO;
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:phone forKey:@"telephone"];
    /*
     MD5
     */
    [dict setObject:[WTMD5 MD5toup32bate:passward] forKey:@"pwd"];
    [dict setObject:@"2" forKey:@"roleId"];
    NSString *postdatajson = [WTCJson dictionaryToJson:dict];
    //[WTBase64 stringTobase64encode:postdatajson]
    [outDict setObject:postdatajson forKey:@"postDate"];
    [manager POST:[self createRequestUrl:LoginUrl] parameters:outDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _loginButton.userInteractionEnabled = YES;
        NSString *body = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [WTCJson dictionaryWithJsonString:body];
        NSLog(@"---%@", dict);
        if ([[dict objectForKey:@"resCode"] integerValue] == 100) {
            NSDictionary *dataDict = [WTCJson dictionaryWithJsonString:[dict objectForKey:@"resDate"]];
            NSUserDefaults *userID = [NSUserDefaults standardUserDefaults];
//            NSUserDefaults *renzheng = [NSUserDefaults standardUserDefaults];
            [userID setObject:_phoneTF.text forKey:@"telephone"];
            //保存用户状态参数
            [userID setObject:[NSString stringWithFormat:@"%@", [dataDict objectForKey:@"identifyStatus"]] forKey:CredentialsidentifyStatus];
//            [renzheng setObject:[NSString stringWithFormat:@"%@", [dataDict objectForKey:@"identifyStatus"]] forKey:CredentialsidentifyStatus];
            [userID setObject:[NSString stringWithFormat:@"%@", [dataDict objectForKey:@"userId"]] forKey:@"userid"];
            [userID setObject:[NSString stringWithFormat:@"%@", [dataDict objectForKey:@"appToken"]] forKey:@"apptoken"];
            [userID setObject:[NSString stringWithFormat:@"%@", [dataDict objectForKey:@"nickName"]] forKey:@"nickname"];
            [userID synchronize];
            if ([[dataDict objectForKey:@"roleId"] integerValue] == 2) {
                /*
                 跳转商家页面
                 */
                [_phoneTF resignFirstResponder];
                [_passWordTF resignFirstResponder];
                MainViewController *mainVC = [[MainViewController alloc] init];
                mainVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//渐入
                //UIModalTransitionStyleFlipHorizontal  旋转
                //UIModalTransitionStyleCoverVertical   从下往上默认
                [mainVC.tabBar setTintColor:[UIColor colorWithHexString:@"ff8042"]];
                [mainVC.tabBar setBarTintColor:[UIColor whiteColor]];
                [self presentViewController:mainVC animated:YES completion:nil];
            }
            if ([[dataDict objectForKey:@"roleId"] integerValue] == 3) {
                /*
                 跳转技师页面
                 */
                    TeacherTabBarController *teacher = [[TeacherTabBarController alloc] init];
                    teacher.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    [teacher.tabBar setTintColor:[UIColor colorWithHexString:@"ff8042"]];
                    [self presentViewController:teacher animated:YES completion:nil];
            }
        }else {//resMeg
            [CMMUtility showFailureWith:[dict objectForKey:@"resMsg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _loginButton.userInteractionEnabled = YES;
        NSLog(@"%@", error.userInfo);
        [CMMUtility showFailureWith:@"请检查网络!"];
       
    }];
}
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
    [dict setObject:@"2" forKey:@"appType"];
    [dict setObject:@"1" forKey:@"token"];
    [dict setObject:@"1" forKey:@"userId"];
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
- (IBAction)forgetPassword:(UIButton *)sender {
    NewPasswordViewController *newVC = [[NewPasswordViewController alloc] initWithNibName:@"NewPasswordViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:newVC animated:YES];
}
- (IBAction)registAction:(UIButton *)sender {
    ChangeRegistViewController *vc = [[ChangeRegistViewController alloc] initWithNibName:@"ChangeRegistViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if (textField == _phoneTF) {
//        if (_phoneTF.text.length != 11) {
//            [CMMUtility showFailureWith:@"请正确输入手机号码"];
//        }
//    }else {
//        if (_passWordTF.text.length < 8 || _passWordTF.text.length > 16) {
//            [CMMUtility showFailureWith:@"请正确输入密码"];
//        }
//    }
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}
/*
 NSTimeInterval animationDuration = 0.30f;
 [UIView beginAnimations:@"BigLine" context:nil];
 [UIView setAnimationDuration:animationDuration];
 //恢复屏幕
 self.lineLabel1.frame=CGRectMake(10, 250, kScreen_Width-20, 2);
 self.lineLabel1.backgroundColor=[UIColor lightGrayColor];
 [UIView commitAnimations];
 [UIView setAnimationsEnabled:YES];
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneTF resignFirstResponder];
    [self.passWordTF resignFirstResponder];
}
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
