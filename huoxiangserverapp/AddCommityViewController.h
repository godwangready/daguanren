//
//  AddCommityViewController.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/26.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"
#import "ManageModel.h"

//typedef void(^backValue)(NSDictionary *dict);
@interface AddCommityViewController : BaseViewController
@property (nonatomic, strong) NSString *productID;
//@property (nonatomic, copy) backValue backvalue;
@property (nonatomic, strong) ManageModel *managemodel;
@end
