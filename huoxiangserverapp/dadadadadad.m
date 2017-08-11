//
//  dadadadadad.m
//  wtanimation
//
//  Created by mc on 17/7/26.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "dadadadadad.h"

@implementation dadadadadad

#define TagValue  3333
#define ALPHA  0.2 //背景
#define AlertTime 0.3 //弹出动画时间
#define DropTime 0.5 //落下动画时间

//#define LabelHeight 30 //label高度
#define TwoEmpty 10 //空间间隔
static CustomAnimationMode mode;
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
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _oneline.frame.origin.y + [self hLocation:TwoEmpty], 100, LabelHeight)];
        _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _nameLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        _nameLabel.text = @"单人SPA";
        [self addSubview:_nameLabel];
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x + _nameLabel.frame.size.width, _nameLabel.frame.origin.y , frame.size.width - 40 - _nameLabel.frame.size.width - 60, LabelHeight)];
        _numberLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _numberLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        _numberLabel.textAlignment = NSTextAlignmentRight;
        _numberLabel.text = [NSString stringWithFormat:@"一份"];
        [self addSubview:_numberLabel];
        _numpayLabel = [[UILabel alloc] initWithFrame:CGRectMake(_numberLabel.frame.origin.x + _numberLabel.frame.size.width, _numberLabel.frame.origin.y, 40, LabelHeight)];
        _numpayLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        _numpayLabel.text = @"190";
        _numpayLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _numpayLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_numpayLabel];
        _totleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_numberLabel.frame.origin.x, _numberLabel.frame.origin.y + [self hLocation:LabelHeight], _numberLabel.frame.size.width, LabelHeight)];
        _totleLabel.textAlignment = NSTextAlignmentRight;
        _totleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _totleLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        _totleLabel.text = @"总价值";
        [self addSubview:_totleLabel];
        _totlepayLabel = [[UILabel alloc] initWithFrame:CGRectMake(_numpayLabel.frame.origin.x, _totleLabel.frame.origin.y, 40, LabelHeight)];
        _totlepayLabel.text = @"188";
        _totlepayLabel.textAlignment = NSTextAlignmentRight;
        _totlepayLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        _totlepayLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self addSubview:_totlepayLabel];
        _groupBuyLabel = [[UILabel alloc] initWithFrame:CGRectMake(_totleLabel.frame.origin.x, _totleLabel.frame.origin.y + [self hLocation:LabelHeight], _totleLabel.frame.size.width , LabelHeight)];
        _groupBuyLabel.textAlignment = NSTextAlignmentRight;
        _groupBuyLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        _groupBuyLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _groupBuyLabel.text = @"团购价";
        [self addSubview:_groupBuyLabel];
        _grouppayLabel = [[UILabel alloc] initWithFrame:CGRectMake(_numpayLabel.frame.origin.x, _groupBuyLabel.frame.origin.y, 40, LabelHeight)];
        _grouppayLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        _grouppayLabel.text = @"100";
        _grouppayLabel.textAlignment = NSTextAlignmentRight;
        _grouppayLabel.textColor = [UIColor colorWithHexString:@"ff8042"];
        [self addSubview:_grouppayLabel];
        
        _twoLine = [[UIView alloc] initWithFrame:CGRectMake(20, _groupBuyLabel.frame.origin.y + LabelHeight + [self hLocation:20], frame.size.width - 40, 1)];
        _twoLine.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
        [self addSubview:_twoLine];
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _twoLine.frame.origin.y + [self hLocation:20], 100, LabelHeight)];
        _dateLabel.text = @"有效期";
        _dateLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _dateLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        [self addSubview:_dateLabel];
        NSString *dateTime = @"·2017-06-06至2018-05-06";
        NSMutableAttributedString *datestring = [[NSMutableAttributedString alloc] initWithString:dateTime];
        [datestring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"ff8042"] range:NSMakeRange(0, 1)];
        _dateNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _dateLabel.frame.origin.y + LabelHeight + [self hLocation:TwoEmpty], frame.size.width - 40, LabelHeight)];
        _dateNumLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _dateNumLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        _dateNumLabel.attributedText = datestring;
        [self addSubview:_dateNumLabel];
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _dateNumLabel.frame.origin.y + LabelHeight + [self hLocation:TwoEmpty], 100, LabelHeight)];
        _timeLabel.text = @"使用时间";
        _timeLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _timeLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        [self addSubview:_timeLabel];
        NSString *userTime = @"·12.00-06-02.03";
        NSMutableAttributedString *userstrig = [[NSMutableAttributedString alloc] initWithString:userTime];
        [userstrig addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"ff8042"] range:NSMakeRange(0, 1)];
        _timeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _timeLabel.frame.origin.y + LabelHeight + [self hLocation:TwoEmpty], frame.size.width - 40, LabelHeight)];
        _timeNumLabel.textColor = [UIColor colorWithHexString:@"333333"];;
        _timeNumLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        _timeNumLabel.attributedText = userstrig;
        [self addSubview:_timeNumLabel];
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _timeNumLabel.frame.origin.y + LabelHeight + [self hLocation:TwoEmpty], 100, LabelHeight)];
        _messageLabel.text = @"预约信息";
        _messageLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _messageLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        [self addSubview:_messageLabel];
        NSString *messageTime = @"·无需预约,高峰时段可能排队";
        NSMutableAttributedString *messagestring = [[NSMutableAttributedString alloc] initWithString:messageTime];
        [messagestring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"ff8042"] range:NSMakeRange(0, 1)];
        _messageStringLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _messageLabel.frame.origin.y + LabelHeight + [self hLocation:TwoEmpty], frame.size.width - 40, LabelHeight)];
        _messageStringLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _messageStringLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        _messageStringLabel.attributedText = messagestring;
        [self addSubview:_messageStringLabel];
        _ruleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _messageStringLabel.frame.origin.y + LabelHeight + [self hLocation:TwoEmpty], 100, LabelHeight)];
        _ruleLabel.text = @"规则提示";
        _ruleLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _ruleLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        [self addSubview:_ruleLabel];
        NSString *ruleTime = @"·可与其他优惠同享";
        NSMutableAttributedString *rulestring = [[NSMutableAttributedString alloc] initWithString:ruleTime];
        [rulestring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"ff8042"] range:NSMakeRange(0, 1)];
        _ruleStringLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _ruleLabel.frame.origin.y + LabelHeight + [self hLocation:TwoEmpty], frame.size.width - 40, LabelHeight)];
        _ruleStringLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _ruleStringLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:14];
        _ruleStringLabel.attributedText = rulestring;
        [self addSubview:_ruleStringLabel];
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
