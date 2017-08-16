//
//  CommentTableViewCell.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/15.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "CommentTableViewCell.h"

#define LabelHeight 30
#define StartWidth 15

@implementation CommentTableViewCell

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
        self.iconiamgeView = [[UIImageView alloc] init];
        self.iconiamgeView.image = [UIImage imageNamed:@"logo"];
        [self addSubview:self.iconiamgeView];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.textColor = [UIColor colorWithHexString:@"4b6e95"];
        [self addSubview:self.nameLabel];
        self.markLabel = [[UILabel alloc] init];
        self.markLabel.font = [UIFont systemFontOfSize:13];
        self.markLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self addSubview:self.markLabel];
        self.starImageView1 = [[UIImageView alloc] init];
        [self addSubview:self.starImageView1];
        self.starImageView2 = [[UIImageView alloc] init];
        [self addSubview:self.starImageView2];
        self.starImageView3 = [[UIImageView alloc] init];
        [self addSubview:self.starImageView3];
        self.starImageView4 = [[UIImageView alloc] init];
        [self addSubview:self.starImageView4];
        self.starImageView5 = [[UIImageView alloc] init];
        [self addSubview:self.starImageView5];
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.textColor = [UIColor colorWithHexString:@"999999"];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.timeLabel];
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self addSubview:self.contentLabel];
        self.selectLabel = [[UILabel alloc] init];
        self.selectLabel.textColor = [UIColor colorWithHexString:@"999999"];
        self.selectLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.selectLabel];
        self.replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.replyButton setTitle:@"回复" forState:UIControlStateNormal];
        [self.replyButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [self.replyButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        self.replyButton.contentHorizontalAlignment = NSTextAlignmentRight;
        [self addSubview:self.replyButton];
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
        [self addSubview:self.lineView];
        self.replyLabel = [[UILabel alloc] init];
        self.replyLabel.font = [UIFont systemFontOfSize:14];
        self.replyLabel.numberOfLines = 0;
        self.replyLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self addSubview:self.replyLabel];
        self.replyView = [[UIView alloc] init];
        [self addSubview:self.replyView];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage)];
        self.replay1 = [[UIImageView alloc] init];
        [_replay1 addGestureRecognizer:tap1];
        [self.replyView addSubview:self.replay1];
        self.replay2 = [[UIImageView alloc] init];
        [self.replay2 addGestureRecognizer:tap1];
        [self.replyView addSubview:self.replay2];
        self.replay3 = [[UIImageView alloc] init];
        [self.replay3 addGestureRecognizer:tap1];
        [self.replyView addSubview:self.replay3];

    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    /*
     加载cell
     */
    if (KscreeWidth == 320) {
        self.iconImageFrameWidth = 50;
        self.replyImageFrameWidth = 50;
    }else {
        self.iconImageFrameWidth = 50;
        self.replyImageFrameWidth = 75;
    }
    self.iconiamgeView.frame = CGRectMake(20, 20, self.iconImageFrameWidth, self.iconImageFrameWidth);
    self.iconiamgeView.layer.masksToBounds = YES;
    self.iconiamgeView.layer.cornerRadius = self.iconImageFrameWidth / 2;
    self.nameLabel.frame = CGRectMake(30 + self.iconImageFrameWidth, 15, 100, 30);
    self.timeLabel.frame = CGRectMake(KscreeWidth - 120, 20, 100, 30);
    self.timeLabel.text = @"9月10日";
    self.markLabel.frame = CGRectMake(30 + self.iconImageFrameWidth, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height, 42, 30);
    self.starImageView1.frame = CGRectMake(self.markLabel.frame.origin.x + self.markLabel.frame.size.width, self.markLabel.frame.origin.y + 7, StartWidth, StartWidth);
    self.starImageView1.image = [UIImage imageNamed:@"星"];
    self.starImageView2.frame = CGRectMake(self.markLabel.frame.origin.x + self.markLabel.frame.size.width + StartWidth, self.markLabel.frame.origin.y + 7, StartWidth, StartWidth);
    self.starImageView2.image = [UIImage imageNamed:@"星-拷贝-4"];
    self.starImageView3.frame = CGRectMake(self.markLabel.frame.origin.x + self.markLabel.frame.size.width + 2 * StartWidth, self.markLabel.frame.origin.y + 7, StartWidth, StartWidth);
    self.starImageView4.frame = CGRectMake(self.markLabel.frame.origin.x + self.markLabel.frame.size.width + 3 * StartWidth, self.markLabel.frame.origin.y + 7, StartWidth, StartWidth);
    self.starImageView5.frame = CGRectMake(self.markLabel.frame.origin.x + self.markLabel.frame.size.width + 4 * StartWidth, self.markLabel.frame.origin.y + 7, StartWidth, StartWidth);
    self.contentLabel.frame = CGRectMake(30 + self.iconImageFrameWidth, self.markLabel.frame.origin.y + 21 + 20, KscreeWidth - 30 - self.iconImageFrameWidth - 20, self.frameModel.contentFrame.size.height);
            self.replyView.frame = CGRectMake(30 + self.iconImageFrameWidth, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 15, self.replyImageFrameWidth * 3 + 6, _frameModel.replyImageFrame.size.height);
            self.replay1.image = [UIImage imageNamed:@"logo"];
            self.replay1.frame = CGRectMake(0, 0, _frameModel.replyImageFrame1.size.width, _frameModel.replyImageFrame1.size.width);
            self.replay2.image = [UIImage imageNamed:@"logo"];
            self.replay2.frame = CGRectMake(_frameModel.replyImageFrame2.size.width + 3, 0, _frameModel.replyImageFrame2.size.width, _frameModel.replyImageFrame2.size.width);
            self.replay3.image = [UIImage imageNamed:@"logo"];
            self.replay3.frame = CGRectMake(_frameModel.replyImageFrame2.size.width + _frameModel.replyImageFrame2.size.width + 6, 0, _frameModel.replyImageFrame3.size.width, _frameModel.replyImageFrame3.size.width);
    self.selectLabel.frame = CGRectMake(30 + self.iconImageFrameWidth, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 20 + self.replyView.frame.size.height, 100, LabelHeight);
    self.selectLabel.text = @"浏览量400";
    self.replyButton.frame = CGRectMake(KscreeWidth - 120, self.selectLabel.frame.origin.y, 100, LabelHeight);
    self.lineView.frame = CGRectMake(30 + self.iconImageFrameWidth, self.selectLabel.frame.origin.y + LabelHeight + 20, KscreeWidth - 30 - self.iconImageFrameWidth, 1);
    self.replyLabel.frame = CGRectMake(30 + self.iconImageFrameWidth, self.lineView.frame.origin.y + 20, KscreeWidth - 30 - self.iconImageFrameWidth - 20, self.frameModel.replyLablelFrame.size.height);
    /*
     赋值
     */
    self.contentLabel.text = _model.contents;
    NSMutableAttributedString *atstring = [[NSMutableAttributedString alloc] initWithString:_model.replys];
    [atstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0, 5)];//9 11
    self.replyLabel.attributedText = atstring;
//    self.replyLabel.text = _model.replys;
    self.nameLabel.text = _model.names;
    self.markLabel.text = _model.marks;
}
- (void) selectImage {
    //open image
}
@end
