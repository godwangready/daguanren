//
//  CommentTableViewCell.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/15.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentFrameModel.h"
#import "CommentModel.h"
#import "CommentCaoTableViewCell.h"

@interface CommentTableViewCell : UITableViewCell<UITableViewDelegate, UITableViewDataSource>
/*
 外层模型高度
 外层模型
 */
@property (nonatomic, strong) CommentFrameModel *frameModel;
@property (nonatomic, strong) CommentModel *model;
/*
 控件
 */
@property (nonatomic, strong) UIImageView *iconiamgeView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *markLabel;
@property (nonatomic, strong) UIImageView *starImageView1;
@property (nonatomic, strong) UIImageView *starImageView2;
@property (nonatomic, strong) UIImageView *starImageView3;
@property (nonatomic, strong) UIImageView *starImageView4;
@property (nonatomic, strong) UIImageView *starImageView5;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *selectLabel;
@property (nonatomic, strong) UIButton *replyButton;
@property (nonatomic, strong) UIView *replyView;
@property (nonatomic, strong) UIImageView *replay1;
@property (nonatomic, strong) UIImageView *replay2;
@property (nonatomic, strong) UIImageView *replay3;
@property (nonatomic, strong) UILabel *replyLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *replyTabViewDown;
@property (nonatomic, strong) UITableView *replyTabelView;
/*
 固定控件的Frame
 */
@property (nonatomic, assign) CGFloat iconImageFrameWidth;
@property (nonatomic, assign) CGFloat replyImageFrameWidth;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
