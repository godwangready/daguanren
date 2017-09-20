//
//  ServerCommentModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/9/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"

@interface ServerCommentModel : BaseModel
@property (nonatomic, strong) NSString *star_level;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userNickName;
@property (nonatomic, strong) NSString *userHeadPortrait;
@property (nonatomic, strong) NSString *currentPage;
@end
