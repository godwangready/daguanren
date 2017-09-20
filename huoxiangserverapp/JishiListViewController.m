//
//  JishiListViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/31.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "JishiListViewController.h"
#import "JiShiListTableViewCell.h"
#import "AnotherJishiListTableViewCell.h"
#import "TeacherListModel.h"

static NSString *othercellid = @"othercell";
static NSString *cellid = @"jishilistcell";
@interface JishiListViewController ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *listTV;
}
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation JishiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _datasource = [NSMutableArray arrayWithCapacity:0];
    // Do any additional setup after loading the view.
    listTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, KscreeHeight - 84)];
    [listTV registerNib:[UINib nibWithNibName:@"JiShiListTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    [listTV registerNib:[UINib nibWithNibName:@"AnotherJishiListTableViewCell" bundle:nil] forCellReuseIdentifier:othercellid];
    listTV.delegate  =self;
    listTV.dataSource = self;
    listTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    listTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    listTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    listTV.mj_footer.automaticallyHidden = YES;
    [listTV.mj_header beginRefreshing];
    [self.view addSubview:listTV];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jishituijianAction:) name:NsnotficationJiShiTuiJian object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jishibianhaoAction:) name:NsNotficationJishibianhao object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jishicancletuijianAction:) name:NsnotficationJishiCancleTuijian object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(agreeTeacherBinding) name:NsnotificationAgreeTeacherBindingSuccess object:nil];
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
    [outDict setObject:@"store_server_manage" forKey:@"logView"];
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
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        [listTV.mj_header endRefreshing];
        [CMMUtility showFailureWith:@"服务器故障"];
    }];

}
//- (NSMutableArray *)datasource {
//    if (_datasource) {
//        _datasource = [[NSMutableArray alloc] initWithCapacity:0];
//    }
//    return _datasource;
//}
- (void)requestData {
    [self.datasource removeAllObjects];
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"1" forKey:@"bindingStatus"];
    [dict setObject:@"" forKey:@"currentPage"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [outDict setObject:@"store_server_manage" forKey:@"logView"];
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
    } failure:^(NSError *error) {
        [listTV.mj_header endRefreshing];
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
- (void) agreeTeacherBinding {
    [self requestData];
}
- (void) jishicancletuijianAction:(NSNotification *)userinfo {
    NSLog(@"我取消了推荐");
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:[userinfo.userInfo objectForKey:@"mainkey"] forKey:@"bindingId"];
    [dict setObject:@"0" forKey:@"recommend"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [outDict setObject:@"store_server_manage" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:RecommendTeacher] parameters:outDict success:^(NSDictionary *data) {
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            [CMMUtility showSucessWith:@"取消成功!"];
            [self requestData];
        }else {
            [CMMUtility showFailureWith:@"取消失败!"];
        }
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"取消失败!"];
    }];
}
- (void) jishituijianAction:(NSNotification *)userinfo {
    NSLog(@"我点击了推荐%@", userinfo.userInfo);
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:[userinfo.userInfo objectForKey:@"mainkey"] forKey:@"bindingId"];
    [dict setObject:@"1" forKey:@"recommend"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [outDict setObject:@"store_server_manage" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:RecommendTeacher] parameters:outDict success:^(NSDictionary *data) {
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            [CMMUtility showSucessWith:@"推荐成功!"];
            [self requestData];
        }else {
            [CMMUtility showFailureWith:@"推荐失败!"];
        }
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"推荐失败!"];
    }];
}
- (void) jishibianhaoAction:(NSNotification *)notification {
    NSLog(@"我点击了编号");
    // 1.UIAlertView
    // 2.UIActionSheet
    // iOS8开始:UIAlertController == UIAlertView + UIActionSheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编号" message:@"请为该技师设置编号" preferredStyle:UIAlertControllerStyleAlert];
    // 添加按钮
    __weak typeof(alert) weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"--%@-%@", [weakAlert.textFields.firstObject text], [weakAlert.textFields.lastObject text]);
        [weakAlert.textFields.firstObject resignFirstResponder];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakAlert.textFields.firstObject resignFirstResponder];
        NSMutableDictionary *outDict = [self makeDict];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        [dict setObject:[NSString stringWithFormat:@"%@", [notification.userInfo objectForKey:@"mainkey"]] forKey:@"bindingId"];
        [dict setObject:[NSString stringWithFormat:@"%@", weakAlert.textFields.firstObject.text] forKey:@"serverNamer"];
        [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
        [outDict setObject:@"store_server_manage" forKey:@"logView"];
        [WTNewRequest postWithURLString:[self createRequestUrl:Alterservernamer] parameters:outDict success:^(NSDictionary *data) {
            if ([[data objectForKey:@"resCode"] integerValue] == 100) {
                [CMMUtility showSucessWith:@"修改成功!"];
                [self requestData];
            }else {
                [CMMUtility showFailureWith:@"修改失败!"];
            }
        } failure:^(NSError *error) {
            [CMMUtility showFailureWith:@"修改失败!"];
        }];

    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"其它" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        NSLog(@"点击了其它按钮");
//    }]];
    
    // 添加文本框
//    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.textColor = [UIColor redColor];
//        textField.text = @"123";
//        [textField addTarget:self action:@selector(usernameDidChange:) forControlEvents:UIControlEventEditingChanged];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(usernameDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
//    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.secureTextEntry = YES;
        textField.placeholder = @"编号";
    }];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - UITableViewDelegate , UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeacherListModel *model = self.datasource[indexPath.row];
    if (model.recommend.integerValue == 1) {
        AnotherJishiListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:othercellid];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AnotherJishiListTableViewCell" owner:nil options:nil] lastObject];
        }
        cell.nameLable.text = [NSString stringWithFormat:@"%@", model.nickName];
        cell.ageLable.text = [NSString stringWithFormat:@"%@", model.age];
        if (model.serverNamer == nil) {
            cell.numberLable.text = @"";
        }else {
            cell.numberLable.text = [NSString stringWithFormat:@"%@号", model.serverNamer];
        }
        cell.iconImage.layer.masksToBounds = YES;
        cell.iconImage.layer.cornerRadius = 3;
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.headPortrait]]];
        cell.mainkey = [NSString stringWithFormat:@"%@", model.bindingId];
        cell.cancleTuijian.layer.masksToBounds = YES;
        cell.cancleTuijian.layer.cornerRadius = 2;
        cell.bianhao.layer.masksToBounds = YES;
        cell.bianhao.layer.cornerRadius = 2;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    JiShiListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JiShiListTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.iconImage.layer.masksToBounds = YES;
    cell.iconImage.layer.cornerRadius = 3;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.headPortrait]]];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", model.nickName];
    cell.ageLabel.text = [NSString stringWithFormat:@"%@", model.age];
    if (model.serverNamer == nil) {
        cell.bianhaoLabel.text = @"";
    }else {
        cell.bianhaoLabel.text = [NSString stringWithFormat:@"%@号", model.serverNamer];
    }
//    cell.bianhaoLabel.text = [NSString stringWithFormat:@"%@", model.serverNamer];
    cell.mainkey = [NSString stringWithFormat:@"%@", model.bindingId];
    cell.tuijian.layer.masksToBounds = YES;
    cell.tuijian.layer.cornerRadius = 2;
    cell.bianhao.layer.masksToBounds = YES;
    cell.bianhao.layer.cornerRadius = 2;
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
