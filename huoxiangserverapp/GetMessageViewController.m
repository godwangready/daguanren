//
//  GetMessageViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/21.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "GetMessageViewController.h"
#import "MainViewController.h"
#import "TeacherTabBarController.h"
#import "LoginViewController.h"
#import "SGLNavigationViewController.h"

@interface GetMessageViewController () {
    UIButton *backButton;
    UILabel *messageLabel;
    UITextField *messageTF;
    UIView *lineView;
    UIButton *l_timeButton;
    UIButton *nextstepButton;
}

@end

@implementation GetMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setlayout];
    // Do any additional setup after loading the view.
}
- (void)setlayout {
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 20, 22, 38);
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, KscreeWidth, 30)];
    messageLabel.textColor = [UIColor colorWithHexString:@"ff8042"];
    NSString *phonestr = [NSString stringWithFormat:@"已发送短信验证码到%@", _phones];
    NSString *phoneString = phonestr;//@"已发送短信验证码到12345678901";
    NSMutableAttributedString *atstring = [[NSMutableAttributedString alloc] initWithString:phoneString];
    [atstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"666666"] range:NSMakeRange(0, 9)];//9 11
    messageLabel.attributedText = atstring;
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageTF = [[UITextField alloc] initWithFrame:CGRectMake((KscreeWidth - 280) / 2, 203, 280, 30)];
    messageTF.placeholder = @"请输入验证码";
    [self.view addSubview:messageTF];
    [self.view addSubview:messageLabel];
    lineView = [[UIView alloc] initWithFrame:CGRectMake((KscreeWidth - 280) / 2, 250, 280, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [self.view addSubview:lineView];
    l_timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    l_timeButton.frame = CGRectMake(KscreeWidth - lineView.frame.origin.x - 90, 203, 90, 30);
    [l_timeButton addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchUpInside];
    [l_timeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [l_timeButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    //设置不可点击
    l_timeButton.userInteractionEnabled = YES;
    l_timeButton.backgroundColor = [UIColor colorWithHexString:@"ff8043"];
    l_timeButton.layer.masksToBounds = YES;
    l_timeButton.layer.cornerRadius = 15;
    [self.view addSubview:l_timeButton];
    nextstepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextstepButton.frame = CGRectMake((KscreeWidth - 280) / 2, 300, 280, 45);
    nextstepButton.layer.masksToBounds = YES;
    nextstepButton.layer.cornerRadius = 45 / 2;
    [nextstepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextstepButton setBackgroundColor:[UIColor colorWithHexString:@"ff8043"]];
    [nextstepButton addTarget:self action:@selector(newPassWord) forControlEvents:UIControlEventTouchUpInside];
    [nextstepButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [self.view addSubview:nextstepButton];
}
- (void)newPassWord {
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:_phones forKey:@"telephone"];
    [dict setObject:messageTF.text forKey:@"appCode"];
    [dict setObject:[WTMD5 MD5toup32bate:_woshishei] forKey:@"pwd"];
    [dict setObject:@"2" forKey:@"roleId"];
    NSString *postdatastring = [WTCJson dictionaryToJson:dict];
    [outDict setObject:postdatastring forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Forgetpwd] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", data);
        NSDictionary *dictt = [WTCJson dictionaryWithJsonString:[dict objectForKey:@"resDate"]];
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            SGLNavigationViewController *nav = [[SGLNavigationViewController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:nil];
//            NSDictionary *dataDict = [WTCJson dictionaryWithJsonString:[dict objectForKey:@"resDate"]];
//            NSUserDefaults *userID = [NSUserDefaults standardUserDefaults];
//            [userID setObject:[NSString stringWithFormat:@"%@", [dataDict objectForKey:@"userId"]] forKey:@"userid"];
//            [userID setObject:[NSString stringWithFormat:@"%@", [dataDict objectForKey:@"appToken"]] forKey:@"apptoken"];
//            [userID synchronize];
            /*
             跳转商家页面
             */
//            [messageTF resignFirstResponder];
//            MainViewController *mainVC = [[MainViewController alloc] init];
//            mainVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//渐入
//            //UIModalTransitionStyleFlipHorizontal  旋转
//            //UIModalTransitionStyleCoverVertical   从下往上默认
//            [mainVC.tabBar setTintColor:[UIColor orangeColor]];
//            [mainVC.tabBar setBarTintColor:[UIColor whiteColor]];
//            [self presentViewController:mainVC animated:YES completion:nil];
            
            /*
             跳转技师页面
             */
            //    TeacherTabBarController *teacher = [[TeacherTabBarController alloc] init];
            //    teacher.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            //    [teacher.tabBar setTintColor:[UIColor orangeColor]];
            //    [self presentViewController:teacher animated:YES completion:nil];
        }else {
            [CMMUtility showFailureWith:@"修改失败"];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error.userInfo);
    }];
}
-(void)startTime{
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:_phones forKey:@"telephone"];
    NSString *postdatastring = [WTCJson dictionaryToJson:dict];
    [outDict setObject:postdatastring forKey:@"postDate"];
    [WTNewRequest getWithURLString:[self createRequestUrl:SendMessage] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", data);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
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
                l_timeButton.backgroundColor = [UIColor orangeColor];
                
            });
        }else{
            //            int minutes = timeout / 60;    //这里注释掉了，这个是用来测试多于60秒时计算分钟的。
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [l_timeButton setTitle:[NSString stringWithFormat:@"%@秒后可重新发送",strTime] forState:UIControlStateNormal];
                //设置可点击
                l_timeButton.userInteractionEnabled = NO;
                l_timeButton.backgroundColor = [UIColor lightGrayColor];
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
    
}
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
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
