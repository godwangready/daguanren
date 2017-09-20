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
@property (nonatomic, strong) UINavigationController *navhome;
@property (nonatomic, strong) UINavigationController *navmessage;
@property (nonatomic, strong) UINavigationController *navperson;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLayOutMain];
    [self ffmessage];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kanleAction) name:@"kanle" object:nil];
}
- (void) kanleAction {
    self.navmessage.tabBarItem.badgeValue = nil;
}
- (void) setLayOutMain {
    HomeViewController *homevc = [[HomeViewController alloc] init];
    _navhome = [[SGLNavigationViewController alloc] initWithRootViewController:homevc];
    MessageViewController *messagevc = [[MessageViewController alloc] init];
    _navmessage = [[SGLNavigationViewController alloc] initWithRootViewController:messagevc];
    PersonCenterViewController *personvc = [[PersonCenterViewController alloc ] init];
    _navperson = [[SGLNavigationViewController alloc] initWithRootViewController:personvc];
    
    _navhome.tabBarItem.title = @"主页";
    _navmessage.tabBarItem.title = @"消息";
    _navperson.tabBarItem.title = @"个人中心";
//    navmessage.tabBarItem.badgeValue = @"0";
    _navhome.tabBarItem.image = [UIImage imageNamed:@"首页line"];
    _navperson.tabBarItem.image = [UIImage imageNamed:@"设置line"];
    _navmessage.tabBarItem.image = [UIImage imageNamed:@"消息line"];
    _navhome.tabBarItem.selectedImage = [UIImage imageNamed:@"首页fill"];
    _navmessage.tabBarItem.selectedImage = [UIImage imageNamed:@"消息fill"];
    _navperson.tabBarItem.selectedImage = [UIImage imageNamed:@"设置fill"];
    self.viewControllers = @[_navhome, _navmessage, _navperson];
}
- (void) ffmessage {
//    [self requestDatamessagetype];
    [self requestDatamessagelist:@"1"];
}
//- (void) requestDatamessagetype {
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
//    NSMutableDictionary *outDict = [self makeDict];
//    [dict setObject:@"" forKey:@"currentPage"];
//    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
//    [WTNewRequest postWithURLString:[self createRequestUrl:Messagetype] parameters:outDict success:^(NSDictionary *data) {
//        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
//            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
//                
//            }else {
//                for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
//                }
//            }
//        }else {
//            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
//        }
//    } failure:^(NSError *error) {
//        [CMMUtility showFailureWith:@"服务器故障"];
//    }];
//}
- (void) requestDatamessagelist:(NSString *)messageid {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableDictionary *outDict = [self makeDict];
    [dict setObject:@"" forKey:@"currentPage"];
    [dict setObject:@"1" forKey:@"typeId"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Messagelist] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", data);
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
                
            }else {
                for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
                    if ([[NSString stringWithFormat:@"%@", [dict objectForKey:@"result"]] integerValue] == 0) {
                            _navmessage.tabBarItem.badgeValue = @"1";

                    }
                }
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
        
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
- (NSString *)createRequestUrl:(NSString *)urls {
    
    return [NSString stringWithFormat:@"%@%@", RequestHeader, urls];
}
- (NSMutableDictionary *)makeDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:AppKEY forKey:@"appKey"];
    [dict setObject:[TimeGet getTimeNow] forKey:@"ts"];
    [dict setObject:@"1" forKey:@"signer"];
    [dict setObject:@"1" forKey:@"deviceType"];
    [dict setObject:@"1" forKey:@"version"];
    //    [dict setObject:@"2" forKey:@"appType"];
    NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *apptoken = [NSUserDefaults standardUserDefaults];
    if ([userid objectForKey:@"userid"]) {
        [dict setObject:[NSString stringWithFormat:@"%@", [userid objectForKey:@"userid"]] forKey:@"userId"];
    }else {
        [dict setObject:@"" forKey:@"userId"];
    }
    if ([apptoken objectForKey:@"apptoken"]) {
        [dict setObject:[NSString stringWithFormat:@"%@", [apptoken objectForKey:@"apptoken"]] forKey:@"token"];
        
    }else {
        [dict setObject:@"" forKey:@"token"];
    }
    //    [dict setObject:<#(nonnull id)#> forKey:@"postDate"];
    return dict;
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
