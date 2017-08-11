//
//  CommentViewController.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/31.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"

@interface CommentViewController : BaseViewController<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UIView *clickBar;
@property (nonatomic, strong) NSArray *controllerArray;

@end
