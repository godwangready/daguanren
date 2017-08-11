//
//  MessageView.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/27.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CustomAnimationMode) {
    CustomAnimationModeAlert = 0,//弹出效果
    CustomAnimationModeDrop //由上方掉落
};
@interface MessageView : UIView {
    CGFloat LabelHeight;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *oneline;
@property (nonatomic, strong) UILabel *messageLabel;
/**
 显示
 */
-(void)showInWindowWithMode:(CustomAnimationMode)animationMode;

/**
 隐藏
 */
-(void)hideView;
@end
