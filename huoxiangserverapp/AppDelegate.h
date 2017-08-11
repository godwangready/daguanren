//
//  AppDelegate.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
/*
 @相册显示视频
 @允许网络下载图片
 */
//#warning mark - xxoo PHAssetMediaTypeVideo
//networkAccessAllowed
@end

