//
//  LocationModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/9.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"

@interface LocationModel : BaseModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *locationstr;
@property (nonatomic, strong) NSString *latitudestr;
@property (nonatomic, strong) NSString *longitudestr;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *district;
@end
