//
//  ChangePassWordViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/25.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "ChangePassWordViewController.h"

@interface ChangePassWordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *replaceNewPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UITextField *nowPasswordTF;

@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    self.changeButton.layer.masksToBounds = YES;
    self.changeButton.layer.cornerRadius = 45 / 2;
    self.oldPasswordTF.secureTextEntry = YES;
    self.nowPasswordTF.secureTextEntry = YES;
    self.replaceNewPasswordTF.secureTextEntry = YES;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)changeAction:(UIButton *)sender {
    if (_oldPasswordTF.text.length == 0 || _nowPasswordTF.text.length == 0 || _replaceNewPasswordTF.text.length == 0) {
        [CMMUtility showFailureWith:@"请填写密码"];
        return;
    }
    if (![_nowPasswordTF.text isEqualToString:_replaceNewPasswordTF.text]) {
        [CMMUtility showFailureWith:@"密码不一致"];
        return;
    }
    //WTMD5
    NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [dict setObject:[userid objectForKey:@"telephone"] forKey:@"telephone"];
    [dict setObject:[WTMD5 MD5toup32bate:_oldPasswordTF.text] forKey:@"oldpwd"];
    [dict setObject:[WTMD5 MD5toup32bate:_nowPasswordTF.text] forKey:@"pwd"];
//    [dict setObject:@"2" forKey:@"roleId"];
    NSString *postdatastring = [WTCJson dictionaryToJson:dict];
    [outDict setObject:postdatastring forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:ChangePWWithOdlPW] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", data);
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            [CMMUtility showSucessWith:@"修改成功"];
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error.userInfo);
        [CMMUtility showFailureWith:@"修改失败"];
    }];
}
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nowPasswordTF resignFirstResponder];
    [self.replaceNewPasswordTF resignFirstResponder];
    [self.oldPasswordTF resignFirstResponder];
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
