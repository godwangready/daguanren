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

//@property (nonatomic, strong) NSString *name;
//@property (nonatomic, strong) NSString *phone;
//@property (nonatomic, strong) NSString *personcard;
//@property (nonatomic, strong) NSString *bussion;
//@property (nonatomic, strong) NSString *nowtime;
@end

@implementation CertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self requestData];
    [self setLayOut];
    // Do any additional setup after loading the view.
}
- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray arrayWithCapacity:0];
    }
    return _datasource;
}
- (void) requestData {
    [WTNewRequest postWithURLString:[self createRequestUrl:Credentials] parameters:[self makeDict] success:^(NSDictionary *data) {
        NSDictionary *dictt = [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]];
        CertificationModel *model = [[CertificationModel alloc] init];
        [model setValuesForKeysWithDictionary:dictt];
        [self.datasource addObject:model];
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
        CertificationModel *model = [self.datasource firstObject];
        switch (indexPath.row) {
            case 0:
                cell.leftLabel.text = @"店主";;
                cell.rightLabel.textAlignment = NSTextAlignmentRight;
                cell.rightLabel.adjustsFontSizeToFitWidth = YES;
                cell.rightLabel.text = [NSString stringWithFormat:@"%@", model.principalName];
                break;
            case 1:
                cell.leftLabel.text = @"手机号码";
                cell.rightLabel.textAlignment = NSTextAlignmentRight;
                cell.rightLabel.adjustsFontSizeToFitWidth = YES;
                cell.rightLabel.text = [NSString stringWithFormat:@"%@", model.telephone];
                break;
            case 2:
                cell.leftLabel.text = @"身份证号";
                cell.rightLabel.textAlignment = NSTextAlignmentRight;
                cell.rightLabel.adjustsFontSizeToFitWidth = YES;
                cell.rightLabel.text = [NSString stringWithFormat:@"%@", model.cardId];
                break;
            case 3:
                cell.leftLabel.text = @"营业执照";
                cell.rightLabel.textAlignment = NSTextAlignmentRight;
                cell.rightLabel.adjustsFontSizeToFitWidth = YES;
                cell.rightLabel.text = [NSString stringWithFormat:@"%@", model.businessLicense];
                break;
            case 4:
                cell.leftLabel.text = @"认证时间";
                cell.rightLabel.textAlignment = NSTextAlignmentRight;
                cell.rightLabel.adjustsFontSizeToFitWidth = YES;
                cell.rightLabel.text = [NSString stringWithFormat:@"%@", [self timeToDeadline:model.auditTime]];
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
- (NSString *)timeToDeadline:(NSString *)timedate {
    NSTimeInterval time= ([timedate doubleValue]+28800) / 1000.0;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,设置需要的格式
//    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    NSLog(@"%@", currentDateStr);
    return currentDateStr;
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
