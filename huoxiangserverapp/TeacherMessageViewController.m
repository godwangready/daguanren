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

@interface TeacherMessageViewController ()

@end

@implementation TeacherMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showColumnView];
    // Do any additional setup after loading the view.
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
