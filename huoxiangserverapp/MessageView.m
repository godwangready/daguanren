//
//  MessageView.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/27.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "MessageView.h"

#define TagValue  3333
#define ALPHA  0.2 //背景
#define AlertTime 0.3 //弹出动画时间
#define DropTime 0.5 //落下动画时间

//#define LabelHeight 30 //label高度
#define TwoEmpty 10 //空间间隔
static CustomAnimationMode mode;
@implementation MessageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        LabelHeight = 30;
        if (KscreeWidth == 320) {
            LabelHeight = 20;
        }
        if (KscreeWidth == 375) {
            LabelHeight = 25;
        }
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width - 150) / 2, [self hLocation:20], 150, LabelHeight)];
        _titleLabel.text = @"商品详情";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHexString:@"ff8042"];
        _titleLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:16];
        [self addSubview:_titleLabel];
        _oneline = [[UIView alloc] initWithFrame:CGRectMake(20, _titleLabel.frame.origin.y + LabelHeight + [self hLocation:TwoEmpty], frame.size.width - 40, 1)];
        _oneline.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
        [self addSubview:_oneline];
        
        
        
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor colorWithHexString:@"666666"];
        _messageLabel.font = [UIFont systemFontOfSize:14];
        NSString *messageString = @"尊敬的各位领导，各位来宾，女士们，先生们大家下午好！很高兴能够在这个生机勃勃的春天里，和大家相约在唐山创造力沙龙成立唐山创造力沙龙成立仪式暨第三届房地产业界营销精英论坛，本次活动由共青团唐山市委和唐山市文化广播电视新闻出版局主办，唐山电台，唐山电视台，唐山广播电视报社联合承办的。";
        CGSize messagesize = [messageString boundingRectWithSize:CGSizeMake(frame.size.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        _messageLabel.text = @"尊敬的各位领导，各位来宾，女士们，先生们大家下午好！很高兴能够在这个生机勃勃的春天里，和大家相约在唐山创造力沙龙成立唐山创造力沙龙成立仪式暨第三届房地产业界营销精英论坛，本次活动由共青团唐山市委和唐山市文化广播电视新闻出版局主办，唐山电台，唐山电视台，唐山广播电视报社联合承办的。";
        _messageLabel.numberOfLines = 0;
        _messageLabel.frame = CGRectMake(20, _oneline.frame.origin.y + 20, frame.size.width - 40, messagesize.height);
        [self addSubview:_messageLabel];
        
    }
    return self;
}
-(void)showInWindowWithMode:(CustomAnimationMode)animationMode{
    mode = animationMode;
    switch (animationMode) {
        case CustomAnimationModeAlert:
            [self showInWindow];
            break;
        case CustomAnimationModeDrop:
            [self upToDownShowInWindow];
            break;
        default:
            break;
    }
}

-(void)hideView{
    [self tapBgView];
}

-(void)showInWindow{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [self addViewInWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.alpha = 0;
    self.transform = CGAffineTransformScale(self.transform,0.1,0.1);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

-(void)upToDownShowInWindow{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [self addViewInWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGFloat x = ([UIApplication sharedApplication].keyWindow.bounds.size.width-self.frame.size.width)/2;
    CGFloat y = -self.frame.size.height;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(x, y, width, height);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.center = [UIApplication sharedApplication].keyWindow.center;
    } completion:^(BOOL finished) {
        
    }];
}

//弹出隐藏
-(void)hide{
    if (self.superview) {
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformScale(self.transform,0.1,0.1);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self hideAnimationFinish];
        }];
    }
}
//下滑隐藏
-(void)dropDown{
    if (self.superview) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = CGRectMake(self.frame.origin.x, [UIApplication sharedApplication].keyWindow.bounds.size.height, self.frame.size.width, self.frame.size.width);
        } completion:^(BOOL finished) {
            [self hideAnimationFinish];
        }];
    }
}

-(void)hideAnimationFinish{
    UIView *bgvi = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
    if (bgvi) {
        [bgvi removeFromSuperview];
    }
    [self removeFromSuperview];
}

-(void)tapBgView{
    switch (mode) {
        case CustomAnimationModeAlert:
            [self hide];
            break;
        case CustomAnimationModeDrop:
            [self dropDown];
            break;
        default:
            break;
    }
}



-(void)addViewInWindow{
    UIView *oldView = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    UIView *v = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    v.tag = TagValue;
    [self addGuesture:v];
    v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:ALPHA];
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    
}

-(void)addGuesture:(UIView *)vi{
    vi.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView)];
    [vi addGestureRecognizer:tap];
}

/*
 布局
 */
- (CGFloat)wLocation:(CGFloat)data {
    return (data * 1000 / 375) * KscreeWidth / 1000;
}
- (CGFloat)hLocation:(CGFloat)data {
    return (data * 1000 / 667) * KscreeHeight / 1000;
}

@end
