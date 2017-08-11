//
//  BindingViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/31.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BindingViewController.h"
#import "BindingTableViewCell.h"
#import "TeacherBindingModel.h"
static NSString *cellid = @"bindingcell";
@interface BindingViewController ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *listTV;
}
@property (nonatomic, assign) NSInteger *index;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation BindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    listTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, KscreeHeight - 84)];
    [listTV registerNib:[UINib nibWithNibName:@"BindingTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    listTV.delegate  =self;
    listTV.dataSource = self;
    listTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    listTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    listTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    listTV.mj_footer.automaticallyHidden = YES;
    [listTV.mj_header beginRefreshing];
    [self.view addSubview:listTV];
    [self requestData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bindingAction:) name:NsnotificationAgreeTeacherBinding object:nil];
}
- (void) bindingAction:(NSNotification *)notification {
    NSDictionary *dictt = notification.userInfo;
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:[dictt objectForKey:@"mainkey"] forKey:@"bindingId"];
    [dict setValue:@"1" forKey:@"bindingStatus"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Bindingstatus] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", data);
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            [CMMUtility showSucessWith:@"绑定成功!"];
            [self requestData];
            [[NSNotificationCenter defaultCenter] postNotificationName:NsnotificationAgreeTeacherBindingSuccess object:nil];
        }else {
            [CMMUtility showFailureWith:@"绑定失败!"];
        }
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"绑定失败!"];
    }];
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (void) downRefresh {
    [self requestData];
}
- (void) upRefresh {
    if (_dataSource.count < 20) {
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
        NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
        for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
            TeacherBindingModel *model = [[TeacherBindingModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataSource addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [listTV reloadData];
        });
        NSLog(@"%@", data);
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)requestData {
    /*
     age = 0;
     bindingStatus = 0;
     currentPage = 0;
     headPortrait = "";
     id = 5;
     isShow = 0;
     limit = 20;
     maxRows = 5000;
     nickName = "";
     pages = 0;
     recommend = 0;
     serverId = 18;
     serverNamer = "";
     start = 0;
     storeId = 9;
     total = 0;
     */
    [self.dataSource removeAllObjects];
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"0" forKey:@"bindingStatus"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:TeacherList] parameters:outDict success:^(NSDictionary *data) {
        [listTV.mj_header endRefreshing];
        NSLog(@"%@", [data objectForKey:@"resDate"]);
                if ([[data objectForKey:@"resCode"] integerValue] == 100) {
                    for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
                        NSLog(@"%@-%@", dict, [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
                        TeacherBindingModel *model = [[TeacherBindingModel alloc] init];
                        [model setValuesForKeysWithDictionary:dict];
                        [_dataSource addObject:model];
                    }
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [listTV reloadData];
                  });
                }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - UITableViewDelegate , UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeacherBindingModel *model = self.dataSource[indexPath.row];
    if (model.bindingStatus.integerValue == 1) {
        BindingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BindingTableViewCell" owner:nil options:nil] lastObject];
        }
        cell.nameLable.text = model.nickName;
        cell.mainkey = model.bindingId;
        cell.agreeButton.layer.masksToBounds = YES;
        cell.agreeButton.layer.cornerRadius = 2;
        cell.agreeButton.backgroundColor = [UIColor whiteColor];
        [cell.agreeButton setTitleColor:[UIColor colorWithHexString:@"cccccc"] forState:UIControlStateNormal];
        [cell.agreeButton setTitle:@"已同意" forState:UIControlStateNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.agreeButton.userInteractionEnabled = NO;
        return cell;
    }
    BindingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BindingTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.nameLable.text = model.nickName;
    cell.mainkey = model.bindingId;
    cell.agreeButton.layer.masksToBounds = YES;
    cell.agreeButton.layer.cornerRadius = 2;
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
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //点击了删除
        TeacherBindingModel *model = self.dataSource[indexPath.row];
        [_dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];//UITableViewRowAnimationAutomatic
        NSMutableDictionary *outDict = [self makeDict];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        [dict setObject:[NSString stringWithFormat:@"%@", model.bindingId] forKey:@"bindingId"];
        [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
        [WTNewRequest postWithURLString:[self createRequestUrl:Hideshow] parameters:outDict success:^(NSDictionary *data) {
            if ([[data objectForKey:@"resCode"] integerValue] == 100) {
                [CMMUtility showSucessWith:@"删除成功"];
            }else {
                [CMMUtility showFailureWith:@"删除失败"];
            }
        } failure:^(NSError *error) {
            [CMMUtility showFailureWith:@"删除失败请检查网络"];
        }];
    }];
    delete.backgroundColor = [UIColor colorWithHexString:@"ff0000"];
    return @[delete];
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
