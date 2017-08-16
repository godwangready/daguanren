//
//  AppDelegate.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "AppDelegate.h"
#import "RegistViewController.h"
#import "LoginViewController.h"
#import "LaunchIntroductionView.h"
#import "SGLNavigationViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "MainViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [LaunchIntroductionView sharedWithImages:@[@"one", @"two",@"one",@"two"] buttonImage:@"one" buttonFrame:CGRectMake(KscreeWidth / 2, 400, 100, 30)];
    
    /*
     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     SGLFirstViewController  *viewController = [[SGLFirstViewController alloc] init];
     
     SGLNavigationViewController *fullScreenNavigationViewController = [[SGLNavigationViewController alloc] initWithRootViewController:viewController];
     self.window.rootViewController = fullScreenNavigationViewController;
     [self.window makeKeyAndVisible];
     */
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen  mainScreen].bounds.size.height)];
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
    SGLNavigationViewController *navigation = [[SGLNavigationViewController alloc] initWithRootViewController:loginVC];
/*
 self.window.rootViewController = navigation;
 [self.window makeKeyAndVisible];
 */
    
    //轮播
    LaunchIntroductionView *firstView = [LaunchIntroductionView sharedWithImages:@[@"one", @"two",@"one",@"two"] buttonImage:@"" buttonFrame:CGRectMake(KscreeWidth / 2, 400, 100, 30)];
//    firstView.currentColor = [UIColor yellowColor];
//    firstView.nomalColor = [UIColor orangeColor];
    
    //判断是否永久登录
    NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *apptoken = [NSUserDefaults standardUserDefaults];
    if ([NSString stringWithFormat:@"%@", [userid objectForKey:@"userid"]].length != 0 && [NSString stringWithFormat:@"%@", [apptoken objectForKey:@"apptoken"]] != 0) {
        MainViewController *main = [[MainViewController alloc] init];
        [main.tabBar setTintColor:[UIColor colorWithHexString:@"ff8042"]];
        [main.tabBar setBarTintColor:[UIColor whiteColor]];
        self.window.rootViewController = main;
        [self.window makeKeyAndVisible];
    }else {
        self.window.rootViewController = navigation;
        [self.window makeKeyAndVisible];
    }
    //配置高德KEY
    [AMapServices sharedServices].apiKey = GaoDeKey;
    return YES;
}
/**/
/*
 //网络监控
 -(void)setNetworkWatching{
 __block AFNetworkReachabilityManager *mgr=[AFNetworkReachabilityManager sharedManager];
 [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
 switch (status) {
 case AFNetworkReachabilityStatusUnknown:
 {
 NSLog(@"未知网络");
 [CMMUtility hideWaitingAlertView];
 }
 break;
 case AFNetworkReachabilityStatusReachableViaWiFi:
 NSLog(@"在使用wifi");
 break;
 case AFNetworkReachabilityStatusNotReachable:
 {
 NSLog(@"没有联网%ld",mgr.networkReachabilityStatus);
 [CMMUtility showNote:@"没有网络"];
 
 }
 break;
 case AFNetworkReachabilityStatusReachableViaWWAN:
 NSLog(@"在使用蜂窝数据");
 break;
 default:
 break;
 }
 }];
 [mgr startMonitoring];
 
 }
 */
/*
 #pragma mark - 判断是不是首次登录或者版本更新
 -(BOOL )isFirstLauch{ //获取当前版本号
 NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary]; NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
 //获取上次启动应用保存的appVersion
 NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersion];
 //版本升级或首次登录 
 if (version == nil || ![version isEqualToString:currentAppVersion]) 
 { [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:kAppVersion];
 [[NSUserDefaults standardUserDefaults] synchronize]; return YES;
 }else{
 return NO; 
 }
 }
 */

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"huoxiangserverapp"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
