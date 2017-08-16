//
//  FriendsterPictureTableViewCell.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/14.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendPictureFrameModel.h"

@interface FriendsterPictureTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *nameLablel;
@property (nonatomic, strong) UILabel *contentLablel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UIImageView * arrPicture;
@property (nonatomic, strong) FriendPictureFrameModel *cellFrame;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
