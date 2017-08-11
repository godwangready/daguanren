//
//  ZheXianViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "ZheXianViewController.h"
#import "ZheXianView.h"
#import "WTZheXian.h"

@interface ZheXianViewController ()

@end

@implementation ZheXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    ZheXianView *zhecianView = [[ZheXianView alloc] initWithFrame:CGRectMake((KscreeWidth - 300) / 2, 100, 300, 200)];
//    [self.view addSubview:zhecianView];
    WTZheXian *zhexian = [[WTZheXian alloc] initWithFrame:CGRectMake((KscreeWidth - 300) / 2, 100, 300, 200)];
    [self.view addSubview:zhexian];
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
