//
//  DetailLocationViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/7.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "DetailLocationViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "LocationTableViewCell.h"
#import "LocationModel.h"
#import "PostStoreManageViewController.h"
#import "SGLNavigationViewController.h"
#import "StoreManageViewController.h"
static NSString *cellid = @"locationcell";
@interface DetailLocationViewController ()<AMapSearchDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) AMapSearchAPI *search;
//@property (nonatomic, strong) AMapLocationManager *locationManager;
//@property (nonatomic, strong) CLLocationManager *manager;
//@property (nonatomic, strong) CLLocation *nowCLLocation;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) UITableView *locationTableView;


@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) AMapPOIKeywordsSearchRequest *request;
@end

@implementation DetailLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    // Do any additional setup after loading the view.
    _datasource = [NSMutableArray arrayWithCapacity:0];
    _locationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KscreeWidth, KscreeHeight - 64)];
    _locationTableView.delegate = self;
    _locationTableView.dataSource = self;
    [_locationTableView registerNib:[UINib nibWithNibName:@"LocationTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    _locationTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _locationTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(downLoadAction)];
    [self.view addSubview:_locationTableView];
#pragma mark - map
    
    //IPO
    [AMapServices sharedServices].apiKey = GaoDeKey;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    //默认
    /*
     @“餐饮服务”
     @“商务住宅”
     @“生活服务”
     */
#pragma mark -关键词搜索
        _request = [[AMapPOIKeywordsSearchRequest alloc] init];
        _request.keywords            = @"";
//        _request.city                = @"杭州";
//        _request.types               = @"071400|生活服务|餐饮服务|商务住宅|商务住宅";
        _request.requireExtension    = YES;
        /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
        _request.cityLimit           = YES;
        _request.requireSubPOIs      = YES;
    //距离
//    _request.sortrule = 1;
    //页数
    _request.page = 1;
    //数据量
    _request.offset = 20;
        [self.search AMapPOIKeywordsSearch:_request];
}
- (void) downLoadAction {
    [self setPage];
}
- (void)setPage {
    NSInteger pageIndex = _datasource.count / 20;
    _request.page = 1;
    _request.offset = 20 + 20 * pageIndex;
    _request.keywords            = _tf.text;
    [self.search AMapPOIKeywordsSearch:_request];
}
- (void)setTopView
{
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
        topView.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
        [self.view addSubview:topView];
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 30, 18)];
        [backButton setImage:[UIImage imageNamed:@"返回-"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(searchnewbackAction) forControlEvents:UIControlEventTouchUpInside];
//        [topView addSubview:backButton];
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(15, 25, KscreeWidth - 42 - 30 - 10, 28)];
    _tf.placeholder = @"请输入地址";
//    _tf.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
    _tf.font = [UIFont systemFontOfSize:14];
    _tf.textColor = [UIColor colorWithHexString:@"333333"];
    _tf.delegate = self;
    _tf.borderStyle = UITextBorderStyleRoundedRect;
    [_tf addTarget:self action:@selector(changeTF) forControlEvents:UIControlEventEditingChanged];
    [topView addSubview:_tf];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(KscreeWidth - 42 - 15, 27, 42, 21);
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
//    rightButton.contentHorizontalAlignment = NSTextAlignmentRight;
//    rightButton.contentVerticalAlignment = NSTextAlignmentRight;
    rightButton.titleLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
    [rightButton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
}
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) searchnewbackAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_tf resignFirstResponder];
}
- (void) searchrightAction {
#pragma mark -关键词搜索
    _request.keywords            = _tf.text;
    [self.search AMapPOIKeywordsSearch:_request];
}
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    //周边条数
    //    response.count
    if (_datasource.count != 0) {
        [_datasource removeAllObjects];
    }
    for (AMapPOI *poi in response.pois) {
        NSLog(@"%@", poi.name);
//        [_datasource addObject:poi.name];
        LocationModel *model = [[LocationModel alloc] init];
        model.name = poi.name;
        model.locationstr = poi.address;
        model.province = poi.province;
        model.city = poi.city;
        model.district = poi.district;
        AMapGeoPoint *location = poi.location;
        model.latitudestr = [NSString stringWithFormat:@"%lf", location.latitude];
        model.longitudestr = [NSString stringWithFormat:@"%lf", location.longitude];
        [_datasource addObject:model];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_locationTableView reloadData];
    });
    //    NSArray *arrat2 = response.suggestion.keywords;
    //    NSArray *array3 = response.suggestion.cities;
    NSLog(@"%@", response);
    //解析response获取POI信息，具体解析见 Demo
}
#pragma mark - UITextFieldDelegate
- (void)changeTF {
    [self searchrightAction];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LocationTableViewCell" owner:nil options:nil] lastObject];
    }
    LocationModel *model = _datasource[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.locationLabel.text = [NSString stringWithFormat:@"%@%@%@%@", model.province, model.city, model.district, model.locationstr];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    PostStoreManageViewController *post = [[PostStoreManageViewController alloc] init];
//    SGLNavigationViewController *nav = [[SGLNavigationViewController alloc] initWithRootViewController:post];
//    [self.navigationController ];
    NSArray *temArray = self.navigationController.viewControllers;
    for(UIViewController *temVC in temArray)
    {
        if ([temVC isKindOfClass:[StoreManageViewController class]])
        {
            LocationModel *model = _datasource[indexPath.row];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@%@%@%@", model.province, model.city, model.district, model.locationstr] forKey:@"address"];
            [dict setValue:[NSString stringWithFormat:@"%@", model.latitudestr] forKey:@"lat"];
            [dict setValue:[NSString stringWithFormat:@"%@", model.longitudestr] forKey:@"long"];
            [dict setValue:[NSString stringWithFormat:@"%@", model.locationstr] forKey:@"addressLablel"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NsnotificationDetailAddress object:nil userInfo:dict];
            [self.navigationController popToViewController:temVC animated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
