//
//  LocationListView.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/7.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CustomAnimationMode) {
    CustomAnimationModeAlert = 0,//弹出效果
    CustomAnimationModeDrop //由上方掉落
};
@interface LocationListView : UIView
@property (nonatomic, strong) UITableView *LocationListTableView;
/**
 显示
 */
-(void)showInWindowWithMode:(CustomAnimationMode)animationMode;

/**
 隐藏
 */
-(void)hideView;
@end
