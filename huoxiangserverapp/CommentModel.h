//
//  CommentModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/15.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"

@interface CommentModel : BaseModel
@property (nonatomic, strong) NSString *iconImageURLs;
@property (nonatomic, strong) NSString *names;
@property (nonatomic, strong) NSString *marks;
@property (nonatomic, strong) NSString *times;
@property (nonatomic, strong) NSString *contents;
@property (nonatomic, strong) NSString *selects;
@property (nonatomic, strong) NSString *replys;
@property (nonatomic, strong) NSArray *replyImagesArray;
@end
