//
//  HProgressView.h
//  Join
//
//  Created by 黄克瑾 on 2017/2/2.
//  Copyright © 2017年 huangkejin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HProgressView : UIView

@property (assign, nonatomic) NSInteger timeMax;
/**
 *  进度值0-1.0之间
 */
@property (nonatomic,assign)CGFloat progressValue;

@property (nonatomic, assign) CGFloat currentTime;
- (void)clearProgress;
- (void)startProgress;
- (void)setTimeMax:(NSInteger)timeMax;
- (void)clearProgressValue;
@end
