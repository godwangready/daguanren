//
//  FriendsterPictureTableViewCell.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/14.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendPictureFrameModel.h"
#import "FriendPictureModel.h"
#import <AVFoundation/AVFoundation.h>

@interface FriendsterPictureTableViewCell : UITableViewCell<UITableViewDelegate, UITableViewDataSource>

/*
 控件
 */
@property (nonatomic, strong) UIImageView *iconiamgeView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIView *replyView;
@property (nonatomic, strong) UIImageView *replay1;
@property (nonatomic, strong) UIImageView *replay2;
@property (nonatomic, strong) UIImageView *replay3;
@property (nonatomic, strong) UIImageView *replay4;
@property (nonatomic, strong) UIImageView *replay5;
@property (nonatomic, strong) UIImageView *replay6;
@property (nonatomic, strong) UIImageView *replay7;
@property (nonatomic, strong) UIImageView *replay8;
@property (nonatomic, strong) UIImageView *replay9;
@property (nonatomic, strong) UIView *replyTabViewDown;
@property (nonatomic, strong) UITableView *replyTabelView;
@property (nonatomic, strong) FriendPictureModel *model;
@property (nonatomic, strong) FriendPictureFrameModel *cellFrame;
@property (nonatomic, strong) UIImageView *sanjiaoImageView;
@property (nonatomic, strong) UIImageView *playerImageView;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
