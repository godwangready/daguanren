//
//  DetailCommityViewController.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/2.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"
#import "ManageModel.h"


@interface DetailCommityViewController : BaseViewController
typedef void(^byValue)(NSDictionary *dict);
@property (nonatomic, copy) byValue passValue;

@property (nonatomic, strong) NSDictionary *valueDict;
@property (nonatomic, strong) ManageModel *managemodel;
@end
