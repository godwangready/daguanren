//
//  RegistViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "RegistViewController.h"
#import "SetPersentMessageViewController.h"
#import "CMMUtility.h"
#import "LoginViewController.h"

#import "MainViewController.h"
#import "TeacherTabBarController.h"

@interface RegistViewController ()<UITextFieldDelegate, NetDelegate> {
    UIButton *regist;
    UITextField *phoneNumber;
    UITextField *mesageNumber;
    UITextField *passwordNumber;
    UIButton * l_timeButton;
    UIButton *sendPhone;
    UIButton *backButton;
    UIImageView *iconImage;
    
    UIImageView *phoneImage;
    UIImageView *messageImage;
    UIImageView *passWordImage;
    UIView *oneline;
    UIView *twoline;
    UIView *threeline;
    
    UIButton *registed;
    UIButton *nowlogin;
    AFHTTPSessionManager *manager;
}

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [CMMUtility postWait];
    [self layOutRegist];
    // Do any additional setup after loading the view.
}
- (void)layOutRegist {
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 20, 22, 38);
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    iconImage.frame = CGRectMake((KscreeWidth - 75) / 2, 105, 75, 70);
    [self.view addSubview:iconImage];
    
    phoneImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"账号"]];
    phoneImage.frame = CGRectMake((KscreeWidth - 280) / 2, 275 - 17 - 15, 15, 15);
    [self.view addSubview:phoneImage];
    phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(phoneImage.frame.origin.x + 24 + 15, 275 - 10 - 30, 200, 30)];
    phoneNumber.delegate = self;
    phoneNumber.placeholder = @"请输入手机号码";
    phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    [phoneNumber setFont:[UIFont systemFontOfSize:15]];
    [phoneNumber setTextColor:[UIColor colorWithHexString:@"333333"]];
    [self.view addSubview:phoneNumber];
    oneline = [[UIView alloc] initWithFrame:CGRectMake((KscreeWidth - 280) / 2, 275, 280, 1)];
    oneline.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [self.view addSubview:oneline];
    
    messageImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"验证码-"]];
    messageImage.frame = CGRectMake((KscreeWidth - 280) / 2, 325 - 17 - 15, 15, 15);
    [self.view addSubview:messageImage];
    mesageNumber = [[UITextField alloc] initWithFrame:CGRectMake(messageImage.frame.origin.x + 24 + 15, 325 - 10 - 30, 280 - 90 - 15 - 24, 30)];
    mesageNumber.placeholder = @"请输入验证码";
    mesageNumber.delegate =self;
    mesageNumber.keyboardType = UIKeyboardTypeNumberPad;
    [mesageNumber setFont:[UIFont systemFontOfSize:15]];
    [mesageNumber setTextColor:[UIColor colorWithHexString:@"333333"]];
    [self.view addSubview:mesageNumber];
    twoline = [[UIView alloc] initWithFrame:CGRectMake((KscreeWidth - 280) / 2, 325, 280, 1)];
    twoline.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [self.view addSubview:twoline];
    
    passwordNumber = [[UITextField alloc] initWithFrame:CGRectMake((KscreeWidth - 280) / 2 + 24 + 15, 375 - 10 - 30, 200, 30)];
    passwordNumber.placeholder = @"请输入密码";
    passwordNumber.secureTextEntry = YES;
    [passwordNumber setFont:[UIFont systemFontOfSize:15]];
    [passwordNumber setTextColor:[UIColor colorWithHexString:@"333333"]];
    passwordNumber.delegate =self;
    [self.view addSubview:passwordNumber];
    passWordImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"密码"]];
    passWordImage.frame = CGRectMake((KscreeWidth - 280) / 2, 375 - 17 - 15, 15, 15);
    [self.view addSubview:passWordImage];
    threeline = [[UIView alloc] initWithFrame:CGRectMake((KscreeWidth - 280) / 2, 375, 280, 1)];
    threeline.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [self.view addSubview:threeline];
    
    l_timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    l_timeButton.frame = CGRectMake(twoline.frame.origin.x + twoline.frame.size.width - 90, 285, 90, 30);
    [l_timeButton addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchUpInside]; 
    [l_timeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    //设置不可点击
    l_timeButton.userInteractionEnabled = YES;
    l_timeButton.backgroundColor = [UIColor colorWithHexString:@"ff8043"];
    [l_timeButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    l_timeButton.layer.masksToBounds = YES;
    l_timeButton.layer.cornerRadius = 30 / 2;
    [self.view addSubview:l_timeButton];
    
    regist = [UIButton buttonWithType:UIButtonTypeSystem];
    regist.frame = CGRectMake((KscreeWidth - 280 ) / 2, 425, 280, 45);
    regist.layer.masksToBounds = YES;
    regist.layer.cornerRadius = 45 / 2;
    [regist setTitle:@"注册" forState:UIControlStateNormal];
    [regist setBackgroundColor:[UIColor colorWithHexString:@"ff8043"]];
    [regist setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [regist.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [regist addTarget:self action:@selector(goSetMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regist];
    
    registed = [UIButton buttonWithType:UIButtonTypeCustom];
    registed.frame = CGRectMake((KscreeWidth / 2) - 100, KscreeHeight - 40 - 30, 100, 30);
    [registed setTitle:@"已有账号?" forState:UIControlStateNormal];
    [registed setTitleColor:[UIColor colorWithHexString:@"cccccc"] forState:UIControlStateNormal];
    registed.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [registed.titleLabel setFont:[UIFont systemFontOfSize:13]];
    registed.userInteractionEnabled = NO;
    [self.view addSubview:registed];
    nowlogin = [UIButton buttonWithType:UIButtonTypeCustom];
    nowlogin.frame = CGRectMake((KscreeWidth / 2) , KscreeHeight - 40 - 30, 100, 30);
    nowlogin.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [nowlogin setTitle:@"立即登录" forState:UIControlStateNormal];
    [nowlogin setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
    [nowlogin.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [nowlogin addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nowlogin];
}
-(void)startTime{
    if (phoneNumber.text.length == 0) {
        [CMMUtility showFailureWith:@"请填写手机号"];
        return;
    }
    [self getRegistandphone:[NSString stringWithFormat:@"%@", phoneNumber.text]];
    /*
     计时器
     */
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
                [l_timeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                //设置不可点击
                l_timeButton.userInteractionEnabled = YES;
                l_timeButton.backgroundColor = [UIColor colorWithHexString:@"ff8042"];
                
            });
        }else{
            //            int minutes = timeout / 60;    //这里注释掉了，这个是用来测试多于60秒时计算分钟的。
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [l_timeButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                //设置可点击
                l_timeButton.userInteractionEnabled = NO;
                l_timeButton.backgroundColor = [UIColor lightGrayColor];
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
//    [[WTNetRequest sharedInstance] getSendMessageWithSuccess:^(AFHTTPSessionManager *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(AFHTTPSessionManager *operation, NSError *error) {
//    } andphone:@"132"];
    
}
//获取短信验证
- (void)getRegistandphone:(NSString *)phone {
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:phone forKey:@"telephone"];
    NSString *postdatastring = [WTCJson dictionaryToJson:dict];
    [outDict setObject:postdatastring forKey:@"postDate"];
    [manager GET:[self createRequestUrl:SendMessage] parameters:outDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *body = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [WTCJson dictionaryWithJsonString:body];
        NSLog(@"---%@", dict);
        if ([[dict objectForKey:@"resCode"] integerValue] == 100) {
            [CMMUtility showSucessWith:@"验证码发送成功"];
        }else {
            [CMMUtility showFailureWith:@"发送失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [CMMUtility showFailureWith:@""];
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

#pragma mark - textfielddelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"%f", KscreeWidth);
    if (KscreeWidth == 320) {
        [UIView animateWithDuration:.4 animations:^{
            self.view.frame = CGRectMake(0, -200, KscreeWidth, KscreeHeight);
        }];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [phoneNumber resignFirstResponder];
    [mesageNumber resignFirstResponder];
    [passwordNumber resignFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (KscreeWidth == 320) {
        [UIView animateWithDuration:.4 animations:^{
            self.view.frame = CGRectMake(0, 0, KscreeWidth, KscreeHeight);
        }];
    }
    [phoneNumber resignFirstResponder];
    [mesageNumber resignFirstResponder];
    [passwordNumber resignFirstResponder];
}
#pragma mark - Action
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) goLogin {
    LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:login animated:YES];

}
#warning mark - 店家标识 MD5加密
//[dict setObject:[WTMD5 MD5toup32bate:passward] forKey:@"pwd"]
- (void) goSetMessage {
    if (mesageNumber.text.length == 0) {
        [CMMUtility showFailureWith:@"请输入验证码"];
        return;
    }
    if (passwordNumber.text.length == 0) {
        [CMMUtility showFailureWith:@"请设置密码"];
        return;
    }
//    [[UIDevice currentDevice].identifierForVendor UUIDString]
    [[WTNetRequest sharedInstance] postRegistandphone:[NSString stringWithFormat:@"%@",phoneNumber.text] andCheckCode:[NSString stringWithFormat:@"%@", mesageNumber.text] andphonemac:[UIDevice currentDevice].identifierForVendor.UUIDString andpw:[NSString stringWithFormat:@"%@", passwordNumber.text] androleId:_identityID];
    [WTNetRequest sharedInstance].delegate =self;
    regist.userInteractionEnabled = NO;
//    [[WTNetRequest sharedInstance] getRegistWithSuccess:^(AFHTTPSessionManager *operation, id responseObject) {
//        NSString *body = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSDictionary *dict = [WTCJson dictionaryWithJsonString:body];
//        NSLog(@"---%@", dict);
//        regist.userInteractionEnabled = YES;
//    } failure:^(AFHTTPSessionManager *operation, NSError *error) {
//        regist.userInteractionEnabled = YES;
//    } andphone:@"12345678901" andCheckCode:@"9999" andphonemac:@"12" andpw:@"555666777"];
}
#pragma mark - netdelegate
- (void)catchBody:(NSDictionary *)dict andRecode:(NSString *)recode andRemessage:(NSString *)rems{
    NSLog(@"%@",dict);
    regist.userInteractionEnabled = YES;
    if (recode.integerValue == 100) {
//        NSDictionary *dataDict = [WTCJson dictionaryWithJsonString:[dict objectForKey:@"resDate"]];
        NSUserDefaults *userID = [NSUserDefaults standardUserDefaults];
        [userID setObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"userId"]] forKey:@"userid"];
        [userID setObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"appToken"]] forKey:@"apptoken"];
        [userID setObject:phoneNumber.text forKey:@"telephone"];
        [userID setObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"identifyStatus"]] forKey:CredentialsidentifyStatus];
        [userID setObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"nickName"]] forKey:@"nickname"];
        [userID setObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"headPortrait"]] forKey:@"headimage"];
        [userID synchronize];
        
        if (_identityID.integerValue == 2) {
            /*
             跳转商家页面
             */
            [phoneNumber resignFirstResponder];
            [mesageNumber resignFirstResponder];
            [passwordNumber resignFirstResponder];
            MainViewController *mainVC = [[MainViewController alloc] init];
            mainVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//渐入
            //UIModalTransitionStyleFlipHorizontal  旋转
            //UIModalTransitionStyleCoverVertical   从下往上默认
            [mainVC.tabBar setTintColor:[UIColor orangeColor]];
            [mainVC.tabBar setBarTintColor:[UIColor whiteColor]];
            [self presentViewController:mainVC animated:YES completion:nil];
        }
        if (_identityID.integerValue == 3) {
            /*
             跳转技师页面
             */
            TeacherTabBarController *teacher = [[TeacherTabBarController alloc] init];
            teacher.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [teacher.tabBar setTintColor:[UIColor orangeColor]];
            [self presentViewController:teacher animated:YES completion:nil];
        }
    }else {
        [CMMUtility showFailureWith:rems];
        regist.userInteractionEnabled = YES;
    }

}
- (void)errorBody:(NSDictionary *)dict {
    regist.userInteractionEnabled = YES;
    [CMMUtility showFailureWith:@"请检查网络!"];

}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
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
