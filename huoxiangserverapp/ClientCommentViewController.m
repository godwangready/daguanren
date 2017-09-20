//
//  ClientCommentViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/28.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "ClientCommentViewController.h"
#import "ClientCommentTableViewCell.h"
#import "ServerCommentModel.h"

static NSString *cellid = @"clientCommentcell";
@interface ClientCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *wtTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger indexpage;
@end

@implementation ClientCommentViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (UITableView *)wtTableView {
    if (!_wtTableView) {
        _wtTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, KscreeWidth, KscreeHeight - 84) style:UITableViewStylePlain];
        _wtTableView.delegate = self;
        _wtTableView.dataSource = self;
        _wtTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_wtTableView registerNib:[UINib nibWithNibName:@"ClientCommentTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
        _wtTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
        _wtTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
        _wtTableView.mj_footer.automaticallyHidden = YES;
        [_wtTableView.mj_header beginRefreshing];
    }
    return _wtTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self wtTopViewWithBackString:@"返回-" andTitlestring:@"客户评价"];
    [self.view addSubview:self.wtTableView];
}
- (void) upRefresh {
    if (self.dataSource.count < 20) {
        [self.wtTableView.mj_footer endRefreshing];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:[NSString stringWithFormat:@"%ld", self.indexpage] forKey:@"currentPage"];
    [dict setObject:@"" forKey:@"num"];
    NSMutableDictionary *outDict = [self makeDict];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Usercomment] parameters:outDict success:^(NSDictionary *data) {
        [self.wtTableView.mj_footer endRefreshing];
        NSLog(@"%@", [data objectForKey:@"resDate"]);
        for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
            ServerCommentModel *model = [[ServerCommentModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataSource addObject:model];
            self.indexpage = [[NSString stringWithFormat:@"%@", model.currentPage] integerValue];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.wtTableView reloadData];
        });
    } failure:^(NSError *error) {
        [self.wtTableView.mj_footer endRefreshing];
        [CMMUtility showFailureWith:@"服务器故障"];
    }];

}
- (void) downRefresh {
    [self requestData];
}
- (void)requestData {
    [self.dataSource removeAllObjects];
    [self.wtTableView reloadData];
    self.indexpage = 0;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"" forKey:@"currentPage"];
    [dict setObject:@"" forKey:@"num"];
    NSMutableDictionary *outDict = [self makeDict];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Usercomment] parameters:outDict success:^(NSDictionary *data) {
        [self.wtTableView.mj_header endRefreshing];
        NSLog(@"%@", [data objectForKey:@"resDate"]);
        for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
            ServerCommentModel *model = [[ServerCommentModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataSource addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.wtTableView reloadData];
        });
    } failure:^(NSError *error) {
        [self.wtTableView.mj_header endRefreshing];
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
#pragma mark - delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServerCommentModel *model = self.dataSource[indexPath.row];
    return 110 + [self clientCommentCalculatedHeight:model.content];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClientCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    ServerCommentModel *model = self.dataSource[indexPath.row];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ClientCommentTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", model.userNickName];
    cell.commentLabel.text = [NSString stringWithFormat:@"%@", model.content];
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.userHeadPortrait]]];
    cell.iconImageView.layer.masksToBounds = YES;
    cell.iconImageView.layer.cornerRadius = 3;
    switch ([[NSString stringWithFormat:@"%@", model.star_level] integerValue]) {
        case 0:
        {
            cell.star1.image = [UIImage imageNamed:@"星-拷贝-4"];
            cell.star2.image = [UIImage imageNamed:@"星-拷贝-4"];
            cell.star3.image = [UIImage imageNamed:@"星-拷贝-4"];
            cell.star4.image = [UIImage imageNamed:@"星-拷贝-4"];
            cell.star5.image = [UIImage imageNamed:@"星-拷贝-4"];
        }
            break;
        case 1:
        {
            cell.star1.image = [UIImage imageNamed:@"星"];
            cell.star2.image = [UIImage imageNamed:@"星-拷贝-4"];
            cell.star3.image = [UIImage imageNamed:@"星-拷贝-4"];
            cell.star4.image = [UIImage imageNamed:@"星-拷贝-4"];
            cell.star5.image = [UIImage imageNamed:@"星-拷贝-4"];
        }
            break;
        case 2:
        {
            cell.star1.image = [UIImage imageNamed:@"星"];
            cell.star2.image = [UIImage imageNamed:@"星"];
            cell.star3.image = [UIImage imageNamed:@"星-拷贝-4"];
            cell.star4.image = [UIImage imageNamed:@"星-拷贝-4"];
            cell.star5.image = [UIImage imageNamed:@"星-拷贝-4"];
        }
            break;
        case 3:
        {
            cell.star1.image = [UIImage imageNamed:@"星"];
            cell.star2.image = [UIImage imageNamed:@"星"];
            cell.star3.image = [UIImage imageNamed:@"星"];
            cell.star4.image = [UIImage imageNamed:@"星-拷贝-4"];
            cell.star5.image = [UIImage imageNamed:@"星-拷贝-4"];
        }
            break;
        case 4:
        {
            cell.star1.image = [UIImage imageNamed:@"星"];
            cell.star2.image = [UIImage imageNamed:@"星"];
            cell.star3.image = [UIImage imageNamed:@"星"];
            cell.star4.image = [UIImage imageNamed:@"星"];
            cell.star5.image = [UIImage imageNamed:@"星-拷贝-4"];
        }
            break;
        case 5:
        {
            cell.star1.image = [UIImage imageNamed:@"星"];
            cell.star2.image = [UIImage imageNamed:@"星"];
            cell.star3.image = [UIImage imageNamed:@"星"];
            cell.star4.image = [UIImage imageNamed:@"星"];
            cell.star5.image = [UIImage imageNamed:@"星"];
        }
            break;
            
        default:
            break;
    }
    return cell;
}
- (CGFloat)clientCommentCalculatedHeight:(NSString *)string {
    NSString *messageString1 = [NSString stringWithFormat:@"%@", string];
    CGSize messagesize1 = [messageString1 boundingRectWithSize:CGSizeMake(KscreeWidth - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return messagesize1.height;
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self hideTabBar];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated {
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
