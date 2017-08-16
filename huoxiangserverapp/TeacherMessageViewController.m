//
//  TeacherMessageViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "TeacherMessageViewController.h"
#import "JHChartHeader.h"
#define k_MainBoundsWidth [UIScreen mainScreen].bounds.size.width
#define k_MainBoundsHeight [UIScreen mainScreen].bounds.size.height

#import "FriendsterPictureTableViewCell.h"
#import "FriendPictureModel.h"
#import "FriendPictureFrameModel.h"

static NSString *cellpicture = @"picturecell";

@interface TeacherMessageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *friendTV;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *frameDatasource;
@end

@implementation TeacherMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self showColumnView];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < 4; i++) {
        FriendPictureModel *model = [[FriendPictureModel alloc] init];
        FriendPictureFrameModel *frameModel = [[FriendPictureFrameModel alloc] init];
        model.contentString = @"";
        //手动计算
        NSString *messageString = model.contentString;
        CGSize messagesize = [messageString boundingRectWithSize:CGSizeMake(KscreeWidth - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        model.cellHeight = messagesize.height;
        frameModel.iconFrame = CGRectMake(20, 20, 100, 100);
        frameModel.nameFrame = CGRectMake(140, 20, 100, 30);
        frameModel.contentFrame = CGRectMake(140, frameModel.nameFrame.origin.y + 10, KscreeWidth - 160, messagesize.height);
        frameModel.arrimage = CGRectMake(140, frameModel.contentFrame.origin.y + frameModel.contentFrame.size.height + 20, 150, 150);
        [self.dataSource addObject:model];
        [self.frameDatasource addObject:frameModel];
    }
    for (int j = 0; j < 4; j++) {
        FriendPictureModel *model1 = [[FriendPictureModel alloc] init];
        FriendPictureFrameModel *frameModel1 = [[FriendPictureFrameModel alloc] init];
        model1.contentString = @"尊敬的各位领导，各位来宾，女士们，先生们大家下午好！很高兴能够在这个生机勃勃的春天里，和大家相约在唐山创造力沙龙成立唐山创造力沙龙成立仪式暨第三届房地产业界营销精英论坛，本次活动由共青团唐山市委和唐山市文化广播电视新闻出版局主办，唐山电台，唐山电视台，唐山广播电视报社联合承办的。";
        //手动计算
        NSString *messageString1 = @"尊敬的各位领导，各位来宾，女士们，先生们大家下午好！很高兴能够在这个生机勃勃的春天里，和大家相约在唐山创造力沙龙成立唐山创造力沙龙成立仪式暨第三届房地产业界营销精英论坛，本次活动由共青团唐山市委和唐山市文化广播电视新闻出版局主办，唐山电台，唐山电视台，唐山广播电视报社联合承办的。";
        CGSize messagesize1 = [messageString1 boundingRectWithSize:CGSizeMake(KscreeWidth - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        model1.cellHeight = messagesize1.height;
        frameModel1.iconFrame = CGRectMake(20, 20, 100, 100);
        frameModel1.nameFrame = CGRectMake(140, 20, 100, 30);
        frameModel1.contentFrame = CGRectMake(140, frameModel1.nameFrame.origin.y + 10, KscreeWidth - 160, messagesize1.height);
        frameModel1.arrimage = CGRectMake(140, frameModel1.contentFrame.origin.y + frameModel1.contentFrame.size.height + 20, 150, 150);
        [self.dataSource addObject:model1];
        [self.frameDatasource addObject:frameModel1];
    }
    [self.view addSubview:self.friendTV];
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (NSMutableArray *)frameDatasource {
    if (!_frameDatasource) {
        _frameDatasource = [NSMutableArray arrayWithCapacity:0];
    }
    return _frameDatasource;
}
- (UITableView *)friendTV {
    if (!_friendTV) {
        _friendTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, KscreeWidth, KscreeHeight - 84) style:UITableViewStylePlain];
        _friendTV.delegate = self;
        _friendTV.dataSource = self;
        _friendTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//        _friendTV.mj_header =
        [_friendTV registerClass:[FriendsterPictureTableViewCell class] forCellReuseIdentifier:cellpicture];
    }
    return _friendTV;
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsterPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellpicture];
    if (!cell) {
        cell = [[FriendsterPictureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellpicture];
    }
    FriendPictureModel *model = self.dataSource[indexPath.row];
    FriendPictureFrameModel *frameModel = self.frameDatasource[indexPath.row];
    cell.cellFrame = frameModel;
    cell.contentLablel.text = model.contentString;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendPictureFrameModel *model = self.frameDatasource[indexPath.row];
    return model.arrimage.origin.y + model.arrimage.size.height + 20;
}

//柱状图
- (void)showColumnView{
    JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(0, 64, k_MainBoundsWidth, 320)];
    /*        Create an array of data sources, each array is a module data. For example, the first array can represent the average score of a class of different subjects, the next array represents the average score of different subjects in another class        */
    column.valueArr = @[
                        @[@12],
                        @[@22],
                        @[@1],
                        @[@21],
                        @[@19],
                        @[@12],
                        @[@15],
                        @[@9],
                        @[@8],
                        @[@6],
                        @[@9],
                        @[@18],
                        @[@23],
                        ];
    /*       This point represents the distance from the lower left corner of the origin.         */
    column.originSize = CGPointMake(30, 20);
    /*    The first column of the distance from the starting point     */
    column.drawFromOriginX = 20;
    column.typeSpace = 10;
    column.isShowYLine = NO;
    /*        Column width         */
    column.columnWidth = 30;
    /*        Column backgroundColor         */
    column.bgVewBackgoundColor = [UIColor whiteColor];
    /*        X, Y axis font color         */
    column.drawTextColorForX_Y = [UIColor blackColor];
    /*        X, Y axis line color         */
    column.colorForXYLine = [UIColor darkGrayColor];
    /*    Each module of the color array, such as the A class of the language performance of the color is red, the color of the math achievement is green     */
    column.columnBGcolorsArr = @[[UIColor colorWithRed:72/256.0 green:200.0/256 blue:255.0/256 alpha:1],[UIColor greenColor],[UIColor orangeColor]];
    /*        Module prompt         */
    column.xShowInfoText = @[@"A班级",@"B班级",@"C班级",@"D班级",@"E班级",@"F班级",@"G班级",@"H班级",@"i班级",@"J班级",@"L班级",@"M班级",@"N班级"];
    column.isShowLineChart = YES;
    column.lineValueArray =  @[
                               @6,
                               @12,
                               @10,
                               @1,
                               @9,
                               @5,
                               @9,
                               @9,
                               @5,
                               @6,
                               @4,
                               @8,
                               @11
                               ];
    
    column.delegate = self;
    /*       Start animation        */
    [column showAnimation];
    [self.view addSubview:column];
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
