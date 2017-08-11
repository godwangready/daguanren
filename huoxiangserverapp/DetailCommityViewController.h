//
//  DetailCommityViewController.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/2.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"



@interface DetailCommityViewController : BaseViewController
typedef void(^byValue)(NSString *string);
@property (nonatomic, copy) byValue passValue;

@end
