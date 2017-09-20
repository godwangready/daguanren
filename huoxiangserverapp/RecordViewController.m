//
//  RecordViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/31.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordTableViewCell.h"
#import "TeacherListModel.h"

static NSString *cellid = @"recordcell";

@interface RecordViewController ()<UITableViewDelegate , UITableViewDataSource> {
    UITableView *listTV;
}
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    listTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, KscreeHeight - 84)];
    [listTV registerNib:[UINib nibWithNibName:@"RecordTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    listTV.delegate  =self;
    listTV.dataSource = self;
    listTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    listTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    listTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    listTV.mj_footer.automaticallyHidden = YES;
    [listTV.mj_header beginRefreshing];
    [self.view addSubview:listTV];
}
- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray arrayWithCapacity:0];
    }
    return _datasource;
}
- (void) downRefresh {
    [self requestData];
}
- (void) upRefresh {
    if (_datasource.count < 20) {
        [listTV.mj_footer endRefreshing];
        return;
    }
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"1" forKey:@"bindingStatus"];
    [dict setObject:[NSString stringWithFormat:@"%ld", (long)_index + 1] forKey:@"currentPage"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:TeacherList] parameters:outDict success:^(NSDictionary *data) {
        [listTV.mj_footer endRefreshing];
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
        
            }else {
                NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
                for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
                    TeacherListModel *model = [[TeacherListModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.datasource addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [listTV reloadData];
                });
                NSLog(@"%@", data);
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        [listTV.mj_footer endRefreshing];
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
    
}

- (void)requestData {
    [self.datasource removeAllObjects];
    [listTV reloadData];
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"2" forKey:@"bindingStatus"];
    [dict setObject:@"" forKey:@"currentPage"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:TeacherList] parameters:outDict success:^(NSDictionary *data) {
        [listTV.mj_header endRefreshing];
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
        
            }else {
                NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
                for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
                    TeacherListModel *model = [[TeacherListModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.datasource addObject:model];
                    self.index = model.currentPage.integerValue;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [listTV reloadData];
                });
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
        NSLog(@"%@", data);
    } failure:^(NSError *error) {
        [listTV.mj_header endRefreshing];
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate , UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RecordTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.iconImage.layer.masksToBounds = YES;
    cell.iconImage.layer.cornerRadius = 3;
    TeacherListModel *model = self.datasource[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", model.nickName];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.headPortrait]]];
    cell.ageLabel.text = [NSString stringWithFormat:@"%@", model.age];
    if (model.serverNamer == nil) {
        cell.numberLabel.text = @"";
    }else {
        cell.numberLabel.text = [NSString stringWithFormat:@"%@", model.serverNamer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
