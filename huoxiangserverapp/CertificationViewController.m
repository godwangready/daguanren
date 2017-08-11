//
//  CertificationViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/25.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "CertificationViewController.h"
#import "CallMeTableViewCell.h"
#import "CertificationModel.h"

static NSString *cellid = @"callcell";
@interface CertificationViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *listTab;
}
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation CertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _datasource = [NSMutableArray arrayWithCapacity:0];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self requestData];
    [self setLayOut];
    // Do any additional setup after loading the view.
}
/*
 {
 auditTime = 1501556726000;
 businessLicense = 8;
 cardId = 8;
 currentPage = 0;
 id = 3;
 identifyStatus = 1;
 identifyVerifyTime = 1501556511000;
 limit = 20;
 maxRows = 5000;
 operatorId = 1;
 pages = 0;
 principalName = 8;
 resMsg = "\U4e0d\U884c";
 start = 0;
 telephone = 8;
 total = 0;
 userId = 9;
 }
 */
- (void) requestData {
    [WTNewRequest postWithURLString:[self createRequestUrl:Credentials] parameters:[self makeDict] success:^(NSDictionary *data) {
        NSDictionary *dictt = [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]];
        CertificationModel *model = [[CertificationModel alloc] init];
        [model setValuesForKeysWithDictionary:dictt];
        [_datasource addObject:model];
        dispatch_async(dispatch_get_main_queue(), ^{
            [listTab reloadData];
        });
        NSLog(@"%@", data);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.userInfo);
    }];
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
    titleLabel.text = @"认证详情";
    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:titleLabel];
    
    listTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20, KscreeWidth, 55 * 5)];
    listTab.delegate = self;
    listTab.dataSource = self;
    listTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [listTab registerNib:[UINib nibWithNibName:@"CallMeTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    listTab.scrollEnabled = NO;
    [self.view addSubview:listTab];
}
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CallMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CallMeTableViewCell" owner:nil options:nil] lastObject];
    }
    if (_datasource.count == 0) {
        return cell;
    }
        CertificationModel *model = [_datasource firstObject];
    NSLog(@"2333%@%@%@", model.principalName, model.telephone, model.cardId);
        switch (indexPath.row) {
            case 0:
                cell.leftLabel.text = @"店主";;
                cell.rightLabel.textAlignment = NSTextAlignmentRight;
                cell.rightLabel.adjustsFontSizeToFitWidth = YES;
                cell.rightLabel.text = model.principalName;
                break;
            case 1:
                cell.leftLabel.text = @"手机号码";
                cell.rightLabel.textAlignment = NSTextAlignmentRight;
                cell.rightLabel.adjustsFontSizeToFitWidth = YES;
                cell.rightLabel.text = model.telephone;
                break;
            case 2:
                cell.leftLabel.text = @"身份证号";
                cell.rightLabel.textAlignment = NSTextAlignmentRight;
                cell.rightLabel.adjustsFontSizeToFitWidth = YES;
                cell.rightLabel.text = model.cardId;
                break;
            case 3:
                cell.leftLabel.text = @"营业执照";
                cell.rightLabel.textAlignment = NSTextAlignmentRight;
                cell.rightLabel.adjustsFontSizeToFitWidth = YES;
                cell.rightLabel.text = model.businessLicense;
                break;
            case 4:
                cell.leftLabel.text = @"认证时间";
                cell.rightLabel.textAlignment = NSTextAlignmentRight;
                cell.rightLabel.adjustsFontSizeToFitWidth = YES;
                cell.rightLabel.text = model.businessLicense;
                break;
            default:
                break;
        }
    cell.leftLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:16];
    cell.leftLabel.textColor = [UIColor colorWithHexString:@"333333"];
    cell.rightLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
    cell.rightLabel.textColor = [UIColor colorWithHexString:@"999999"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
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
#pragma mark - UITableViewDelegate, UITableViewDataSource
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
