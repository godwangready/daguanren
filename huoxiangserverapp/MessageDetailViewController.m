//
//  MessageDetailViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/14.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageTableViewCell.h"
#import "MessageView.h"
#import "MessageModel.h"

static NSString *cellid = @"messagecell";

@interface MessageDetailViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *messageTableView;
}
@property (nonatomic, assign) NSString *indexPage;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MessageDetailViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KscreeWidth / 2) - 50, 30, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [NSString stringWithFormat:@"%@", self.messageType];
    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:titleLabel];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 30, 18)];
    [backButton setImage:[UIImage imageNamed:@"返回-"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20, KscreeWidth, KscreeHeight - 64 - 20)];
    messageTableView.delegate = self;
    messageTableView.dataSource = self;
    messageTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    messageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoadingAction)];
    messageTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoadingAction)];
    [messageTableView.mj_header beginRefreshing];
    [self.view addSubview:messageTableView];
}
- (void) downLoadingAction {
    [self requestData];
}
- (void) upLoadingAction {
    if (self.dataSource.count < 20) {
        [messageTableView.mj_footer endRefreshing];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableDictionary *outDict = [self makeDict];
    [dict setObject:[NSString stringWithFormat:@"%ld", self.indexPage.integerValue + 1] forKey:@"currentPage"];
    [dict setObject:[NSString stringWithFormat:@"%@", self.messageId] forKey:@"typeId"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [outDict setObject:@"store_message_detail" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Messagetype] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", data);
        [messageTableView.mj_footer endRefreshing];
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
                
            }else {
                for (NSDictionary *dict in [data objectForKey:@"resDate"]) {
                    MessageModel *modle = [[MessageModel alloc] init];
                    [modle setValuesForKeysWithDictionary:dict];
                    [self.dataSource addObject:modle];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [messageTableView reloadData];
                });
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
        
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
        [messageTableView.mj_footer endRefreshing];
    }];

}
- (void) requestData {
    self.indexPage = @"";
    [self.dataSource removeAllObjects];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableDictionary *outDict = [self makeDict];
    [dict setObject:@"" forKey:@"currentPage"];
    [dict setObject:[NSString stringWithFormat:@"%@", self.messageId] forKey:@"typeId"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [outDict setObject:@"store_message_detail" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Messagelist] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", data);
        [messageTableView.mj_header endRefreshing];
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
                
            }else {
                for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
                    MessageModel *modle = [[MessageModel alloc] init];
                    [modle setValuesForKeysWithDictionary:dict];
                    [self.dataSource addObject:modle];
                    self.indexPage = [NSString stringWithFormat:@"%@", modle.currentPage];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [messageTableView reloadData];
                });
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }

    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
        [messageTableView.mj_header endRefreshing];
    }];
}
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:nil options:nil] lastObject];
    }
    MessageModel *model = self.dataSource[indexPath.row];
    cell.messageImage.layer.masksToBounds = YES;
    cell.messageImage.layer.cornerRadius = 3;
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", model.title];
    cell.bodyLabel.text = [NSString stringWithFormat:@"%@", model.content];
    [cell.messageImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.pictureUrl]] placeholderImage:[UIImage imageNamed:@"logo"]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageModel *model = self.dataSource[indexPath.row];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:model.msgId forKey:@"msgId"];
    NSMutableDictionary *outDict = [self makeDict];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Message] parameters:outDict success:^(NSDictionary *data) {
        //点击
        //弹出
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kanle" object:nil];
        MessageView *alert = [[MessageView alloc] initWithFrame:CGRectMake(20, 88, KscreeWidth - 40, KscreeHeight - 176)];
        alert.backgroundColor = [UIColor whiteColor];
        alert.layer.masksToBounds = YES;
        alert.layer.cornerRadius = 10;
        alert.titleLabel.text = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"title"]];
        alert.messageLabel.text = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"content"]];
        [alert showInWindowWithMode:CustomAnimationModeDrop];
    } failure:^(NSError *error) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //从数据库中删除
        //刷新UI
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    delete.backgroundColor = [UIColor colorWithHexString:@"ff0000"];
    return @[delete];
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
