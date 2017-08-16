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

static NSString *cellid = @"messagecell";

@interface MessageDetailViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *messageTableView;
}
@property (nonatomic, assign) NSInteger index;

@end

@implementation MessageDetailViewController

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
    titleLabel.text = [NSString stringWithFormat:@"%@", _messageType];
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
    [self.view addSubview:messageTableView];
}
- (void) downLoadingAction {
    [self requestData];
}
- (void) upLoadingAction {
    
}
- (void) requestData {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableDictionary *outDict = [self makeDict];
    [dict setObject:@"" forKey:@"currentPage"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Messagetype] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", data);
    } failure:^(NSError *error) {
        
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
    cell.messageImage.layer.masksToBounds = YES;
    cell.messageImage.layer.cornerRadius = 3;
    cell.nameLabel.text = @"系统消息";
    cell.bodyLabel.text = @"app维护公告";
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //点击
    //弹出
    MessageView *alert = [[MessageView alloc] initWithFrame:CGRectMake(20, 88, KscreeWidth - 40, KscreeHeight - 176)];
    alert.backgroundColor = [UIColor whiteColor];
    alert.layer.masksToBounds = YES;
    alert.layer.cornerRadius = 10;
    alert.titleLabel.text = @"系统消息";
    [alert showInWindowWithMode:CustomAnimationModeDrop];
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
