//
//  TeacherPersonViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "TeacherPersonViewController.h"

@interface TeacherPersonViewController ()

@end

@implementation TeacherPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *test = [UIButton buttonWithType:UIButtonTypeSystem];
    test.frame = CGRectMake(0, 0, KscreeWidth, 150);
    [test setTitle:@"技师测试退出" forState:UIControlStateNormal];
    [test addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:test];
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
