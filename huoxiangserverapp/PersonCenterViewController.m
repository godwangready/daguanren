//
//  PersonCenterViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "ZheXianViewController.h"
#import "NewPasswordViewController.h"
#import "SafeViewController.h"
#import "SetViewController.h"
#import "SetServerNameViewController.h"
#import "CallMeViewController.h"
#import "CertificationViewController.h"
#import "NoCertificationViewController.h"
#import "AlreadyCertificationViewController.h"
#import "CertificationIngViewController.h"
#import "LoginViewController.h"
#import "SGLNavigationViewController.h"
#import "NowCertificationViewController.h"
#import "CaoCertificationingViewController.h"

@interface PersonCenterViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *listTab;
    

}
@property (nonatomic, strong) UIButton *quitButton;
@end

@implementation PersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayOut];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
}
- (void)setLayOut {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 30, 18)];
    [backButton setImage:[UIImage imageNamed:@"返回-"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [topView addSubview:backButton];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KscreeWidth / 2) - 50, 30, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"设置";
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    [topView addSubview:titleLabel];
    
//    listTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20, KscreeWidth, 55 * 4) style:UITableViewStylePlain];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"roleId"]] integerValue] == 2) {
        listTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20, KscreeWidth, 55 * 4)];
    }else {
        listTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20, KscreeWidth, 55 * 3 - 1)];
    }
    listTab.delegate = self;
    listTab.dataSource = self;
    listTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    listTab.scrollEnabled = NO;
    [self.view addSubview:listTab];
    
    _quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _quitButton.frame = CGRectMake(0, 84 + 55 * 4 + 50, KscreeWidth, 55);
    _quitButton.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [_quitButton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
    [_quitButton setTitle:@"退出" forState:UIControlStateNormal];
    _quitButton.titleLabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    [_quitButton addTarget:self action:@selector(quitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_quitButton];

}
- (void) quitAction {
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    [userdef setObject:@"" forKey:@"userid"];
    [userdef setObject:@"" forKey:@"apptoken"];
    [userdef setObject:@"" forKey:CredentialsidentifyStatus];
    [userdef setObject:@"" forKey:@"headimage"];
    [userdef setObject:@"" forKey:@"nickName"];
    [userdef synchronize];
    LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    SGLNavigationViewController *nav = [[SGLNavigationViewController alloc] initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"roleId"]] integerValue] == 2) {
        return 4;

    }else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"个人设置";
            break;
        case 1:
            cell.textLabel.text = @"安全设置";
            break;
        case 2:
            cell.textLabel.text = @"联系我们";
            break;
            case 3:
            cell.textLabel.text = @"店家认证";
            break;
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:16];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {

                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                if ([[NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"roleId"]] integerValue] == 2) {
//dianpu
                    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
                    if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 1) {
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        if ([[NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"roleId"]] integerValue] == 2) {
                            SetViewController *vc = [[SetViewController alloc] init];
                            [self.navigationController pushViewController:vc animated:YES];
                        }else {
                            SetServerNameViewController *vc = [[SetServerNameViewController alloc] init];
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }else {
                        if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 2) {
                            
                            CaoCertificationingViewController *vc =[[CaoCertificationingViewController  alloc] init];
                            [self presentViewController:vc animated:YES completion:nil];
                        }else {
                            NowCertificationViewController *vc = [[NowCertificationViewController alloc] initWithNibName:@"NowCertificationViewController" bundle:nil];
                            vc.clanceID = @"0";
                            [self presentViewController:vc animated:YES completion:nil];
                            return;
                        }

                    }
                }else {
//jishi
                    if ([[NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"roleId"]] integerValue] == 2) {
                        SetViewController *vc = [[SetViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }else {
                        SetServerNameViewController *vc = [[SetServerNameViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
//                    SetViewController *vc = [[SetViewController alloc] init];
//                    [self.navigationController pushViewController:vc animated:YES];
                }

        }
            break;
            case 1:
        {
            NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
            if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 1) {
                SafeViewController *vc = [[SafeViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                if ([[NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"roleId"]] integerValue] == 2) {
                    //dianpu
                    if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 2) {
                        
                        CaoCertificationingViewController *vc =[[CaoCertificationingViewController  alloc] init];
                        [self presentViewController:vc animated:YES completion:nil];
                    }else {
                        NowCertificationViewController *vc = [[NowCertificationViewController alloc] initWithNibName:@"NowCertificationViewController" bundle:nil];
                        vc.clanceID = @"0";
                        [self presentViewController:vc animated:YES completion:nil];
                        return;
                    }

                }else {
                    //jishi
                    SafeViewController *vc = [[SafeViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }
            break;
            case 2:
        {
//            NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
//            if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 1) {
                CallMeViewController *vc =[[CallMeViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                
//            }else {
//                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                if ([[NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"roleId"]] integerValue] == 2) {
//                    //dianpu
//                    if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 2) {
//                        
//                        CaoCertificationingViewController *vc =[[CaoCertificationingViewController  alloc] init];
//                        [self presentViewController:vc animated:YES completion:nil];
//                    }else {
//                        NowCertificationViewController *vc = [[NowCertificationViewController alloc] initWithNibName:@"NowCertificationViewController" bundle:nil];
//                        vc.clanceID = @"0";
//                        [self presentViewController:vc animated:YES completion:nil];
//                        return;
//                    }
//
//                    
//                }else {
//                    //jishi
//                }
//            }


        }
            break;
        case 3: {
            [self requestPersonMessageData];
            
        }
            break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
#pragma mark - 个人认证信息
- (void)requestPersonMessageData {
    NSMutableDictionary *dict = [self makeDict];
    [dict setObject:@"store_personal_set" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Credentials] parameters:dict success:^(NSDictionary *data) {
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
                
            }else {
                NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
                switch ([[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"identifyStatus"]] integerValue]) {
                    case 0:
                    {
                        NoCertificationViewController *vc = [[NoCertificationViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                        
                    case 1:
                    {
                        AlreadyCertificationViewController *vc = [[AlreadyCertificationViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case -1:
                    {
                        NoCertificationViewController *vc = [[NoCertificationViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case 2:
                    {
                        CertificationIngViewController *vc = [[CertificationIngViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    default:
                        break;
                }
                NSUserDefaults *renzheng = [NSUserDefaults standardUserDefaults];
                [renzheng setObject:[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"identifyStatus"]] forKey:@"identifyStatus"];
                [renzheng synchronize];
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
        
        
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self showTabBar];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
//    [self hideTabBar];
    [super viewDidDisappear:animated];

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
