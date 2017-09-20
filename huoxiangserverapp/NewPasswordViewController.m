//
//  NewPasswordViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/21.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "NewPasswordViewController.h"
#import "GetMessageViewController.h"

@interface NewPasswordViewController ()
@property (weak, nonatomic) IBOutlet UIButton *gosetButton;

@end

@implementation NewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.gosetButton.layer.masksToBounds = YES;
    self.gosetButton.layer.cornerRadius = 45 / 2;
    self.passwordTF.secureTextEntry = YES;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)gosetAction:(UIButton *)sender {
    if (_passwordTF.text.length == 0) {
        [CMMUtility showFailureWith:@"请输入密码"];
        return;
    }
    if (_phoneTF.text.length == 0) {
        [CMMUtility showFailureWith:@"请输入手机号"];
        return;
    }
    //6-12位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self.passwordTF.text]) {
        
    }else {
        [CMMUtility showFailureWith:@"密码必须是6到12位字母与数字组成"];
        return;
    }
    GetMessageViewController *getVC = [[GetMessageViewController alloc] init];
    getVC.woshishei = _passwordTF.text;
    getVC.phones = _phoneTF.text;
    [self.navigationController pushViewController:getVC animated:YES];
}
- (IBAction)gobackAction:(UIButton *)sender {
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
