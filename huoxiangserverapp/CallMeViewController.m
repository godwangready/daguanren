//
//  CallMeViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/24.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "CallMeViewController.h"
#import "CallMeTableViewCell.h"

static NSString *cellid = @"callcell";
@interface CallMeViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView * listTab;
}

@end

@implementation CallMeViewController

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
    titleLabel.text = @"联系我们";
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];

    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    [topView addSubview:titleLabel];
    
    listTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20, KscreeWidth, 55)];
    listTab.delegate = self;
    listTab.dataSource = self;
    listTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [listTab registerNib:[UINib nibWithNibName:@"CallMeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellid];
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
    CallMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CallMeTableViewCell" owner:nil options:nil] lastObject];
    }
    switch (indexPath.row) {
        case 0:
            cell.leftLabel.textColor = [UIColor colorWithHexString:@"333333"];
            cell.leftLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:16];
            cell.rightLabel.textColor = [UIColor colorWithHexString:@"ff8042"];
            cell.rightLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
            cell.rightLabel.textAlignment = NSTextAlignmentRight;
            cell.leftLabel.text = @"联系电话";
            cell.rightLabel.text = HXtel;
            break;
        default:
            break;
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
           //打电话
            UIWebView *phoneWeb = [[UIWebView alloc] init];
            NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel:%@", HXtel]];
            [phoneWeb loadRequest:[NSURLRequest requestWithURL:url]];
            [self.view addSubview:phoneWeb];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
