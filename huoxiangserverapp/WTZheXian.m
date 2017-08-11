//
//  WTZheXian.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "WTZheXian.h"

@interface WTZheXian ()

@property (nonatomic, strong) CAShapeLayer *lineChartLayer;
@property (nonatomic, strong)UIBezierPath * path1;
/** 渐变背景视图 */
@property (nonatomic, strong) UIView *gradientBackgroundView;
/** 渐变图层 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
/** 颜色数组 */
@property (nonatomic, strong) NSMutableArray *gradientLayerColors;

@end
@implementation WTZheXian

static CGFloat distanceX = 20;
static CGFloat distanceY = 30;
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createLabelX:@"1"];
        [self createLabelY:@"1"];
    }
    return self;
}
- (void)createLabelX:(NSString *)type {
    CGFloat month = 12;
    for (int i = 0; i < 10; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 2*distanceX)/month * i + distanceX, self.frame.size.height - distanceY + distanceY*0.3, (self.frame.size.width - 2*distanceX)/month- 5, distanceY/2)];
        label.tag = 1000 + i;
        label.text = [NSString stringWithFormat:@"%d",i+1];
        label.font = [UIFont systemFontOfSize:10];
        [self addSubview:label];
    }
}
- (void)createLabelY:(NSString *)type {
    CGFloat number = 5;
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - 2 * distanceY)/number *i + distanceX, distanceY, distanceY/2.0)];
        label.tag = 2000 + i;
        label.text = [NSString stringWithFormat:@"%.0f人",(number - i)*100];
        label.font = [UIFont systemFontOfSize:10];
        [self addSubview:label];
    }
}
- (void)setLine {
    
}
@end
