//
//  ManageModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/4.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"

@interface ManageModel : BaseModel
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *productPicture;
@property (nonatomic, strong) NSString *productDetails;
@end
