//
//  SetViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/24.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "SetViewController.h"
#import "CallMeTableViewCell.h"
#import "SetNameViewController.h"

static NSString *cellid = @"callcell";
@interface SetViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *listTab;
}

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self setLayOut];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshname) name:NsNotficationRefreshName object:nil];
}
- (void) refreshname {
    [listTab reloadData];
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
    titleLabel.text = @"个人设置";
    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];

    [topView addSubview:titleLabel];
    
    listTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20, KscreeWidth, 55)];
    listTab.delegate = self;
    listTab.dataSource = self;
    listTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    listTab.scrollEnabled = NO;
    [listTab registerNib:[UINib nibWithNibName:@"CallMeTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
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
    CallMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CallMeTableViewCell" owner:nil options:nil] lastObject];
    }
    switch (indexPath.row) {
        case 0:{
            NSUserDefaults *userID = [NSUserDefaults standardUserDefaults];//nickname
            cell.leftLabel.text = @"昵称";
            cell.rightLabel.text = [userID objectForKey:@"nickname"];
            cell.rightLabel.textAlignment = NSTextAlignmentRight;
            cell.leftLabel.textColor = [UIColor colorWithHexString:@"333333"];
            cell.leftLabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
            cell.rightLabel.textColor = [UIColor colorWithHexString:@"666666"];
            cell.rightLabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:14];
        }
            break;
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
            SetNameViewController *vc = [[SetNameViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {

        }
            break;
        default:
            break;
    }
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
