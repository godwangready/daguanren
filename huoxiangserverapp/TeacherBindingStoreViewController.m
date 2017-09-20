//
//  TeacherBindingStoreViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/18.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "TeacherBindingStoreViewController.h"
#import "TeacherBindingStoreTableViewCell.h"
#import "TeacherDetailBindingViewController.h"
#import "TeacherBindingStoreModel.h"
#define TableViewHeaderH 83
static NSString *cellid = @"teacherbingcell";

@interface TeacherBindingStoreViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic, strong) UITableView *wtTabelView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITextField *searchTF;
@property (nonatomic, assign) NSInteger indexPage;
@property (nonatomic, strong) UILabel *placeHoldLabel;
@end

@implementation TeacherBindingStoreViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (UITableView *)wtTabelView {
    if (!_wtTabelView) {
        _wtTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KscreeWidth, KscreeHeight - 64) style:UITableViewStylePlain];
        _wtTabelView.delegate = self;
        _wtTabelView.dataSource = self;
        [_wtTabelView registerNib:[UINib nibWithNibName:@"TeacherBindingStoreTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
        _wtTabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _wtTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _wtTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
        _wtTabelView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
        [_wtTabelView.mj_header beginRefreshing];
    }
    return _wtTabelView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithHexString:@"f0f2f8"];
    [self wtTopViewWithBackString:@"返回-" andTitlestring:@"绑定店铺"];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.wtTabelView];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, TableViewHeaderH)];
    view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, KscreeWidth - 30, 28)];
    _searchTF.placeholder = @"搜索店铺";
    _searchTF.font = [UIFont systemFontOfSize:16];
    _searchTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.searchTF addTarget:self action:@selector(searchStore) forControlEvents:UIControlEventEditingChanged];
    UILabel *wtLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 12 + 10 + 28, KscreeWidth - 40, 21)];
    wtLabel.text = @"附近的店铺";
    wtLabel.font = [UIFont systemFontOfSize:16];
    wtLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [view addSubview:wtLabel];
    [view addSubview:self.searchTF];
    self.wtTabelView.tableHeaderView = view;
    self.edgesForExtendedLayout=UIRectEdgeNone;
}
- (void) downRefresh {
    [self requestData];
}
- (void) upRefresh {
    if (self.dataSource.count < 20) {
        [self.wtTabelView.mj_footer endRefreshing];
        return;
    }
    NSMutableDictionary *outDict  = [self makeDict];//[NSString stringWithFormat:@"%@", _searchTF.text]
    NSMutableDictionary *dict  = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"" forKey:@"nickName"];
    [dict setObject:@"2" forKey:@"roleId"];
    [dict setObject:[NSString stringWithFormat:@"%ld", _indexPage + 1] forKey:@"currentPage"];
    [dict setObject:@"20" forKey:@"num"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Selectstore] parameters:outDict success:^(NSDictionary *data) {
        [self.wtTabelView.mj_footer endRefreshing];
        NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
        if ([[NSString stringWithFormat:@"%@", [data objectForKey:@"resCode"]] integerValue] == 100) {
            if ([[NSString stringWithFormat:@"%@", [data objectForKey:@"resDate"]] integerValue] == 100) {
                
            }else {
                for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
                    TeacherBindingStoreModel *model = [[TeacherBindingStoreModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataSource addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.wtTabelView reloadData];
                });
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
        [self.wtTabelView.mj_footer endRefreshing];
    }];

}
- (void) searchStore {
    [self requestData];
}
- (void)requestData {
    [self.dataSource removeAllObjects];
    [self.wtTabelView reloadData];
    NSMutableDictionary *outDict  = [self makeDict];//
    NSMutableDictionary *dict  = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:[NSString stringWithFormat:@"%@", self.searchTF.text] forKey:@"nickName"];
    [dict setObject:@"2" forKey:@"roleId"];
    [dict setObject:@"" forKey:@"currentPage"];
    [dict setObject:@"20" forKey:@"num"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [outDict setObject:@"server_bind_list" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Selectstore] parameters:outDict success:^(NSDictionary *data) {
        [self.wtTabelView.mj_header endRefreshing];
        NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
        if ([[NSString stringWithFormat:@"%@", [data objectForKey:@"resCode"]] integerValue] == 100) {
            if ([[NSString stringWithFormat:@"%@", [data objectForKey:@"resDate"]] integerValue] == 100) {
                
            }else {
                for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
                    TeacherBindingStoreModel *model = [[TeacherBindingStoreModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataSource addObject:model];
                    self.indexPage = model.currentPage.integerValue;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.wtTabelView reloadData];
                });
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        [self.wtTabelView.mj_header endRefreshing];
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_searchTF resignFirstResponder];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_searchTF resignFirstResponder];
}
#pragma mark - UITableViewDelegate ,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TeacherBindingStoreModel *model = self.dataSource[indexPath.row];
    TeacherDetailBindingViewController *vc = [[TeacherDetailBindingViewController alloc] initWithNibName:@"TeacherDetailBindingViewController" bundle:nil];
    vc.storeId = [NSString stringWithFormat:@"%@", model.storeId];
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeacherBindingStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TeacherBindingStoreTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.comment1Label.layer.masksToBounds = YES;
    cell.comment1Label.layer.borderWidth = 1;
    cell.comment1Label.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
    cell.comment1Label.layer.cornerRadius = 2;
    cell.comment2Label.layer.borderWidth = 1;
    cell.comment2Label.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
    cell.comment2Label.layer.cornerRadius = 2;
    cell.comment2Label.layer.masksToBounds = YES;
    cell.comment3Label.layer.borderWidth = 1;
    cell.comment3Label.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
    cell.comment3Label.layer.cornerRadius = 2;
    cell.comment3Label.layer.masksToBounds = YES;
    TeacherBindingStoreModel *model = self.dataSource[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", model.storeName];
    [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.pictureUrl]] placeholderImage:[UIImage imageNamed:@"logo"]];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self hideTabBar];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
