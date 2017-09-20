//
//  FriendPictureModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/14.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"
#import "FriendCellModel.h"
#import "FriendCellFrameModel.h"
@interface FriendPictureModel : BaseModel
@property (nonatomic, strong) NSString *timedate;
@property (nonatomic, strong) NSString *iconImageURL;
@property (nonatomic, strong) NSString *contentString;
//@property (nonatomic, assign) float cellHeight;
//@property (nonatomic, strong) FriendCellModel *cellModel;
//@property (nonatomic, strong) FriendCellFrameModel *cellFrameModel;
/*
 @存储 cell的数据量
 @存储 cell的数据高度(回复)
 @存储 cell的
 */
@property (nonatomic, strong) NSString *dynamicId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userNickName;
@property (nonatomic, strong) NSString *userHeadPortrait;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *currentPage;

@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) NSMutableArray *commentFrameArray;
@property (nonatomic, strong) NSMutableArray *replyImagesArray;
@end
//{
//    commentModels =         (
//    );
//    content = "9\U5f20\U56fe\U7684\Uff0c\U4f18\U8d28\U4e2a\U80a1\U53e4\U4f1a\U9aa8\U5934\Uff0c\U8e22\U817f\Uff0c\U547c\U547c\U56e0\U4e3a\Uff0c\U8e22\U817f\Uff0c \Uff0c\U3002\Uff0c \Uff0c \Uff0c \U817f\Uff0c \Uff0c \U597d\U53cb\U3002\U4e00\U76f4\U5728\Uff0c\U5440\Uff0c\U4e00\U76f4\U5728\Uff0c\U6211\Uff0c\U4e49\U52a1\U6559\U80b2\U81ea\U4ee5\U4e3a\U53ef\U4ee5\U4e00\U76f4\Uff0c\U56e0\U4e3a\Uff0c\U6211";
//    currentPage = 0;
//    deleteRemarks = "";
//    deleteSysUserId = 0;
//    deleteTime = "<null>";
//    deleteUserId = 0;
//    dynamicId = 5;
//    isShow = 0;
//    limit = 20;
//    maxRows = 5000;
//    pages = 0;
//    start = 0;
//    total = 0;
//    userHeadPortrait = "";
//    userId = 19;
//    userNickName = "";
//    videoUrl = "http://47.92.127.101/statics/appresource/upload/1503302608737store.png,http://47.92.127.101/statics/appresource/upload/1503302611699store.png,http://47.92.127.101/statics/appresource/upload/1503302611797store.png,http://47.92.127.101/statics/appresource/upload/1503302611810store.png,http://47.92.127.101/statics/appresource/upload/1503302611814store.png,http://47.92.127.101/statics/appresource/upload/1503302611810store.png,http://47.92.127.101/statics/appresource/upload/1503302611808store.png,http://47.92.127.101/statics/appresource/upload/1503302611840store.png,http://47.92.127.101/statics/appresource/upload/1503302611846store.png";
//}
