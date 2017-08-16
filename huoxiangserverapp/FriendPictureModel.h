//
//  FriendPictureModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/14.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"

@interface FriendPictureModel : BaseModel
@property (nonatomic, strong) NSString *iconImageURL;
@property (nonatomic, strong) NSString *contentString;
@property (nonatomic, assign) float cellHeight;

@end
