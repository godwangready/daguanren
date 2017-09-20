//
//  PostTeacherFriendsterViewController.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/21.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"

@interface PostTeacherFriendsterViewController : BaseViewController
/*
 maybe only god understand
 */
@property (nonatomic, strong) NSMutableArray *whatArray;
//判断上传类型
@property (nonatomic, strong) NSString *postfriendid;
@property (nonatomic, strong) UIImage *videoimage;
@property (nonatomic, strong) NSString *VideoString;

@end
