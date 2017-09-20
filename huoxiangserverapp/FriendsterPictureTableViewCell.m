//
//  FriendsterPictureTableViewCell.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/14.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "FriendsterPictureTableViewCell.h"
#import "CommentCaoTableViewCell.h"
#import <XLPhotoBrowser.h>

static NSString *cellid = @"commentCaoCell";
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
        self.iconiamgeView = [[UIImageView alloc] init];
        self.iconiamgeView.image = [UIImage imageNamed:@"logo"];
        self.iconiamgeView.layer.masksToBounds = YES;
        self.iconiamgeView.layer.cornerRadius = 3;
        [self addSubview:self.iconiamgeView];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor colorWithHexString:@"4b6e95"];
        self.nameLabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:15];
        self.nameLabel.text = @"小妹";
        [self addSubview:self.nameLabel];
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.text = @"";
        self.timeLabel.adjustsFontSizeToFitWidth = YES;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self addSubview:self.timeLabel];
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.contentLabel];
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteButton setTitleColor:[UIColor colorWithHexString:@"4b6e95"] forState:UIControlStateNormal];
        [self.deleteButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:self.deleteButton];
        self.replyView = [[UIView alloc] init];
        [self addSubview:self.replyView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFriendsterImage)];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFriendsterImage)];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFriendsterImage)];
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFriendsterImage)];
        UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFriendsterImage)];
        UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFriendsterImage)];
        UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFriendsterImage)];
        UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFriendsterImage)];
        UITapGestureRecognizer *tap8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFriendsterImage)];
        self.replay1 = [[UIImageView alloc] init];
        self.replay2 = [[UIImageView alloc] init];
        self.replay3 = [[UIImageView alloc] init];
        self.replay4 = [[UIImageView alloc] init];
        self.replay5 = [[UIImageView alloc] init];
        self.replay6 = [[UIImageView alloc] init];
        self.replay7 = [[UIImageView alloc] init];
        self.replay8 = [[UIImageView alloc] init];
        self.replay9 = [[UIImageView alloc] init];
        [self.replay1 addGestureRecognizer:tap];
        [self.replay2 addGestureRecognizer:tap1];
        [self.replay3 addGestureRecognizer:tap2];
        [self.replay4 addGestureRecognizer:tap3];
        [self.replay5 addGestureRecognizer:tap4];
        [self.replay6 addGestureRecognizer:tap5];
        [self.replay7 addGestureRecognizer:tap6];
        [self.replay8 addGestureRecognizer:tap7];
        [self.replay9 addGestureRecognizer:tap8];
        self.replay1.userInteractionEnabled = YES;
        self.replay2.userInteractionEnabled = YES;
        self.replay3.userInteractionEnabled = YES;
        self.replay4.userInteractionEnabled = YES;
        self.replay5.userInteractionEnabled = YES;
        self.replay6.userInteractionEnabled = YES;
        self.replay7.userInteractionEnabled = YES;
        self.replay8.userInteractionEnabled = YES;
        self.replay9.userInteractionEnabled = YES;
        [self.replyView addSubview:self.replay1];
        [self.replyView addSubview:self.replay2];
        [self.replyView addSubview:self.replay3];
        [self.replyView addSubview:self.replay4];
        [self.replyView addSubview:self.replay5];
        [self.replyView addSubview:self.replay6];
        [self.replyView addSubview:self.replay7];
        [self.replyView addSubview:self.replay8];
        [self.replyView addSubview:self.replay9];
        self.replyTabViewDown = [[UIView alloc] init];
        [self addSubview:self.replyTabViewDown];
        self.replyTabelView = [[UITableView alloc] init];
        self.replyTabelView.delegate = self;
        self.replyTabelView.dataSource = self;//commentCaoCell
        [self.replyTabelView registerNib:[UINib nibWithNibName:@"CommentCaoTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
//        self.replyTabelView.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
        self.replyTabelView.scrollEnabled = NO;
        self.replyTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.replyTabViewDown addSubview:self.replyTabelView];
        self.sanjiaoImageView = [[UIImageView alloc] init];
        [self addSubview:self.sanjiaoImageView];
        self.playerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"播放按钮"]];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconiamgeView.frame = CGRectMake(20, 20, 50, 50);
    self.nameLabel.frame = CGRectMake(80, 20, 100, 20);
    self.timeLabel.frame = CGRectMake(KscreeWidth - 180, 20, 100, 20);
    self.deleteButton.frame = CGRectMake(KscreeWidth - 60, 20, 40, 20);
    self.contentLabel.frame = CGRectMake(80, self.nameLabel.frame.origin.y + 20 + 15, KscreeWidth - 80 - 20, self.cellFrame.contentFrame.size.height);
    //self.cellFrame.replyImageFrame.size.height
    self.replyView.frame = CGRectMake(80, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 20, 240 + 10, self.cellFrame.replyImageFrame.size.height);
    self.replay1.frame = CGRectMake(0, 0, self.cellFrame.replyImageFrame1.size.width, self.cellFrame.replyImageFrame1.size.width);
    self.replay2.frame = CGRectMake(self.cellFrame.replyImageFrame2.size.width + 3, 0, self.cellFrame.replyImageFrame2.size.width, self.cellFrame.replyImageFrame2.size.width);
    self.replay3.frame = CGRectMake(self.cellFrame.replyImageFrame2.size.width + self.cellFrame.replyImageFrame2.size.width + 6, 0, self.cellFrame.replyImageFrame3.size.width, self.cellFrame.replyImageFrame3.size.width);
    self.replay4.frame = CGRectMake(0, self.cellFrame.replyImageFrame3.size.width + 3, self.cellFrame.replyImageFrame4.size.width, self.cellFrame.replyImageFrame4.size.width);
    self.replay5.frame = CGRectMake(self.cellFrame.replyImageFrame3.size.width + 3, self.cellFrame.replyImageFrame3.size.width + 3, self.cellFrame.replyImageFrame5.size.width, self.cellFrame.replyImageFrame5.size.width);
    self.replay6.frame = CGRectMake(self.cellFrame.replyImageFrame3.size.width + 3 + self.cellFrame.replyImageFrame3.size.width, self.cellFrame.replyImageFrame3.size.width + 3, self.cellFrame.replyImageFrame6.size.width, self.cellFrame.replyImageFrame6.size.width);
    self.replay7.frame = CGRectMake(0, self.cellFrame.replyImageFrame3.size.width + self.cellFrame.replyImageFrame3.size.width + 3, self.cellFrame.replyImageFrame7.size.width, self.cellFrame.replyImageFrame7.size.width);
    self.replay8.frame = CGRectMake(self.cellFrame.replyImageFrame3.size.width + 3, self.cellFrame.replyImageFrame3.size.width + self.cellFrame.replyImageFrame3.size.width + 3, self.cellFrame.replyImageFrame8.size.width, self.cellFrame.replyImageFrame8.size.width);
    self.replay9.frame = CGRectMake(self.cellFrame.replyImageFrame3.size.width + self.cellFrame.replyImageFrame3.size.width + 6, self.cellFrame.replyImageFrame3.size.width + self.cellFrame.replyImageFrame3.size.width + 6, self.cellFrame.replyImageFrame9.size.width, self.cellFrame.replyImageFrame9.size.width);

    self.playerImageView.frame = CGRectMake((self.replay1.frame.size.width - 30) / 2, (self.replay1.frame.size.width - 30) / 2, 30, 30);
    [self.replay1 addSubview:self.playerImageView];
    self.playerImageView.hidden = YES;
        switch (self.model.replyImagesArray.count) {
            case 1:
            {
                NSString *strr = [NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]];
                if ([strr rangeOfString:@"mp4"].location != NSNotFound) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        self.replay1.image = [UIImage imageNamed:@"logo"];
                        self.replay1.image = [self friendlistgetThumbnailImage:strr];
                        self.playerImageView.hidden = NO;
                    });
//                    dispatch_queue_t queue=dispatch_get_main_queue();
//                    dispatch_async(queue, ^{
//                    });
                }else {
                    self.playerImageView.hidden = YES;
                    [self.replay1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                }
            }
                break;
            case 2:
            {
                [self.replay1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[1]]] placeholderImage:[UIImage imageNamed:@"logo"]];
            }
                break;
            case 3:
            {
                [self.replay1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[1]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[2]]] placeholderImage:[UIImage imageNamed:@"logo"]];
            }
                break;
            case 4:
            {
                [self.replay1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[1]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[2]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[3]]] placeholderImage:[UIImage imageNamed:@"logo"]];
            }
                break;
            case 5:
            {
                [self.replay1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[1]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[2]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[3]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay5 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[4]]] placeholderImage:[UIImage imageNamed:@"logo"]];


            }
                break;
            case 6:
            {
                [self.replay1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[1]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[2]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[3]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay5 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[4]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay6 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[5]]] placeholderImage:[UIImage imageNamed:@"logo"]];


            }
                break;
            case 7:
            {
                [self.replay1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[1]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[2]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[3]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay5 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[4]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay6 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[5]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay7 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[6]]] placeholderImage:[UIImage imageNamed:@"logo"]];

            }
                break;
            case 8:
            {
                [self.replay1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[1]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[2]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[3]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay5 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[4]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay6 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[5]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay7 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[6]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay8 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[7]]] placeholderImage:[UIImage imageNamed:@"logo"]];


            }
                break;
            case 9:
            {
                [self.replay1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[1]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[2]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[3]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay5 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[4]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay6 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[5]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay7 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[6]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay8 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[7]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                [self.replay9 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.model.replyImagesArray[8]]] placeholderImage:[UIImage imageNamed:@"logo"]];


            }
                break;
            default:
                break;
        }
//    self.replyTabViewDown.frame = CGRectMake(80, self.replyView.frame.origin.y + self.replyView.frame.size.height + 20, self.cellFrame.replayDownViewFrame.size.height, self.cellFrame.replayDownViewFrame.size.height + 13);
//    self.replyTabelView.frame = CGRectMake(80, self.replyView.frame.origin.y + self.replyView.frame.size.height + 20 + 13, KscreeWidth - 100, self.cellFrame.replayDownViewFrame.size.height);

    self.replyTabViewDown.frame = CGRectMake(80, self.replyView.frame.origin.y + self.replyView.frame.size.height + 20, KscreeWidth - 84, self.cellFrame.replayDownViewFrame.size.height + 20);

    self.replyTabelView.frame = CGRectMake(8, 10, KscreeWidth - 100, self.cellFrame.replayDownViewFrame.size.height);
    if (self.cellFrame.replayDownViewFrame.size.height > 0) {
        self.sanjiaoImageView.frame = CGRectMake(100, self.replyTabViewDown.frame.origin.y - 13, 20, 13);
        self.replyTabViewDown.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
    }
    self.sanjiaoImageView.image = [UIImage imageNamed:@"三角"];
    
    [self.iconiamgeView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _model.userHeadPortrait]] placeholderImage:[UIImage imageNamed:@"logo"]];
    if ([NSString stringWithFormat:@"%@", _model.userNickName].length == 0) {
        self.nameLabel.text = @"小花花";//[NSString stringWithFormat:@"%@", _model.userNickName];
    }else {
        self.nameLabel.text = [NSString stringWithFormat:@"%@", _model.userNickName];
    }
    self.contentLabel.text = [NSString stringWithFormat:@"%@", _model.content];
    [self.replyTabelView reloadData];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@", [self timeToDeadline:self.model.timedate]];
    NSLog(@"%@", self.nameLabel.text);
}
/*
 @计算时间差
 */
- (NSString *)timeToDeadline:(NSString *)timedate {
    NSTimeInterval time= ([timedate doubleValue]+28800) / 1000.0;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,设置需要的格式
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    NSLog(@"%@", currentDateStr);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"%@",currentTimeString);
    
    NSInteger timeDifference = [currentTimeString integerValue] - [currentDateStr integerValue];
    NSString *timeDifferences = [NSString stringWithFormat:@"%ld", timeDifference / 60 / 60];
    if ([timeDifferences integerValue] == 0) {
        timeDifferences = @"刚刚";
        return timeDifferences;
        
    }
    if ([timeDifferences integerValue] > 24) {
        timeDifferences = [NSString stringWithFormat:@"%ld", [timeDifferences integerValue] % 24];
        timeDifferences = [NSString stringWithFormat:@"%@天前", timeDifferences];
        return timeDifferences;
    }else {
        timeDifferences = [NSString stringWithFormat:@"%@小时前", timeDifferences];
        return timeDifferences;
    }
//    NSLog(@"%@", timeDifferences);
}
- (void) deleteAction {
    NSLog(@"删除动态");
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@", _model.dynamicId] forKey:@"dynamicId"];
    [[NSNotificationCenter defaultCenter] postNotificationName:NsnotificationDeleteTeacherFriendster object:nil userInfo:dict];
}
- (void)tapFriendsterImage {
    NSLog(@"%@", self.model.replyImagesArray);
    if (self.model.replyImagesArray.count == 1) {
        NSString *str = [NSString stringWithFormat:@"%@", self.model.replyImagesArray[0]];
        if ([str rangeOfString:@"png"].location != NSNotFound) {
            [XLPhotoBrowser showPhotoBrowserWithImages:self.model.replyImagesArray currentImageIndex:0];
        }else {
            //播放
            NSDictionary *dict = [NSDictionary dictionaryWithObject:str forKey:@"videourl"];
            [[NSNotificationCenter defaultCenter] postNotificationName:Nsnotificationplayfriendsterplayer object:nil userInfo:dict];
        }
    }else {
        WTlog(@"%@", self.model.replyImagesArray);
        [XLPhotoBrowser showPhotoBrowserWithImages:self.model.replyImagesArray currentImageIndex:0];
    }
}
#pragma mark -UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.commentArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCellFrameModel *model = self.model.commentFrameArray[indexPath.row];
    NSLog(@"%f", model.cellFrameH);
    return model.cellFrameH;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCaoTableViewCell" owner:nil options:nil] lastObject];
    }
    FriendCellModel *model = self.model.commentArray[indexPath.row];
    NSString *namestring = [NSString stringWithFormat:@"%@：", model.userNickName];
    NSRange range = NSMakeRange(0, namestring.length);
    NSString *str = [NSString stringWithFormat:@"%@%@", namestring, model.content];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:range];
    cell.commentlabel.attributedText = string;
//        cell.textLabel.text = [NSString stringWithFormat:@"%@", model.content];
    NSLog(@"xxxx%@", model.content);
    cell.commentlabel.numberOfLines = 0;
    cell.commentlabel.font = [UIFont systemFontOfSize:16];
    cell.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UIImage *)friendlistgetThumbnailImage:(NSString *)videoPath {
    if (videoPath) {
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoPath] options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        // 设定缩略图的方向
        // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的
        gen.appliesPreferredTrackTransform = YES;
        // 设置图片的最大size(分辨率)
        gen.maximumSize = CGSizeMake(300, 169);
        CMTime time = CMTimeMakeWithSeconds(5.0, 600); //取第5秒，一秒钟600帧
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        if (error) {
            UIImage *placeHoldImg = [UIImage imageNamed:@"posters_default_horizontal"];
            return placeHoldImg;
        }
        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        return thumb;
    } else {
        UIImage *placeHoldImg = [UIImage imageNamed:@"posters_default_horizontal"];
        return placeHoldImg;
    }
}
@end
