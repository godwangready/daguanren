//
//  CommentCellModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/16.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"

@interface CommentCellModel : BaseModel
/*
 二层cell里的参数（评论）
 */
@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *star_level;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *picture_url;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userNickName;
@property (nonatomic, strong) NSString *userHeadPortrait;
@property (nonatomic, strong) NSString *toUserId;
@property (nonatomic, strong) NSString *toUserNickName;
@end
