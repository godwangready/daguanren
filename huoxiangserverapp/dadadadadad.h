//
//  dadadadadad.h
//  wtanimation
//
//  Created by mc on 17/7/26.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CustomAnimationMode) {
    CustomAnimationModeAlert = 0,//弹出效果
    CustomAnimationModeDrop //由上方掉落
};
@interface dadadadadad : UIView {
    CGFloat LabelHeight;
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *oneline;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *totleLabel;
@property (nonatomic, strong) UILabel *groupBuyLabel;
@property (nonatomic, strong) UILabel *numpayLabel;
@property (nonatomic, strong) UILabel *totlepayLabel;
@property (nonatomic, strong) UILabel *grouppayLabel;
@property (nonatomic, strong) UIView *twoLine;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *dateNumLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *timeNumLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *messageStringLabel;
@property (nonatomic, strong) UILabel *ruleLabel;
@property (nonatomic, strong) UILabel *ruleStringLabel;

/**
 显示
 */
-(void)showInWindowWithMode:(CustomAnimationMode)animationMode;

/**
 隐藏
 */
-(void)hideView;
@end
