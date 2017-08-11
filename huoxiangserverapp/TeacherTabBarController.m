//
//  TeacherTabBarController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "TeacherTabBarController.h"
#import "TeacherHomeViewController.h"
#import "TeacherPersonViewController.h"
#import "TeacherMessageViewController.h"
#import "SGLNavigationViewController.h"

@interface TeacherTabBarController ()

@end

@implementation TeacherTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayOutTeacherTabBar];
    // Do any additional setup after loading the view.
}
- (void)setLayOutTeacherTabBar {
    TeacherHomeViewController *th = [[TeacherHomeViewController alloc] init];
    UINavigationController *navth = [[SGLNavigationViewController alloc] initWithRootViewController:th];
    TeacherMessageViewController *tm = [[TeacherMessageViewController alloc] init];
    UINavigationController *navtm = [[SGLNavigationViewController alloc] initWithRootViewController:tm];
    TeacherPersonViewController *tp = [[TeacherPersonViewController alloc] init];
    UINavigationController *navtp = [[SGLNavigationViewController alloc] initWithRootViewController:tp];
    navth.title = @"主页";
    navtm.title = @"消息";
    navtp.title = @"设置";
    navth.tabBarItem.image = [UIImage imageNamed:@""];
    navtm.tabBarItem.image = [UIImage imageNamed:@""];
    navtp.tabBarItem.image = [UIImage imageNamed:@""];
    navth.tabBarItem.selectedImage = [UIImage imageNamed:@""];
    navtm.tabBarItem.selectedImage = [UIImage imageNamed:@""];
    navtp.tabBarItem.selectedImage = [UIImage imageNamed:@""];
    self.viewControllers = @[navth, navtm, navtp];
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
