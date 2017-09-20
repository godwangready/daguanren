//
//  ManageDetailModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/30.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"

@interface ManageDetailModel : BaseModel
@property (nonatomic, strong) NSString *startYMD;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *endYMD;
@property (nonatomic, strong) NSString *rule;
@property (nonatomic, strong) NSString *startHM;
@property (nonatomic, strong) NSString *endHM;
@end
