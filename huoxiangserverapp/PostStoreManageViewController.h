//
//  PostStoreManageViewController.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/1.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^locationBlock)(NSDictionary *dict);

@interface PostStoreManageViewController : BaseViewController
@property (nonatomic, copy) locationBlock location;
@end
