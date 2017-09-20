//
//  AddServicesViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/14.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "AddServicesViewController.h"
#import "AddServicesTableViewCell.h"
#import "AddServicesModel.h"
#import <AlipaySDK/AlipaySDK.h>

static NSString *cellId = @"addmessagecell";
@interface AddServicesViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *wtTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSString *indexPage;
@end

@implementation AddServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self requestData];
    // Do any additional setup after loading the view.
    [self wtTopViewWithBackString:@"返回-" andTitlestring:@"增值服务"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self.view addSubview:self.wtTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payAction:) name:NsnotificationStartPayServices object:nil];
}
- (UITableView *)wtTableView {
    if (!_wtTableView) {
        _wtTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, KscreeWidth, KscreeHeight - 84)style:UITableViewStylePlain];
        _wtTableView.delegate = self;
        _wtTableView.dataSource = self;
        _wtTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_wtTableView registerNib:[UINib nibWithNibName:@"AddServicesTableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
        _wtTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
        _wtTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
        [_wtTableView.mj_header beginRefreshing];
    }
    return _wtTableView;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (void) payAction:(NSNotification *)notification {
    NSDictionary *dict  = notification.userInfo;
    NSLog(@"%@", dict);
    [[AlipaySDK defaultService] payOrder:@"s" fromScheme:@"s" callback:^(NSDictionary *resultDic) {
        NSLog(@"%@", resultDic);
    }];
}
- (void) downRefresh {
    [self requestData];
}
- (void) upRefresh {
    if (self.dataSource.count < 20) {
        [_wtTableView.mj_footer endRefreshing];
        return;
    }
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict  = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"2" forKey:@"roleId"];
    [dict setObject:[NSString stringWithFormat:@"%ld", self.indexPage.integerValue + 1] forKey:@"currentPage"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Chargestype] parameters:outDict success:^(NSDictionary *data) {
        [_wtTableView.mj_footer endRefreshing];
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
                
            }else {
                for (NSDictionary *dict in [data objectForKey:@"resDate"]) {
                    AddServicesModel *model = [[AddServicesModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataSource addObject:model];
                    self.indexPage = [NSString stringWithFormat:@"%@", model.currentPage];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.wtTableView reloadData];
                });
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        [_wtTableView.mj_footer endRefreshing];

    }];
}
- (void)requestData {
    self.indexPage = @"";
    [self.dataSource removeAllObjects];
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict  = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"2" forKey:@"roleId"];
    [dict setObject:@"" forKey:@"currentPage"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Chargestype] parameters:outDict success:^(NSDictionary *data) {
        [_wtTableView.mj_header endRefreshing];
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
                
            }else {
                for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
                    AddServicesModel *model = [[AddServicesModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataSource addObject:model];
                    self.indexPage = [NSString stringWithFormat:@"%@", model.currentPage];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.wtTableView reloadData];
                });
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
        [_wtTableView.mj_header endRefreshing];

    }];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddServicesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddServicesTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.iconImageView.layer.masksToBounds = YES;
    cell.iconImageView.layer.cornerRadius = 4;
    cell.payButton.layer.masksToBounds = YES;
    cell.payButton.layer.cornerRadius = 2;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self hideTabBar];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
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
