//
//  MainViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "MainViewController.h"

#import "HomeViewController.h"
#import "MessageViewController.h"
#import "PersonCenterViewController.h"
#import "SGLNavigationViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLayOutMain];
}
- (void) setLayOutMain {
    HomeViewController *homevc = [[HomeViewController alloc] init];
    UINavigationController *navhome = [[SGLNavigationViewController alloc] initWithRootViewController:homevc];
    MessageViewController *messagevc = [[MessageViewController alloc] init];
    UINavigationController *navmessage = [[SGLNavigationViewController alloc] initWithRootViewController:messagevc];
    PersonCenterViewController *personvc = [[PersonCenterViewController alloc ] init];
    UINavigationController *navperson = [[SGLNavigationViewController alloc] initWithRootViewController:personvc];
    
    navhome.tabBarItem.title = @"主页";
    navmessage.tabBarItem.title = @"消息";
    navperson.tabBarItem.title = @"个人中心";
    navmessage.tabBarItem.badgeValue = @"0";
    navhome.tabBarItem.image = [UIImage imageNamed:@"首页line"];
    navperson.tabBarItem.image = [UIImage imageNamed:@"设置line"];
    navmessage.tabBarItem.image = [UIImage imageNamed:@"消息line"];
    navhome.tabBarItem.selectedImage = [UIImage imageNamed:@"首页fill"];
    navmessage.tabBarItem.selectedImage = [UIImage imageNamed:@"消息fill"];
    navperson.tabBarItem.selectedImage = [UIImage imageNamed:@"设置fill"];
    self.viewControllers = @[navhome, navmessage, navperson];
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
