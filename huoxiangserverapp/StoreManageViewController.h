//
//  StoreManageViewController.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/2.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^changeIconImage)(UIImage *);
@interface StoreManageViewController : BaseViewController
@property (nonatomic, copy) changeIconImage pullIconImage;
@end
