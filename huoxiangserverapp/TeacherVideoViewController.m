//
//  TeacherVideoViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/24.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "TeacherVideoViewController.h"
#import "TeacherVideoCollectionViewCell.h"
#import "TeacherVideoModel.h"
#import "TeacherFriendsterViewController.h"
static NSString *cellid = @"collectionVideo";
@interface TeacherVideoViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *wtTableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *headNameLabel;
@property (nonatomic, strong) UIImageView *headSixImageView;
@property (nonatomic, strong) UIImageView *headIconImageView;
@property (nonatomic, strong) UILabel *headAgeLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *labelWT;
@property (nonatomic, strong) UILabel *lablelTime;
@property (nonatomic, strong) UILabel *registTime;

@property (nonatomic, strong) UICollectionView *videoTV;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation TeacherVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self requestData];
    [self requestPersonMessage];
    [self twtTopViewWithBackString:@"返回-" andTitlestring:@"小美"];
    [self.view addSubview:self.wtTableView];
}
- (void)twtTopViewWithBackString:(NSString *)backstring andTitlestring:(NSString *)titlestring {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 30, 18)];
    [backButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", backstring]] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backActiont) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KscreeWidth / 2) - 50, 30, 100, 20)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = [NSString stringWithFormat:@"%@", titlestring];
    _titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:_titleLabel];
}
- (void) backActiont {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestPersonMessage {
    NSMutableDictionary *outDict = [self makeDict];
    [outDict setObject:@"server_index" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Userdetail] parameters:outDict success:^(NSDictionary *data) {
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
                
            }else {
                self.headNameLabel.text = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"nickName"]];
                self.titleLabel.text = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"nickName"]];
                self.headAgeLabel.text = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"age"]];
                [self.headIconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"headPortrait"]]]];
                switch ([[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"sex"]] integerValue]) {
                    case 0:
                    {
                    }
                        break;
                    case 1:
                    {
                        self.headSixImageView.image = [UIImage imageNamed:@"男性"];
                    }
                        break;
                    case 2:
                    {
                        self.headSixImageView.image = [UIImage imageNamed:@"女性"];
                    }
                        break;
                        
                    default:
                        break;
                }
                self.servername = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"nickName"]];
                self.servericonimage = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"headPortrait"]];
                [self.backImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"headPortrait"]]]];
                self.lablelTime.text = [NSString stringWithFormat:@"账号：%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"telephone"]];
                self.registTime.text = [NSString stringWithFormat:@"注册日期：%@", [self timeToDeadline:[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"addTime"]]];
//                [self.headIconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"headPortrait"]]] placeholderImage:[UIImage imageNamed:@"logo"]];
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
- (NSString *)timeToDeadline:(NSString *)timedate {
    NSTimeInterval time= ([timedate doubleValue]+28800) / 1000.0;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,设置需要的格式
//    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    NSLog(@"%@", currentDateStr);
    return currentDateStr;
}
- (void)requestData {
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
    if ([userid objectForKey:@"userid"]) {
        [dict setObject:[NSString stringWithFormat:@"%@", [userid objectForKey:@"userid"]] forKey:@"serverId"];
    }else {
        [dict setObject:@"" forKey:@"serverId"];
    }
    [dict setObject:@"" forKey:@"currentPage"];
    [dict setObject:@"20" forKey:@"num"];
    [dict setObject:@"" forKey:@"resourceType"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Selfdynamiclist] parameters:outDict success:^(NSDictionary *data) {
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
                
            }else {
                NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
                /*
                 提起外层数据
                 */
                for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
                    NSLog(@"%@", dict);
                    TeacherVideoModel *model = [[TeacherVideoModel alloc] init];
                    model.videoUrl = [NSString stringWithFormat:@"%@", [dict objectForKey:@"videoUrl"]];
                    [self.dataArray addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.labelWT.text = [NSString stringWithFormat:@"动态 %lu", (unsigned long)self.dataArray.count];
                    [self.videoTV reloadData];
                    [self.wtTableView reloadData];
                });
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];

        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error.userInfo);
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
- (UITableView *)wtTableView {
    if (!_wtTableView) {
        _wtTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 69, KscreeWidth, KscreeHeight - 69) style:UITableViewStylePlain];
        _wtTableView.delegate = self;
        _wtTableView.dataSource = self;
        _wtTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 150)];
        _wtTableView.tableHeaderView = self.headView;
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 145)];
//        self.backImageView.backgroundColor = [UIColor yellowColor];
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:self.servericonimage] placeholderImage:[UIImage imageNamed:@"logo"]];
        [self.headView addSubview:self.backImageView];
        self.headIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 50, 50)];
        self.headIconImageView.layer.masksToBounds = YES;
        self.headIconImageView.layer.cornerRadius = 3;
        [self.headIconImageView sd_setImageWithURL:[NSURL URLWithString:self.servericonimage] placeholderImage:[UIImage imageNamed:@"logo"]];
        self.headNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 80, KscreeWidth - 100, 21)];
        self.headSixImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 80 + 35, 15, 15)];
        self.headAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + 15 + 5, 80 + 30 + 3, 100, 20)];
//        self.headIconImageView.backgroundColor = [UIColor orangeColor];
        self.headNameLabel.text = self.servername;
        self.headAgeLabel.text = self.serverage;
//        self.headView.backgroundColor = [UIColor brownColor];
        self.headSixImageView.image = [UIImage imageNamed:@"女性"];
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 145, KscreeWidth, 5)];
        self.lineView.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
        [self.backImageView addSubview:self.headIconImageView];
        [self.backImageView addSubview:self.headNameLabel];
        [self.backImageView addSubview:self.headSixImageView];
        [self.backImageView addSubview:self.headAgeLabel];
        [self.headView addSubview:self.lineView];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return _wtTableView;
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    switch (indexPath.row) {
        case 0:
        {
            _labelWT = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 21)];
            _labelWT.text = @"";
            _labelWT.textColor = [UIColor colorWithHexString:@"333333"];
            _labelWT.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:13];
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.itemSize = CGSizeMake(50, 50);
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.minimumLineSpacing = 5;
            _videoTV = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 40 + 13, KscreeWidth - 50, 50) collectionViewLayout:layout];
            _videoTV.backgroundColor = [UIColor whiteColor];
            _videoTV.delegate = self;
            _videoTV.dataSource = self;
            _videoTV.scrollsToTop = NO;
            _videoTV.scrollEnabled = NO;
            _videoTV.showsVerticalScrollIndicator = NO;
            _videoTV.showsHorizontalScrollIndicator = NO;
            _videoTV.contentSize = CGSizeMake(KscreeWidth - 50, 50);
            [_videoTV registerNib:[UINib nibWithNibName:@"TeacherVideoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellid];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
            [_videoTV addGestureRecognizer:tap];
            [cell addSubview:_videoTV];
            [cell addSubview:_labelWT];
            if (self.dataArray.count == 0) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 40 + 13, KscreeWidth - 50, 50)];
                label.text = @"Ta很懒什么都没写";
                label.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:13];
                label.textColor = [UIColor colorWithHexString:@"333333"];
                [cell addSubview:label];
            }
            self.labelWT.text = [NSString stringWithFormat:@"动态 %lu", (unsigned long)self.dataArray.count];
            return cell;
        }
            break;
        case 1:
        {
            UILabel *labelWT = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 21)];
            _lablelTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 40 + 10, KscreeWidth - 50, 21)];
            _registTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 60 + 20, KscreeWidth - 50, 21)];
            labelWT.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:13];
            _lablelTime.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:13];
            _registTime.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:13];
            labelWT.textColor = [UIColor colorWithHexString:@"333333"];
            _lablelTime.textColor = [UIColor colorWithHexString:@"999999"];
            _registTime.textColor = [UIColor colorWithHexString:@"999999"];
            labelWT.text = @"账号信息";
            _lablelTime.text = @"账号：";
            _registTime.text = @"注册日期：";
            [cell addSubview:labelWT];
            [cell addSubview:_lablelTime];
            [cell addSubview:_registTime];
            return cell;
        }
            break;
            
        default:
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            TeacherFriendsterViewController *vc = [[TeacherFriendsterViewController alloc] init];
            vc.servername = self.servername;
            vc.servericonimage = self.servericonimage;
            vc.serversix = self.serversix;
            vc.serverage = self.serverage;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            case 1:
        {
            
        }
            
        default:
            break;
    }
}
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
#pragma mark - UICollectionViewDataSource,
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TeacherVideoModel *model = self.dataArray[indexPath.row];
    TeacherVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TeacherVideoCollectionViewCell" owner:nil options:nil] lastObject];
    }
    cell.iconImageView.layer.masksToBounds = YES;
    cell.iconImageView.layer.cornerRadius = 3;
    if ([model.videoUrl rangeOfString:@"mp4"].location != NSNotFound) {
        UIImageView *videoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"播放按钮"]];
        videoImageView.frame = CGRectMake((50 - 30) / 2, (50 - 30) / 2, 30, 30);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            cell.iconImageView.image = [self getThumbnailImage:model.videoUrl];
        });
        [cell.iconImageView addSubview:videoImageView];
        return cell;
    }else {
        NSString *str = @",";
        if ([[NSString stringWithFormat:@"%@", model.videoUrl] rangeOfString:str].location != NSNotFound) {
            NSMutableArray *imagesArray = [NSMutableArray arrayWithArray:[[NSString stringWithFormat:@"%@", model.videoUrl] componentsSeparatedByString:@","]];
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[imagesArray firstObject]] placeholderImage:[UIImage imageNamed:@"logo"]];
        }else {
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.videoUrl]] placeholderImage:[UIImage imageNamed:@"logo"]];
        }
        return cell;

    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
#pragma mark  - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        return CGSizeMake(50, 50);
        
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}
#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TeacherFriendsterViewController *vc = [[TeacherFriendsterViewController alloc] init];
    vc.servername = self.servername;
    vc.servericonimage = self.servericonimage;
    vc.serverage = self.serverage;
    vc.serversix = self.serversix;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void) tapAction {
    TeacherFriendsterViewController *vc = [[TeacherFriendsterViewController alloc] init];
    vc.servericonimage = self.servericonimage;
    vc.servername = self.servername;
    vc.serverage = self.serverage;
    vc.serversix = self.serversix;
    [self.navigationController pushViewController:vc animated:YES];
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
// - (void)viewWillAppear:(BOOL)animated {
//     [self.navigationController setNavigationBarHidden:YES animated:NO];
//     [self hideTabBar];
//     [super viewWillAppear:animated];
// }
// - (void) viewWillDisappear:(BOOL)animated {
//     [self.navigationController setNavigationBarHidden:YES animated:YES];
//     [self showTabBar];
//     [super viewWillDisappear:animated];
// }

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
