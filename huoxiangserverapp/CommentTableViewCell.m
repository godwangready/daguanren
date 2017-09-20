//
//  CommentTableViewCell.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/15.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "CommentTableViewCell.h"
#import <XLPhotoBrowser.h>

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
        self.markLabel.font = [UIFont systemFontOfSize:14];
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
#pragma mark - test
//        self.contentLabel.backgroundColor = [UIColor yellowColor];
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
        [self.replyButton addTarget:self action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.replyButton];
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
        [self addSubview:self.lineView];
        self.replyLabel = [[UILabel alloc] init];
        self.replyLabel.font = [UIFont systemFontOfSize:14];
        self.replyLabel.numberOfLines = 0;
        self.replyLabel.textColor = [UIColor colorWithHexString:@"333333"];
//        [self addSubview:self.replyLabel];
        self.replyView = [[UIView alloc] init];
#pragma mark - test
//        self.replyView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.replyView];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage)];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage)];
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage)];
        self.replay1 = [[UIImageView alloc] init];
        self.replay1.userInteractionEnabled = YES;
        [self.replay1 addGestureRecognizer:tap1];
        [self.replyView addSubview:self.replay1];
        self.replay2 = [[UIImageView alloc] init];
        self.replay2.userInteractionEnabled = YES;
        [self.replay2 addGestureRecognizer:tap2];
        [self.replyView addSubview:self.replay2];
        self.replay3 = [[UIImageView alloc] init];
        self.replay3.userInteractionEnabled = YES;
        [self.replay3 addGestureRecognizer:tap3];
        [self.replyView addSubview:self.replay3];

        self.replyTabViewDown = [[UIView alloc] init];
        [self addSubview:self.replyTabViewDown];
        self.replyTabelView = [[UITableView alloc] init];
        self.replyTabelView.delegate = self;
        self.replyTabelView.dataSource = self;
        self.replyTabelView.userInteractionEnabled = NO;
#pragma mark - test
//        self.replyTabelView.backgroundColor = [UIColor orangeColor];
        self.replyTabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.replyTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        static NSString *cellid = @"commentCaoCell";
        [self.replyTabelView registerNib:[UINib nibWithNibName:@"CommentCaoTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
        [self addSubview:self.replyTabelView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    /*
     加载cell
     */
    NSLog(@"%f", _frameModel.contentFrame.size.height);
    NSLog(@"%f",  _frameModel.replayDownViewFrame.size.height);
    NSLog(@"%f", _frameModel.replyImageFrame.size.height);
    NSLog(@"xxoo%ld", self.model.commentArray.count);
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
    [self.iconiamgeView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _model.userHeadPortrait]] placeholderImage:[UIImage imageNamed:@"logo"]];
    self.nameLabel.frame = CGRectMake(30 + self.iconImageFrameWidth, 15, 100, 30);
    self.nameLabel.text = [NSString stringWithFormat:@"%@", _model.userNickName];
    self.timeLabel.frame = CGRectMake(KscreeWidth - 120, 20, 100, 30);
    self.timeLabel.text = @"9月10日";
    self.markLabel.frame = CGRectMake(30 + self.iconImageFrameWidth, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height, 30, 30);
    self.markLabel.text = @"打分";
    self.starImageView1.frame = CGRectMake(self.markLabel.frame.origin.x + self.markLabel.frame.size.width, self.markLabel.frame.origin.y + 7, StartWidth, StartWidth);
    self.starImageView1.image = [UIImage imageNamed:@"星-拷贝-4"];
    self.starImageView2.frame = CGRectMake(self.markLabel.frame.origin.x + self.markLabel.frame.size.width + StartWidth, self.markLabel.frame.origin.y + 7, StartWidth, StartWidth);
    self.starImageView2.image = [UIImage imageNamed:@"星-拷贝-4"];
    self.starImageView3.frame = CGRectMake(self.markLabel.frame.origin.x + self.markLabel.frame.size.width + 2 * StartWidth, self.markLabel.frame.origin.y + 7, StartWidth, StartWidth);
    self.starImageView3.image = [UIImage imageNamed:@"星-拷贝-4"];
    self.starImageView4.frame = CGRectMake(self.markLabel.frame.origin.x + self.markLabel.frame.size.width + 3 * StartWidth, self.markLabel.frame.origin.y + 7, StartWidth, StartWidth);
    self.starImageView4.image = [UIImage imageNamed:@"星-拷贝-4"];
    self.starImageView5.frame = CGRectMake(self.markLabel.frame.origin.x + self.markLabel.frame.size.width + 4 * StartWidth, self.markLabel.frame.origin.y + 7, StartWidth, StartWidth);
    self.starImageView5.image = [UIImage imageNamed:@"星-拷贝-4"];
    switch ([self.model.starLevel intValue]) {
        case 1:
        {
            self.starImageView1.image = [UIImage imageNamed:@"星"];
        }
            break;
        case 2:
        {
            self.starImageView1.image = [UIImage imageNamed:@"星"];
            self.starImageView2.image = [UIImage imageNamed:@"星"];
            
        }
            break;
        case 3:
        {
            self.starImageView1.image = [UIImage imageNamed:@"星"];
            self.starImageView2.image = [UIImage imageNamed:@"星"];
            self.starImageView3.image = [UIImage imageNamed:@"星"];
        }
            break;
        case 4:
        {
            self.starImageView1.image = [UIImage imageNamed:@"星"];
            self.starImageView2.image = [UIImage imageNamed:@"星"];
            self.starImageView3.image = [UIImage imageNamed:@"星"];
            self.starImageView4.image = [UIImage imageNamed:@"星"];
        }
            break;
        case 5:
        {
            self.starImageView1.image = [UIImage imageNamed:@"星"];
            self.starImageView2.image = [UIImage imageNamed:@"星"];
            self.starImageView3.image = [UIImage imageNamed:@"星"];
            self.starImageView4.image = [UIImage imageNamed:@"星"];
            self.starImageView5.image = [UIImage imageNamed:@"星"];
        }
            break;
        case 0:
        {
            self.starImageView1.image = [UIImage imageNamed:@"星-拷贝-4"];
            self.starImageView1.image = [UIImage imageNamed:@"星-拷贝-4"];
            self.starImageView1.image = [UIImage imageNamed:@"星-拷贝-4"];
            self.starImageView1.image = [UIImage imageNamed:@"星-拷贝-4"];
            self.starImageView1.image = [UIImage imageNamed:@"星-拷贝-4"];
            self.starImageView1.image = [UIImage imageNamed:@"星-拷贝-4"];
        }
            break;
            
        default:
            break;
    }

    self.contentLabel.frame = CGRectMake(30 + self.iconImageFrameWidth, self.markLabel.frame.origin.y + 21 + 20, KscreeWidth - 30 - self.iconImageFrameWidth - 20, self.frameModel.contentFrame.size.height);
    self.contentLabel.text = [NSString stringWithFormat:@"%@", _model.content];
    self.replyView.frame = CGRectMake(30 + self.iconImageFrameWidth, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 15, self.replyImageFrameWidth * 3 + 6, _frameModel.replyImageFrame.size.height);
    self.replay1.frame = CGRectMake(0, 0, _frameModel.replyImageFrame1.size.width, _frameModel.replyImageFrame1.size.width);
    self.replay2.frame = CGRectMake(_frameModel.replyImageFrame2.size.width + 3, 0, _frameModel.replyImageFrame2.size.width, _frameModel.replyImageFrame2.size.width);
    self.replay3.frame = CGRectMake(_frameModel.replyImageFrame2.size.width + _frameModel.replyImageFrame2.size.width + 6, 0, _frameModel.replyImageFrame3.size.width, _frameModel.replyImageFrame3.size.width);
    if (self.model.replyImagesArray.count >= 3) {
        [self.replay1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]]] placeholderImage:[UIImage imageNamed:@"logo"]];
        [self.replay2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[1]]] placeholderImage:[UIImage imageNamed:@"logo"]];
        [self.replay3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[2]]] placeholderImage:[UIImage imageNamed:@"logo"]];
    }else {
        switch (self.model.replyImagesArray.count) {
            case 1:
            {
                [self.replay1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]]] placeholderImage:[UIImage imageNamed:@"logo"]];
            }
                break;
            case 2:
            {
                [self.replay1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[1]]] placeholderImage:[UIImage imageNamed:@"logo"]];
            }
                break;
            default:
                break;
        }
    }
    self.selectLabel.frame = CGRectMake(30 + self.iconImageFrameWidth, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 20 + self.replyView.frame.size.height, 100, LabelHeight);
    self.selectLabel.text = @"浏览量400";
    self.replyButton.frame = CGRectMake(KscreeWidth - 120, self.selectLabel.frame.origin.y, 100, LabelHeight);
    self.lineView.frame = CGRectMake(30 + self.iconImageFrameWidth, self.selectLabel.frame.origin.y + LabelHeight + 20, KscreeWidth - 30 - self.iconImageFrameWidth, 1);
//    self.replyLabel.frame = CGRectMake(30 + self.iconImageFrameWidth, self.lineView.frame.origin.y + 20, KscreeWidth - 30 - self.iconImageFrameWidth - 20, self.frameModel.replyLablelFrame.size.height);
    self.replyTabViewDown.frame = CGRectMake(30 + self.iconImageFrameWidth, self.lineView.frame.origin.y + 20, KscreeWidth - 30 - self.iconImageFrameWidth - 20, self.frameModel.replayDownViewFrame.size.height);
    self.replyTabelView.frame = CGRectMake(30 + self.iconImageFrameWidth,self.lineView.frame.origin.y + 20, KscreeWidth - 30 - self.iconImageFrameWidth - 20, self.frameModel.replayDownViewFrame.size.height);

#pragma mark - test 刷新评论cell, 隐藏line
        if (self.frameModel.replayDownViewFrame.size.height == 0) {
            self.lineView.hidden = YES;
        }else {
            self.lineView.hidden = NO;
        }
    [self.replyTabelView reloadData];
    /*
     赋值
     */
//    self.contentLabel.text = _model.contents;
//    NSMutableAttributedString *atstring = [[NSMutableAttributedString alloc] initWithString:_model.replys];
//    [atstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0, 5)];//9 11
//    self.replyLabel.attributedText = atstring;
//    self.replyLabel.text = _model.replys;
//    self.nameLabel.text = _model.names;
//    self.markLabel.text = _model.marks;
}
#pragma mark -UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld", self.model.commentArray.count);
    return self.model.commentArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCellFrameModel *model = self.model.commentFrameArray[indexPath.row];
    return model.cellFrameH;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
#pragma mark - test
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"commentCaoCell";
    CommentCaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];

//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[CommentCaoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    /*
     NSString *phoneString = phonestr;//@"已发送短信验证码到12345678901";
     NSMutableAttributedString *atstring = [[NSMutableAttributedString alloc] initWithString:phoneString];
     [atstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"666666"] range:NSMakeRange(0, 9)];//9 11
     messageLabel.attributedText = atstring;
     */
    CommentCellModel *model = self.model.commentArray[indexPath.row];
//    NSString *namestring = [NSString stringWithFormat:@"%@：", model.userNickName];
    NSString *namestring = @"商家回复:";
    NSRange range = NSMakeRange(0, namestring.length);
    NSString *str = [NSString stringWithFormat:@"%@%@", namestring, model.content];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:range];
    cell.commentlabel.attributedText = string;
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", model.content];
    cell.commentlabel.numberOfLines = 0;
    cell.commentlabel.font = [UIFont systemFontOfSize:14];
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}
- (void) replyAction:(UIButton *)sender {
    if ([self.model.iscomment integerValue] == 0) {
//        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@", _model.commentId] forKey:@"commentId"];
        NSDictionary *dictt = [NSDictionary dictionaryWithObjects:@[self.model.commentId, self.model.userId] forKeys:@[@"commentId",@"touserid"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:NsnotificationReplyComment object:nil userInfo:dictt];
    }else {
        [CMMUtility showSucessWith:@"已有回复，不可重复回复"];
    }
}
- (void) selectImage {
    //open image
    NSLog(@"%@", self.model.replyImagesArray);
    [XLPhotoBrowser showPhotoBrowserWithImages:self.model.replyImagesArray currentImageIndex:0];
}
@end
