//
//  ManagemetViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/26.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "ManagemetViewController.h"
#import "AddCommityViewController.h"
#import "ManagementTableViewCell.h"
#import "dadadadadad.h"
#import "ManageModel.h"
static NSString *cellid = @"managementcell";
@interface ManagemetViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *wtTableView;
    
    NSMutableArray *detailArray;
}
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ManagemetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self requestData];
    // Do any additional setup after loading the view.
    self.dataSource = [[NSMutableArray alloc] init];
//    _dataSource = [NSMutableArray arrayWithObjects:@1,@2,@3,@4,@5,@6,@7,@8,@9, nil];
    detailArray = [NSMutableArray arrayWithObjects:@"111111111",@"222222",@"333333",@"44444",@"5555555", nil];
    [self wtTopViewWithBackString:@"返回-" andTitlestring:@"商品管理" andrighttitle:@"新增商品"];
    wtTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20, KscreeWidth, KscreeHeight - 64 - 20)];
    [wtTableView registerNib:[UINib nibWithNibName:@"ManagementTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    wtTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    wtTableView.delegate = self;
    wtTableView.dataSource = self;
    [self.view addSubview:wtTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addproduct) name:NsNotficationAddProduct object:nil];
}
- (void) addproduct {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self requestData];
        NSLog(@"%@", wtTableView);
    });
}
//- (NSMutableArray *)dataSource {
//    if (_dataSource) {
//        _dataSource = [[NSMutableArray alloc] init];
//    }
//    return _dataSource;
//}
- (void)requestData {
    [CMMUtility postWait];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableDictionary *outDict = [self makeDict];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Produclist] parameters:outDict success:^(NSDictionary *data) {
        [CMMUtility hideWaitingAlertView];
        NSLog(@"%@--%@",data, [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
        for (NSDictionary *dicttt in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
            ManageModel *model = [[ManageModel alloc] init];
            [model setValuesForKeysWithDictionary:dicttt];
            [self.dataSource addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [wtTableView reloadData];
        });
    } failure:^(NSError *error) {
        [CMMUtility hideWaitingAlertView];
    }];
}
- (void) wtTopViewWithBackString:(NSString *)backstring andTitlestring:(NSString *)titlestring andrighttitle:(NSString *)righttitle {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 30, 18)];
    [backButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", backstring]] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(newbackAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KscreeWidth / 2) - 50, 30, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [NSString stringWithFormat:@"%@", titlestring];
    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:titleLabel];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake((KscreeWidth - 100 - 20), 30, 100, 20);
    [rightButton setTitle:[NSString stringWithFormat:@"%@", righttitle] forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:16];
    [rightButton.titleLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
    [rightButton addTarget:self action:@selector(baserightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
}
- (void) newbackAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ManagementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];//UITableViewCellStyleDefault
    }
    ManageModel *model = self.dataSource[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", model.productName];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@", model.price];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //弹出
    dadadadadad *alert = [[dadadadadad alloc] initWithFrame:CGRectMake(20, 88, KscreeWidth - 40, KscreeHeight - 176)];
    alert.backgroundColor = [UIColor whiteColor];
    alert.layer.masksToBounds = YES;
    alert.layer.cornerRadius = 10;
    alert.titleLabel.text = [NSString stringWithFormat:@"%@", detailArray[indexPath.row]];
    [alert showInWindowWithMode:CustomAnimationModeDrop];
}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [dataSource removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"下架" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //点击了删除
        ManageModel *model = _dataSource[indexPath.row];
        [_dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];//UITableViewRowAnimationAutomatic
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        NSMutableDictionary *outDict = [self makeDict];
        [dict setObject:model.productId forKey:@"productId"];
        [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
        [WTNewRequest postWithURLString:[self createRequestUrl:Deleteproduct] parameters:outDict success:^(NSDictionary *data) {
            NSLog(@"%@", data);
            if ([[data objectForKey:@"resCode"] integerValue] == 100) {
                [CMMUtility showSucessWith:@"删除成功"];
            }
        } failure:^(NSError *error) {
            
        }];
    }];
    delete.backgroundColor = [UIColor colorWithHexString:@"ff0000"];
    UITableViewRowAction *change = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        ManageModel *model = _dataSource[indexPath.row];
        AddCommityViewController *vc = [[AddCommityViewController alloc] init];
        vc.productID = model.productId;
        [self.navigationController pushViewController:vc animated:YES];
//        change.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    }];
    change.backgroundColor = [UIColor colorWithHexString:@"ff8042"];
    return @[delete, change];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self hideTabBar];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated {
    [CMMUtility hideWaitingAlertView];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self showTabBar];
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)baserightAction {
    AddCommityViewController *vc = [[AddCommityViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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