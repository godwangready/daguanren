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
#import "CallMeViewController.h"
#import "CertificationViewController.h"
#import "NoCertificationViewController.h"
#import "AlreadyCertificationViewController.h"
#import "CertificationIngViewController.h"
#import "LoginViewController.h"
#import "SGLNavigationViewController.h"

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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(uibuttonceshi) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
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
    listTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20, KscreeWidth, 55 * 4)];
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
    return 4;
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
            SetViewController *vc = [[SetViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            case 1:
        {
            SafeViewController *vc = [[SafeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            case 2:
        {
            CallMeViewController *vc =[[CallMeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3: {
//            CertificationViewController *vc = [[CertificationViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
            NSUserDefaults *renzheng = [NSUserDefaults standardUserDefaults];
            switch ([[renzheng objectForKey:CredentialsidentifyStatus] integerValue]) {
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
- (void) uibuttonceshi {
//    ZheXianViewController *vc = [[ZheXianViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    NewPasswordViewController *vc = [[NewPasswordViewController alloc] initWithNibName:@"NewPasswordViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
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
