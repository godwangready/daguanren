//
//  AddServicesModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/15.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"

@interface AddServicesModel : BaseModel
@property (nonatomic, strong) NSString *typeId;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSString *chargesContent;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *currentPage;
@end
