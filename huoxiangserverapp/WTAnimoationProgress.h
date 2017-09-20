//
//  WTAnimoationProgress.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/18.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTAnimoationProgress : UIView
- (instancetype)initWithFrame:(CGRect)frame themeColor:(UIColor *)themeColor duration:(NSTimeInterval)duration;
- (void)play;
- (void)stop;
- (void)restore;
@end
