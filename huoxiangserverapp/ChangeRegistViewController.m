//
//  ChangeRegistViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/1.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "ChangeRegistViewController.h"
#import "LoginViewController.h"
#import "RegistViewController.h"

@interface ChangeRegistViewController () {
    UIButton *registed;
    UIButton *nowlogin;
}
@property (weak, nonatomic) IBOutlet UIButton *store;
@property (weak, nonatomic) IBOutlet UIButton *teacher;

@end

@implementation ChangeRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.store.layer.masksToBounds = YES;
    self.store.layer.cornerRadius = 45 / 2;
    self.teacher.layer.masksToBounds = YES;
    self.teacher.layer.cornerRadius = 45 / 2;
    // Do any additional setup after loading the view from its nib.
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
- (void) goLogin {
    LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:login animated:YES];
    
}
- (IBAction)storeAction:(UIButton *)sender {
    RegistViewController *registVC = [[RegistViewController alloc] init];
    registVC.identityID = @"2";
    [self.navigationController pushViewController:registVC animated:YES];
}
- (IBAction)teacherAction:(UIButton *)sender {
    RegistViewController *registVC = [[RegistViewController alloc] init];
    registVC.identityID = @"3";
    [self.navigationController pushViewController:registVC animated:YES];
}
- (IBAction)backAction:(UIButton *)sender {
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
