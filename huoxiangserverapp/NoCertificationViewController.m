//
//  NoCertificationViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/25.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "NoCertificationViewController.h"
#import "NowCertificationViewController.h"
#import "CallMeTableViewCell.h"

static NSString *cellid = @"callcell";
@interface NoCertificationViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView * listTab;
}

@end

@implementation NoCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self wtTopViewWithBackString:@"返回-" andTitlestring:@"店家认证"];
    [self setLayOut];
    // Do any additional setup after loading the view.
}
- (void)setLayOut {
    listTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20, KscreeWidth, 55)];
    listTab.delegate = self;
    listTab.dataSource = self;
    listTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    listTab.scrollEnabled = NO;
    [listTab registerNib:[UINib nibWithNibName:@"CallMeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellid];
    [self.view addSubview:listTab];
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
            cell.leftLabel.text = @"未认证";
            cell.rightLabel.text = @"立即认证";
            cell.rightLabel.textAlignment = NSTextAlignmentRight;
            break;
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.leftLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:16];
    cell.leftLabel.textColor = [UIColor colorWithHexString:@"333333"];
    cell.rightLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
    cell.rightLabel.textColor = [UIColor colorWithHexString:@"666666"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NowCertificationViewController *vc = [[NowCertificationViewController alloc] initWithNibName:@"NowCertificationViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
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
