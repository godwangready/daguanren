//
//  StoreCommentTableViewCell.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/31.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usercomment;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UIImageView *markImage1;
@property (weak, nonatomic) IBOutlet UIImageView *markImage2;
@property (weak, nonatomic) IBOutlet UIImageView *markImage3;
@property (weak, nonatomic) IBOutlet UIImageView *markImage4;
@property (weak, nonatomic) IBOutlet UIImageView *markImage5;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;

@end
