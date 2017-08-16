//
//  FriendsterPictureTableViewCell.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/14.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "FriendsterPictureTableViewCell.h"

@implementation FriendsterPictureTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = [UIImage imageNamed:@"logo"];
        [self addSubview:_iconImage];
        _nameLablel = [[UILabel alloc] init];
        _nameLablel.text = @"小小美";
        [self addSubview:_nameLablel];
        _contentLablel = [[UILabel alloc] init];
        _contentLablel.text = @"天气不错";
        _contentLablel.numberOfLines = 0;
        [self addSubview:_contentLablel];
        _arrPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        [self.contentView addSubview:_arrPicture];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _iconImage.frame = CGRectMake(_cellFrame.iconFrame.origin.x, _cellFrame.iconFrame.origin.y, _cellFrame.iconFrame.size.width, _cellFrame.iconFrame.size.height);
    _nameLablel.frame = CGRectMake(_cellFrame.nameFrame.origin.x, _cellFrame.nameFrame.origin.y, KscreeWidth - 140 - 20, 30);
    _contentLablel.frame = CGRectMake(_cellFrame.contentFrame.origin.x, _cellFrame.contentFrame.origin.y, _cellFrame.contentFrame.size.width, _cellFrame.contentFrame.size.height);
    _arrPicture.frame = CGRectMake(_cellFrame.arrimage.origin.x, _cellFrame.arrimage.origin.y, _cellFrame.arrimage.size.width, _cellFrame.arrimage.size.height);
}
@end
