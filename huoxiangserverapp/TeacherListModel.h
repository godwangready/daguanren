//
//  TeacherListModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/9.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"

/*
 age = 0;
 bindingId = 5;
 bindingStatus = 1;
 currentPage = 0;
 headPortrait = "";
 isShow = 0;
 limit = 20;
 maxRows = 5000;
 nickName = "";
 pages = 0;
 recommend = 0;
 serverId = 18;
 serverNamer = "";
 start = 0;
 storeId = 9;
 total = 0;
 */
@interface TeacherListModel : BaseModel

@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *bindingId;
@property (nonatomic, strong) NSString *bindingStatus;
@property (nonatomic, strong) NSString *currentPage;
@property (nonatomic, strong) NSString *headPortrait;
@property (nonatomic, strong) NSString *isShow;
@property (nonatomic, strong) NSString *limit;
@property (nonatomic, strong) NSString *maxRows;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *pages;
@property (nonatomic, strong) NSString *recommend;
@property (nonatomic, strong) NSString *serverId;
@property (nonatomic, strong) NSString *serverNamer;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *total;

@end
