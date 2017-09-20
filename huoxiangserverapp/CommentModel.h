//
//  CommentModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/15.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"
#import "CommentCellModel.h"
#import "CommentCellFrameModel.h"
@interface CommentModel : BaseModel
/*
 基础信息
 */
@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *starLevel;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *picture_url;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userNickName;
@property (nonatomic, strong) NSString *userHeadPortrait;
@property (nonatomic, strong) NSString *currentPage;
@property (nonatomic, strong) NSString *deleteRemarks;
@property (nonatomic, strong) NSString *deleteSysUserId;
@property (nonatomic, strong) NSString *deleteUserId;

@property (nonatomic, strong) NSString *pictureUrl;
/*
 是否有评论
 @0无评论
 @1有评论
 */
@property (nonatomic, strong) NSString *iscomment;
/*
 @存储 cell的数据量
 @存储 cell的数据高度(回复)
 @存储 cell的
 */
@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) NSMutableArray *commentFrameArray;
@property (nonatomic, strong) NSMutableArray *replyImagesArray;
@end


