//
//  MessageModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/16.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel
@property (nonatomic, strong) NSString *typeId;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSString *pictureUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *currentPage;
@property (nonatomic, strong) NSString *msgId;
@end
