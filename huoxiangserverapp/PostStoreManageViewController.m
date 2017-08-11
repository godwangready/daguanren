//
//  PostStoreManageViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/1.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "PostStoreManageViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DetailLocationViewController.h"
#import "LocationListView.h"
#import "LocationTableViewCell.h"
#import "LocationModel.h"

static NSString *cellid = @"locationcell";
@interface PostStoreManageViewController ()<AMapSearchDelegate, CLLocationManagerDelegate, AMapLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CLLocation *nowCLLocation;

@property (nonatomic, strong) NSMutableArray *datasource;

@property (nonatomic, strong) LocationListView *alert;

@property (nonatomic, strong) UITableView *locationlistTableView;
@property (nonatomic, strong) UITextField *searchLocationTF;

@property (nonatomic, strong) AMapPOIAroundSearchRequest *request;
@end

@implementation PostStoreManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _datasource = [NSMutableArray arrayWithCapacity:0];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self wtTopViewWithBackString:@"返回-" andTitlestringsss:@"地图"];
    
    //弹出
    _alert = [[LocationListView alloc] initWithFrame:CGRectMake(20, 88, KscreeWidth - 40, KscreeHeight - 176)];
    _alert.backgroundColor = [UIColor whiteColor];
    _alert.layer.masksToBounds = YES;
    _alert.layer.cornerRadius = 10;
    _alert.LocationListTableView.delegate = self;
    _alert.LocationListTableView.dataSource = self;
//    [_alert showInWindowWithMode:CustomAnimationModeAlert];
    
    _searchLocationTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, KscreeWidth - 20, 28)];
    _searchLocationTF.text = @"搜索地点";
    _searchLocationTF.delegate = self;
    _searchLocationTF.textColor = [UIColor colorWithHexString:@"999999"];
    _searchLocationTF.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
    _searchLocationTF.textAlignment = NSTextAlignmentCenter;
    _searchLocationTF.borderStyle = UITextBorderStyleRoundedRect;
    _searchLocationTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_searchLocationTF];
#pragma mark - 定位 高德
//    [AMapServices sharedServices].apiKey = GaoDeKey;
//    // 带逆地理信息的一次定位（返回坐标和地址信息）
//    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
//    //   定位超时时间，最低2s，此处设置为2s
//    self.locationManager.locationTimeout =5;
//    //   逆地理请求超时时间，最低2s，此处设置为2s
//    self.locationManager.reGeocodeTimeout = 5;
    /*
     高精度定位
     */
    // 带逆地理信息的一次定位（返回坐标和地址信息）
//        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//        //   定位超时时间，最低2s，此处设置为10s
//        self.locationManager.locationTimeout =10;
//        //   逆地理请求超时时间，最低2s，此处设置为10s
//        self.locationManager.reGeocodeTimeout = 10;
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
//    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//        
//        if (error)
//        {
//            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
//            
//            if (error.code == AMapLocationErrorLocateFailed)
//            {
//                return;
//            }
//        }
//        
//        NSLog(@"-location:%@", location);
//        _nowCLLocation = location;
//        NSLog(@"-%f-%f", _nowCLLocation.verticalAccuracy,_nowCLLocation.horizontalAccuracy);
//        if (regeocode)
//        {
//            NSLog(@"reGeocode:%@", regeocode);
//        }
//    }];

//IPV
    [AMapServices sharedServices].enableHTTPS = YES;
    //map
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64 + 48, KscreeWidth, KscreeHeight - 64 - 300 - 48)];
    _mapView.delegate = self;
    //地图比例
    _mapView.zoomLevel = 17;
    //隐藏比例尺
    _mapView.showsScale = NO;
    //隐藏罗盘
    _mapView.showsCompass = NO;
    [self.view addSubview:_mapView];
    //userlocation
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
    r.showsHeadingIndicator = NO;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
    r.fillColor = [UIColor redColor];///精度圈 填充颜色, 默认 kAccuracyCircleDefaultColor
    r.strokeColor = [UIColor blueColor];///精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
    r.lineWidth = 2;///精度圈 边线宽度，默认0
    //    r.enablePulseAnnimation = NO;///内部蓝色圆点是否使用律动效果, 默认YES
    //    r.locationDotBgColor = [UIColor greenColor];///定位点背景色，不设置默认白色
    r.image = [UIImage imageNamed:@"定位"]; ///定位图标, 与蓝色原点互斥
    [_mapView updateUserLocationRepresentation:r];
    
/*
 单次定位
 */
//    [self findMe];
    [self startLocation];
    
    _locationlistTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KscreeHeight - 300, KscreeWidth, 300)];
    _locationlistTableView.delegate = self;
    _locationlistTableView.dataSource = self;
    _locationlistTableView.backgroundColor = [UIColor whiteColor];
    [_locationlistTableView registerNib:[UINib nibWithNibName:@"LocationTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    _locationlistTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _locationlistTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(postdownLoadAction)];
    [self.view addSubview:_locationlistTableView];
}
- (void) postdownLoadAction {
    [self setPage];
}
- (void)setPage {
    NSInteger pageIndex = _datasource.count / 20;
    _request.page = pageIndex + 1;
    _request.offset = 20;
    [self.search AMapPOIAroundSearch:_request];
}
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
//    if ([annotation isKindOfClass:[MAUserLocation class]]) {
//        return nil;
//    }
//    return nil;
//}
#pragma mark - uitextfileddelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
        [_searchLocationTF resignFirstResponder];
        DetailLocationViewController *vc = [[DetailLocationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
    //    return 10;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationModel *model = _datasource[indexPath.row];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@%@%@%@", model.province, model.city, model.district, model.locationstr] forKey:@"address"];
    [dict setValue:[NSString stringWithFormat:@"%@", model.latitudestr] forKey:@"lat"];
    [dict setValue:[NSString stringWithFormat:@"%@", model.longitudestr] forKey:@"long"];
    [dict setValue:[NSString stringWithFormat:@"%@", model.locationstr] forKey:@"addressLablel"];
    self.location(dict);
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
#pragma mark 系统单次定位 - Location and Delegate
- (void)startLocation {
//    [CMMUtility postWait];
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
/** 由于IOS8中定位的授权机制改变 需要进行手动授权
* 获取授权认证，两个方法：
* [self.locationManager requestWhenInUseAuthorization];
* [self.locationManager requestAlwaysAuthorization];
*/
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) { NSLog(@"requestWhenInUseAuthorization");
        //
        [self.manager requestWhenInUseAuthorization];
        [self.manager requestAlwaysAuthorization]; }
    //开始定位，不断调用其代理方法
    [self.manager startUpdatingLocation];
    NSLog(@"start gps");
}
#pragma mark - 定位成功 - 高德范围搜索
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    //IPO 范围搜索
    //默认
    /*
     @“餐饮服务”
     @“商务住宅”
     @“生活服务”
     */
        [AMapServices sharedServices].apiKey = GaoDeKey;
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        _request = [[AMapPOIAroundSearchRequest alloc] init];
        _request.location            = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//        request.keywords            = @"生活服务";
        /* 按照距离排序. */
        _request.sortrule            = 0;
        _request.requireExtension    = YES;
    [self.search AMapPOIAroundSearch:_request];
//    self.longitute = [NSNumber numberWithDouble:coordinate.longitude];
//    self.latitude = [NSNumber numberWithDouble:coordinate.latitude];
    // 2.停止定位
    [manager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
//    [CMMUtility hideWaitingAlertView];
    if (response.pois.count == 0)
    {
        return;
    }
    //周边条数
    //    response.count
    NSArray *array1 = response.pois;
    for (AMapPOI *poi in response.pois) {
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
//        [_alert.LocationListTableView reloadData];
        [_locationlistTableView reloadData];
    });
//    NSArray *arrat2 = response.suggestion.keywords;
//    NSArray *array3 = response.suggestion.cities;
    NSLog(@"%@", response);
    //解析response获取POI信息，具体解析见 Demo
}
//TOP
- (void)wtTopViewWithBackString:(NSString *)backstring andTitlestringsss:(NSString *)titlestring {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 30, 18)];
    [backButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", backstring]] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KscreeWidth / 2) - 50, 30, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [NSString stringWithFormat:@"%@", titlestring];
    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.userInteractionEnabled = YES;
    [topView addSubview:titleLabel];

}
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
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
