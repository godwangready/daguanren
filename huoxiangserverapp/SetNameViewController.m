//
//  SetNameViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/4.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "SetNameViewController.h"

@interface SetNameViewController () {
    
    UIButton *rightButton;
}

@end

@implementation SetNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self HHwtTopViewWithBackString:@"返回-" andTitlestring:@"修改昵称" andrighttitle:@"保存"];
    [self setDownView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) HHwtTopViewWithBackString:(NSString *)backstring andTitlestring:(NSString *)titlestring andrighttitle:(NSString *)titlestrings {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 30, 18)];
    [backButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", backstring]] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(newbackAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KscreeWidth / 2) - 50, 30, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [NSString stringWithFormat:@"%@", titlestring];
    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:titleLabel];
    
    rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake((KscreeWidth - 100 - 20), 30, 100, 20);
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment = NSTextAlignmentRight;
//    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    rightButton.titleLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:16];
//    [rightButton.titleLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
    [rightButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(baserightAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightButton];
}
- (void) setDownView {
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, KscreeWidth, 55)];
    downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:downView];
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, KscreeWidth - 40, 30)];
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    _nameTF.text = [userinfo objectForKey:@"nickName"];
    _nameTF.clearButtonMode = UITextFieldViewModeAlways;
    _nameTF.borderStyle = UITextBorderStyleNone;
    _nameTF.textColor = [UIColor colorWithHexString:@"333333"];
    _nameTF.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    [downView addSubview:_nameTF];
}
- (void) newbackAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) baserightAction {
    rightButton.userInteractionEnabled = NO;
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:[NSString stringWithFormat:@"%@", _nameTF.text] forKey:@"nickName"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"roleId"]] integerValue] == 2) {
        [dict setObject:@"2" forKey:@"roleId"];
    }else {
        [dict setObject:@"3" forKey:@"roleId"];
    }
    [dict setObject:@"" forKey:@"birthday"];
    [dict setObject:@"" forKey:@"signature"];
    [dict setObject:@"0" forKey:@"sex"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Changenickname] parameters:outDict success:^(NSDictionary *data) {
        rightButton.userInteractionEnabled = YES;
        if (([[data objectForKey:@"resCode"] integerValue] == 100)) {
            [CMMUtility showSucessWith:@"修改成功"];
            NSUserDefaults *userionfo = [NSUserDefaults standardUserDefaults];
            [userionfo setObject:[NSString stringWithFormat:@"%@", _nameTF.text] forKey:@"nickName"];
            [userionfo synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:NsNotficationRefreshName object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [CMMUtility showFailureWith:@"修改昵称失败"];
        }
    } failure:^(NSError *error) {
        rightButton.userInteractionEnabled = YES;
        [CMMUtility showFailureWith:@"修改昵称失败"];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
