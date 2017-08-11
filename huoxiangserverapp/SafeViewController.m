//
//  SafeViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/24.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "SafeViewController.h"
#import "ChangePassWordViewController.h"

@interface SafeViewController ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *listTab;
}

@end

@implementation SafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self setLayOut];
    // Do any additional setup after loading the view.
}
- (void)setLayOut {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 30, 18)];
    [backButton setImage:[UIImage imageNamed:@"返回-"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KscreeWidth / 2) - 50, 30, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"安全设置";
    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:titleLabel];
    
    listTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20, KscreeWidth, 55)];
    listTab.delegate = self;
    listTab.dataSource = self;
    listTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    listTab.scrollEnabled = NO;
    [self.view addSubview:listTab];
}
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"修改密码";
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
    ChangePassWordViewController *vc = [[ChangePassWordViewController alloc] initWithNibName:@"ChangePassWordViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
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
