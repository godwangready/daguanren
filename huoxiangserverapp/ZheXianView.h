//
//  ZheXianView.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZheXianView : UIView

@property (nonatomic, strong) NSArray *dataSource;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)createLabelX:(NSString *)type;
@end