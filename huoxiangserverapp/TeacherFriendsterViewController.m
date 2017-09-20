//
//  TeacherFriendsterViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/21.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "TeacherFriendsterViewController.h"
#import "FriendsterPictureTableViewCell.h"
#import "FriendPictureModel.h"
#import "FriendPictureFrameModel.h"
#import "FriendCellModel.h"
#import "FriendCellFrameModel.h"
#import "PostTeacherFriendsterViewController.h"

//录制
#import "LLCameraViewController.h"
#import "Config.h"
#import "LLImagePickerController.h"
#import "UIImage+LLAdd.h"
#import "LLCameraViewController.h"
#import "PKRecordShortVideoViewController.h"
static NSString *cellpicture = @"picturecell";

@interface TeacherFriendsterViewController ()<UITableViewDelegate, UITableViewDataSource, PKRecordShortVideoDelegate> {
    UIAlertController *alert;
}
@property (nonatomic, strong) UITableView *friendTV;

//外层数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
//外层控件高度
@property (nonatomic, strong) NSMutableArray *frameArray;
//二层数据源
@property (nonatomic, strong) NSMutableArray *commentArray;
//二层控件高度
@property (nonatomic, strong) NSMutableArray *commentFrameArray;

//@property (nonatomic, strong) NSMutableArray *dataSource;
//@property (nonatomic, strong) NSMutableArray *frameDatasource;
//@property (nonatomic, strong) NSMutableArray *commentArray;
//@property (nonatomic, strong) NSMutableArray *commentFrameArray;
//@property (nonatomic, strong) NSMutableArray *frameArray;

@property (nonatomic, assign) CGFloat commentTotleH;
@property (nonatomic, assign) NSInteger indexPage;

@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *headNameLabel;
@property (nonatomic, strong) UIImageView *headSixImageView;
@property (nonatomic, strong) UIImageView *headIconImageView;
@property (nonatomic, strong) UILabel *headAgeLabel;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) UIView *videoMaskView;

//判断上传类型
//@property (nonatomic, strong) NSString *VideoString;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TeacherFriendsterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self friendsterHeadView];
    [self requestData];
    [self.view addSubview:self.friendTV];
    [self playvideo];
    [self tapTF];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteFriendsterAction:) name:NsnotificationDeleteTeacherFriendster object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(successpostfriendster) name:Nsnotificationsuccesspostfriendster object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playfriendplayer:) name:Nsnotificationplayfriendsterplayer object:nil];
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (NSMutableArray *)commentArray {
    if (!_commentArray) {
        _commentArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _commentArray;
}
- (NSMutableArray *)commentFrameArray {
    if (!_commentFrameArray) {
        _commentFrameArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _commentFrameArray;
}
- (NSMutableArray *)frameArray {
    if (!_frameArray) {
        _frameArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _frameArray;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
- (UITableView *)friendTV {
    if (!_friendTV) {
        _friendTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 69, KscreeWidth, KscreeHeight - 69) style:UITableViewStylePlain];
        _friendTV.delegate = self;
        _friendTV.dataSource = self;
        _friendTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //        _friendTV.mj_header =
        [_friendTV registerClass:[FriendsterPictureTableViewCell class] forCellReuseIdentifier:cellpicture];
        self.headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 150)];
        [self.headView sd_setImageWithURL:[NSURL URLWithString:self.servericonimage] placeholderImage:[UIImage imageNamed:@"logo"]];
        _friendTV.tableHeaderView = self.headView;
        self.headIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 50, 50)];
        self.headIconImageView.layer.masksToBounds = YES;
        self.headIconImageView.layer.cornerRadius = 3;
        [self.headIconImageView sd_setImageWithURL:[NSURL URLWithString:self.servericonimage] placeholderImage:[UIImage imageNamed:@"logo"]];
        self.headNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 80, KscreeWidth - 100, 21)];
        self.headSixImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 80 + 35, 15, 15)];
        self.headAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + 15 + 5, 80 + 30 + 3, 100, 20)];
        
//        self.headIconImageView.backgroundColor = [UIColor orangeColor];
        self.headNameLabel.text = self.servername;
        self.headAgeLabel.text = self.serverage;
//        self.headView.backgroundColor = [UIColor brownColor];
        self.headSixImageView.image = [UIImage imageNamed:@"女性"];

        [self.headView addSubview:self.headIconImageView];
        [self.headView addSubview:self.headNameLabel];
        [self.headView addSubview:self.headSixImageView];
        [self.headView addSubview:self.headAgeLabel];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return _friendTV;
}
#pragma mark -初始化视频控件
- (void) playvideo {
}
#pragma mark -播放视频通知
- (void) playfriendplayer:(NSNotification *)sender {
    NSString *strurl = [sender.userInfo objectForKey:@"videourl"];
    NSURL *sourceMovieURL = [NSURL URLWithString:strurl];
//    NSURL *sourceMovieURL = [NSURL fileURLWithPath:outputFilePath];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    _playerLayer.frame = CGRectMake(0, 0, KscreeWidth, KscreeHeight);
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:_playerLayer];
    [player play];
    _videoMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, KscreeHeight)];
    _videoMaskView.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidDownBlackView)];
    [_videoMaskView addGestureRecognizer:tap];
    [self.view addSubview:_videoMaskView];

}
#pragma mark - 点击关闭查看小视频
- (void) hidDownBlackView {
    [self.player pause];
    self.playerLayer.hidden = YES;
    self.videoMaskView.hidden = YES;
}
#pragma mark - 成功发布动态回执
- (void) successpostfriendster {
    [self requestData];
}
#pragma mark - 数据请求
- (void)requestData {
    [self.dataSource removeAllObjects];
    [self.frameArray removeAllObjects];
    [self.commentArray removeAllObjects];
    [self.commentFrameArray removeAllObjects];
    [self.friendTV reloadData];
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
    if ([userid objectForKey:@"userid"]) {
        [dict setObject:[NSString stringWithFormat:@"%@", [userid objectForKey:@"userid"]] forKey:@"serverId"];
    }else {
        [dict setObject:@"" forKey:@"serverId"];
    }
    [dict setObject:@"" forKey:@"resourceType"];
    [dict setObject:@"" forKey:@"currentPage"];
    [dict setObject:@"20" forKey:@"num"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [outDict setObject:@"server_dynamic_list" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Selfdynamiclist] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", data);
//        [_commentTV.mj_header endRefreshing];
        /*
         防止空数据
         */
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
                
            }else {
                NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
                /*
                 提起外层数据
                 */
                for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
                    NSLog(@"%@", dict);
                    /*
                     外层模型赋值
                     */
                    FriendPictureModel *model = [[FriendPictureModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    //存储时间
                    [model setValue:[NSString stringWithFormat:@"%@", [dict objectForKey:@"addTime"]] forKey:@"timedate"];
                    FriendPictureFrameModel *modelFrame = [[FriendPictureFrameModel alloc] init];
                    modelFrame.contentFrame = CGRectMake(0, 0, 0, [self wtFriendCalculatedHeight:[NSString stringWithFormat:@"%@", model.content]]);
                    /*
                     评论是否带图
                     */
                    if ([NSString stringWithFormat:@"%@", [dict objectForKey:@"videoUrl"]].length != 0) {
                        if (KscreeWidth == 320) {
                            NSString *str = @",";
                            if ([[NSString stringWithFormat:@"%@", [dict objectForKey:@"videoUrl"]] rangeOfString:str].location != NSNotFound) {
                                model.replyImagesArray = [NSMutableArray arrayWithArray:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"videoUrl"]] componentsSeparatedByString:@","]];
                            }else {
                                [model.replyImagesArray addObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"videoUrl"]]];
                            }
                            switch (model.replyImagesArray.count) {
                                case 1:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 50);
                                    
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                }
                                    break;
                                case 2:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 50);

                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                    modelFrame.replyImageFrame2 = CGRectMake(52, 0, 50, 50);
                                }
                                    break;
                                case 3:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 50);

                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                    modelFrame.replyImageFrame2 = CGRectMake(52, 0, 50, 50);
                                    modelFrame.replyImageFrame3 = CGRectMake(104, 0, 50, 50);
                                }
                                    break;
                                case 4:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 102);

                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                    modelFrame.replyImageFrame2 = CGRectMake(52, 0, 50, 50);
                                    modelFrame.replyImageFrame3 = CGRectMake(104, 0, 50, 50);
                                    modelFrame.replyImageFrame4 = CGRectMake(0, 52, 50, 50);
                                }
                                    break;
                                case 5:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 102);

                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                    modelFrame.replyImageFrame2 = CGRectMake(52, 0, 50, 50);
                                    modelFrame.replyImageFrame3 = CGRectMake(104, 0, 50, 50);
                                    modelFrame.replyImageFrame4 = CGRectMake(0, 52, 50, 50);
                                    modelFrame.replyImageFrame5 = CGRectMake(52, 52, 50, 50);
                                }
                                    break;
                                case 6:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 102);

                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                    modelFrame.replyImageFrame2 = CGRectMake(52, 0, 50, 50);
                                    modelFrame.replyImageFrame3 = CGRectMake(104, 0, 50, 50);
                                    modelFrame.replyImageFrame4 = CGRectMake(0, 52, 50, 50);
                                    modelFrame.replyImageFrame5 = CGRectMake(52, 52, 50, 50);
                                    modelFrame.replyImageFrame6 = CGRectMake(104, 52, 50, 50);
                                }
                                    break;
                                case 7:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 154);

                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                    modelFrame.replyImageFrame2 = CGRectMake(52, 0, 50, 50);
                                    modelFrame.replyImageFrame3 = CGRectMake(104, 0, 50, 50);
                                    modelFrame.replyImageFrame4 = CGRectMake(0, 52, 50, 50);
                                    modelFrame.replyImageFrame5 = CGRectMake(52, 52, 50, 50);
                                    modelFrame.replyImageFrame6 = CGRectMake(104, 52, 50, 50);
                                    modelFrame.replyImageFrame7 = CGRectMake(0, 104, 50, 50);
                                }
                                    break;
                                case 8:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 154);

                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                    modelFrame.replyImageFrame2 = CGRectMake(52, 0, 50, 50);
                                    modelFrame.replyImageFrame3 = CGRectMake(104, 0, 50, 50);
                                    modelFrame.replyImageFrame4 = CGRectMake(0, 52, 50, 50);
                                    modelFrame.replyImageFrame5 = CGRectMake(52, 52, 50, 50);
                                    modelFrame.replyImageFrame6 = CGRectMake(104, 52, 50, 50);
                                    modelFrame.replyImageFrame7 = CGRectMake(0, 104, 50, 50);
                                    modelFrame.replyImageFrame8 = CGRectMake(52, 104, 50, 50);
                                }
                                    break;
                                case 9:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 154);

                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                    modelFrame.replyImageFrame2 = CGRectMake(52, 0, 50, 50);
                                    modelFrame.replyImageFrame3 = CGRectMake(104, 0, 50, 50);
                                    modelFrame.replyImageFrame4 = CGRectMake(0, 52, 50, 50);
                                    modelFrame.replyImageFrame5 = CGRectMake(52, 52, 50, 50);
                                    modelFrame.replyImageFrame6 = CGRectMake(104, 52, 50, 50);
                                    modelFrame.replyImageFrame7 = CGRectMake(0, 104, 50, 50);
                                    modelFrame.replyImageFrame8 = CGRectMake(52, 104, 50, 50);
                                    modelFrame.replyImageFrame9 = CGRectMake(104, 104, 50, 50);
                                }
                                    break;
                                    
                                default:
                                    break;
                            }
                        }else {
//                            modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 75);
                            NSString *str = @",";
                            if ([[NSString stringWithFormat:@"%@", [dict objectForKey:@"videoUrl"]] rangeOfString:str].location != NSNotFound) {
                                model.replyImagesArray = [NSMutableArray arrayWithArray:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"videoUrl"]] componentsSeparatedByString:@","]];
                            }else {
                                [model.replyImagesArray addObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"videoUrl"]]];
                            }
                            //                            model.replyImagesArray = [NSMutableArray arrayWithArray:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"picture_url"]] componentsSeparatedByString:@","]];
                            switch (model.replyImagesArray.count) {
                                case 1:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 75);
                                    
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                }
                                    break;
                                case 2:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 75);
                                    
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(77, 0, 75, 75);
                                }
                                    break;
                                case 3:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 75);
                                    
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(77, 0, 75, 75);
                                    modelFrame.replyImageFrame3 = CGRectMake(154, 0, 75, 75);
                                }
                                    break;
                                case 4:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 152);
                                    
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(77, 0, 75, 75);
                                    modelFrame.replyImageFrame3 = CGRectMake(152, 0, 75, 75);
                                    modelFrame.replyImageFrame4 = CGRectMake(0, 77, 75, 75);
                                }
                                    break;
                                case 5:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 152);
                                    
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(77, 0, 75, 75);
                                    modelFrame.replyImageFrame3 = CGRectMake(154, 0, 75, 75);
                                    modelFrame.replyImageFrame4 = CGRectMake(0, 77, 75, 75);
                                    modelFrame.replyImageFrame5 = CGRectMake(75, 77, 75, 75);
                                }
                                    break;
                                case 6:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 152);
                                    
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(77, 0, 75, 75);
                                    modelFrame.replyImageFrame3 = CGRectMake(154, 0, 75, 75);
                                    modelFrame.replyImageFrame4 = CGRectMake(0, 77, 75, 75);
                                    modelFrame.replyImageFrame5 = CGRectMake(75, 77, 75, 75);
                                    modelFrame.replyImageFrame6 = CGRectMake(154, 75, 75, 75);
                                }
                                    break;
                                case 7:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 229);
                                    
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(77, 0, 75, 75);
                                    modelFrame.replyImageFrame3 = CGRectMake(154, 0, 75, 75);
                                    modelFrame.replyImageFrame4 = CGRectMake(0, 77, 75, 75);
                                    modelFrame.replyImageFrame5 = CGRectMake(75, 77, 75, 75);
                                    modelFrame.replyImageFrame6 = CGRectMake(154, 75, 75, 75);
                                    modelFrame.replyImageFrame7 = CGRectMake(0, 154, 75, 75);
                                }
                                    break;
                                case 8:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 229);
                                    
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(77, 0, 75, 75);
                                    modelFrame.replyImageFrame3 = CGRectMake(154, 0, 75, 75);
                                    modelFrame.replyImageFrame4 = CGRectMake(0, 77, 75, 75);
                                    modelFrame.replyImageFrame5 = CGRectMake(75, 77, 75, 75);
                                    modelFrame.replyImageFrame6 = CGRectMake(154, 75, 75, 75);
                                    modelFrame.replyImageFrame7 = CGRectMake(0, 154, 75, 75);
                                    modelFrame.replyImageFrame8 = CGRectMake(75, 154, 75, 75);
                                }
                                    break;
                                case 9:
                                {
                                    modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 229);
                                    
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(77, 0, 75, 75);
                                    modelFrame.replyImageFrame3 = CGRectMake(154, 0, 75, 75);
                                    modelFrame.replyImageFrame4 = CGRectMake(0, 77, 75, 75);
                                    modelFrame.replyImageFrame5 = CGRectMake(75, 77, 75, 75);
                                    modelFrame.replyImageFrame6 = CGRectMake(154, 75, 75, 75);
                                    modelFrame.replyImageFrame7 = CGRectMake(0, 154, 75, 75);
                                    modelFrame.replyImageFrame8 = CGRectMake(75, 154, 75, 75);
                                    modelFrame.replyImageFrame9 = CGRectMake(154, 154, 75, 75);
                                }
                                    break;
                                    
                                default:
                                    break;
                            }
                        }
                        
                    }else {
                        modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 0);
                    }
                    /*
                     是否有回复
                     */
                    if ([NSMutableArray arrayWithArray:[dict objectForKey:@"commentModels"]].count != 0) {
                        /*
                         遍历
                         */
                        self.commentTotleH = 0;
                        for (NSDictionary *dictt in [dict objectForKey:@"commentModels"]) {
                            /*
                             评论封装model数组
                             */
                            FriendCellModel *modell = [[FriendCellModel alloc] init];
                            [modell setValuesForKeysWithDictionary:dictt];
//                            modell.content = @"我手动添加的一条评论看我";
//                            modell.userNickName = @"小王";
                            [self.commentArray addObject:modell];
                            [model.commentArray addObject:modell];
                            /*
                             评论高度封装model数组
                             */
                            FriendCellFrameModel *modelcellFrame = [[FriendCellFrameModel alloc] init];
                            modelcellFrame.cellFrameH = [self wtFriendCalculatedHeight:[dictt objectForKey:@"content"]] + [self wtFriendCalculatedHeight:[dictt objectForKey:@"userNickName"]];
                            [self.commentFrameArray addObject:modelcellFrame];
                            [model.commentFrameArray addObject:modelcellFrame];
                            /*
                             计算评论总高度
                             */
                            self.commentTotleH = self.commentTotleH + [self wtFriendCalculatedHeight:[dictt objectForKey:@"content"]] + [self wtFriendCalculatedHeight:[dictt objectForKey:@"userNickName"]];
                            modelFrame.replayDownViewFrame = CGRectMake(0, 0, 0, self.commentTotleH);
                            modelFrame.replayTableViewFrame = CGRectMake(0, 0, 0, self.commentTotleH);
                            [self.dataSource addObject:model];
                            [self.frameArray addObject:modelFrame];
                            self.indexPage = model.currentPage.integerValue;
                            
                        }
//                        self.commentTotleH = 0;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.friendTV reloadData];
                        });
                    }else {
#warning mark - test
                        self.commentTotleH = 0;
//                        FriendCellModel *modell = [[FriendCellModel alloc] init];
//                        modell.content = @"我手动添加的一条评论看我";
//                        modell.userNickName = @"小王";
//                        [self.commentArray addObject:modell];
//                        [model.commentArray addObject:modell];
//                        /*
//                         评论高度封装model数组
//                         */
//                        FriendCellFrameModel *modelcellFrame = [[FriendCellFrameModel alloc] init];
//                        modelcellFrame.cellFrameH = [self wtFriendCalculatedHeight:
//                                                     modell.content];
//                        [self.commentFrameArray addObject:modelcellFrame];
//                        [model.commentFrameArray addObject:modelcellFrame];
//                        /*
//                         计算评论总高度
//                         */
//                        self.commentTotleH = self.commentTotleH + [self wtFriendCalculatedHeight:modell.content];
//                        modelFrame.replayDownViewFrame = CGRectMake(0, 0, 0, self.commentTotleH);
//                        modelFrame.replayTableViewFrame = CGRectMake(0, 0, 0, self.commentTotleH);
//
//                        [self.dataSource addObject:model];
//                        [self.frameArray addObject:modelFrame];
//
//                        FriendCellModel *modelll = [[FriendCellModel alloc] init];
//                        modelll.content = @"我手动添加的一条评论看我我手动添加的一条评论看我我手动添加的一条评论看我我手动添加的一条评论看我";
//                        modelll.userNickName = @"小王";
//                        [self.commentArray addObject:modelll];
//                        [model.commentArray addObject:modelll];
//                        /*
//                         评论高度封装model数组
//                         */
//                        FriendCellFrameModel *modelcellFramel = [[FriendCellFrameModel alloc] init];
//                        modelcellFramel.cellFrameH = [self wtFriendCalculatedHeight:
//                                                     modelll.content];
//                        [self.commentFrameArray addObject:modelcellFramel];
//                        [model.commentFrameArray addObject:modelcellFramel];
//                        /*
//                         计算评论总高度
//                         */
//                        self.commentTotleH = self.commentTotleH + [self wtFriendCalculatedHeight:modelll.content];
//                        modelFrame.replayDownViewFrame = CGRectMake(0, 0, 0, self.commentTotleH);
//                        modelFrame.replayTableViewFrame = CGRectMake(0, 0, 0, self.commentTotleH);
#warning mark - test
                        [self.dataSource addObject:model];
                        [self.frameArray addObject:modelFrame];
                        self.indexPage = model.currentPage.integerValue;
#warning
                    }
                    
                }
//                self.commentTotleH = 0;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.friendTV reloadData];
                });
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error.userInfo);
        [CMMUtility showFailureWith:@"服务器故障"];
        [self.friendTV.mj_header endRefreshing];
    }];
}
#pragma mark - 删除动态
- (void) deleteFriendsterAction:(NSNotification *)sender {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableDictionary *outDict = [self makeDict];
    [dict setObject:[NSString stringWithFormat:@"%@", [sender.userInfo objectForKey:@"dynamicId"]] forKey:@"dynamicId"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [outDict setObject:@"server_dynamic_list" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Deletedynamic] parameters:outDict success:^(NSDictionary *data) {
        if ([[NSString stringWithFormat:@"%@", [data objectForKey:@"resCode"]] integerValue] == 100) {
            [CMMUtility showSucessWith:@"删除成功"];
            [self requestData];
//            [self.friendTV reloadData];
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsterPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellpicture];
    if (!cell) {
        cell = [[FriendsterPictureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellpicture];
    }
    FriendPictureModel *model = self.dataSource[indexPath.row];
    FriendPictureFrameModel *frameModel = self.frameArray[indexPath.row];
    cell.cellFrame = frameModel;
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        FriendPictureFrameModel *frameModel = self.frameArray[indexPath.row];
//tu
//pinglun
//content
//gucan
    //图
//    if (frameModel.replyImageFrame.size.height >= 50) {
//        //一组
//        if (frameModel.replyImageFrame.size.height >= 50 && frameModel.replyImageFrame.size.height < 80) {
//            if (<#condition#>) {
//                <#statements#>
//            }
//        }else {
//            //二组
//            if (frameModel.replyImageFrame.size.height > 80 && frameModel.replyImageFrame.size.height <= 152) {
//                
//            }else {
//                //三组
//            }
//        }
//    }else {
//        
//    }
//    CommentFrameModel *frameModel = self.frameArray[indexPath.row];
    /*
     判断参数 控制外层height
     */
    if (frameModel.replyImageFrame.size.height >= 50) {
        //有图
        if (frameModel.replyImageFrame.size.height >= 50 && frameModel.replyImageFrame.size.height < 80) {
            if (KscreeWidth == 320) {
                //5S
                if (frameModel.replayDownViewFrame.size.height == 0) {
                    //无评论
                    return 70 + 24 + 10 - 44 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height ;//10
                    
                }else {
                    //有评论
                    return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height ;//20
                    
                }
                
            }else {
                //6以上
                if (frameModel.replayDownViewFrame.size.height == 0) {
                    return 70 + 24 + 10 - 44 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 20;
                    
                }else {
                    return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 20;
                    
                }
                
            }
        }
        if (frameModel.replyImageFrame.size.height >= 100 && frameModel.replyImageFrame.size.height <= 152) {
            if (KscreeWidth == 320) {
                //5S
                if (frameModel.replayDownViewFrame.size.height == 0) {
                    //无评论
                    return 70 + 24 + 10 - 44 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 50 ;//10
                    
                }else {
                    //有评论
                    return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 50 ;//20
                    
                }
                
            }else {
                //678
                if (frameModel.replayDownViewFrame.size.height == 0) {
                    return 70 + 24 + 10 - 44 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 75 + 20;
                    
                }else {
                    return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 75 + 20;
                    
                }
                
            }

        }
        if (frameModel.replyImageFrame.size.height > 152) {
            if (KscreeWidth == 320) {
                //5S
                if (frameModel.replayDownViewFrame.size.height == 0) {
                    //无评论
                    return 70 + 24 + 10 - 44 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 50 + 52 ;//20
                    
                }else {
                    //有评论
                    return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 50 + 52 ;//20
                    
                }
                
            }else {
                //678
                if (frameModel.replayDownViewFrame.size.height == 0) {
                    return 70 + 24 + 10 - 44 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 75 + 77 + 20;
                    
                }else {
                    return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 75 + 77 + 20;
                    
                }
                
            }

        }else {
            return 0;
        }
    }else {
        //无图
        return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height - 40 - 10;
    }
}
#pragma mark - navigationbar
- (void) friendsterHeadView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 30, 18)];
    [backButton setImage:[UIImage imageNamed:@"返回-"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(friendNewbackAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KscreeWidth / 2) - 50, 30, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"个人动态";
    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:titleLabel];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake((KscreeWidth - 15 - 18 - 5), 25, 28, 28);
//    rightButton.backgroundColor = [UIColor orangeColor];
    [rightButton setImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addFriendsterAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
}
- (void) friendNewbackAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 发布新动态
- (void) addFriendsterAction {
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 发布类容选项
- (void) tapTF {
    alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    /*
     拍照上传
     */
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LLCameraViewController *cameraVC = [[LLCameraViewController alloc] init];
        // 拍照获取相片回调
        [cameraVC getResultFromCameraWithBlock:^(UIImage *image, NSDictionary *info) {
        [self.dataArray addObject:image];
            if (self.dataArray.count <= 0) {
                
            }else {
                PostTeacherFriendsterViewController *vc = [[PostTeacherFriendsterViewController alloc] init];
                vc.whatArray = [self.dataArray mutableCopy];
                vc.postfriendid = @"1";
                [self.navigationController pushViewController:vc animated:YES];
                [self.dataArray removeAllObjects];
            }
        }];
        [self presentViewController:cameraVC animated:YES completion:nil];
    }]];
    /*
     添加录制视频按钮
     */
    [alert addAction:[UIAlertAction actionWithTitle:@"视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self startPlay];
    }]];
    /*
     相册选择
     */
    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imagePickAction];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
}
#pragma mark - 点击选择相册
- (void) imagePickAction {
    LLImagePickerController *navigationController = [[LLImagePickerController alloc] init];
    navigationController.autoJumpToPhotoSelectPage = YES;
    navigationController.allowSelectReturnType = NO;
    navigationController.maxSelectedCount = 9;
    if (iOS8Upwards) {
        [navigationController getSelectedPHAssetsWithBlock:^(NSArray<UIImage *> *imageArray, NSArray<PHAsset *> *assetsArray) {
            [self.dataArray addObjectsFromArray:[NSArray arrayWithArray:imageArray]];
                PostTeacherFriendsterViewController *vc = [[PostTeacherFriendsterViewController alloc] init];
            vc.whatArray = [self.dataArray mutableCopy];
            vc.postfriendid = @"2";
                [self.navigationController pushViewController:vc animated:YES];
            [self.dataArray removeAllObjects];
        }];
    } else {
        [navigationController getSelectedALAssetsWithBlock:^(NSArray<UIImage *> *imageArray, NSArray<ALAsset *> *assetsArray) {
            self.dataArray = (NSMutableArray *)[NSArray arrayWithArray:imageArray];
                PostTeacherFriendsterViewController *vc = [[PostTeacherFriendsterViewController alloc] init];
            vc.whatArray = [self.dataArray mutableCopy];
            vc.postfriendid = @"2";
                [self.navigationController pushViewController:vc animated:YES];
            [self.dataArray removeAllObjects];
        }];
    }
    [self presentViewController:navigationController animated:YES completion:nil];
}
#pragma mark - 点击录小视频
- (void) startPlay {
    //    [self choosevideo];
    [self readyGo];
}
- (void)readyGo {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [NSProcessInfo processInfo].globallyUniqueString;
    NSString *path = [paths[0] stringByAppendingPathComponent:[fileName stringByAppendingPathExtension:@"mp4"]];
    //跳转默认录制视频ViewController
    PKRecordShortVideoViewController *viewController = [[PKRecordShortVideoViewController alloc] initWithOutputFilePath:path outputSize:CGSizeMake(KscreeWidth, KscreeHeight) themeColor:[UIColor orangeColor]];//[UIColor colorWithRed:0/255.0 green:153/255.0 blue:255/255.0 alpha:1]
    //通过代理回调
    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}
#pragma mark - 录制完成拿到资源
- (void)didFinishRecordingToOutputFilePath:(NSString *)outputFilePath {
    NSLog(@"%@", outputFilePath);
    [self.dataArray addObject:outputFilePath];
    PostTeacherFriendsterViewController *vc = [[PostTeacherFriendsterViewController alloc] init];
    vc.whatArray = [self.dataArray mutableCopy];
    vc.postfriendid = @"3";
    vc.videoimage = [self getThumbnailImage:outputFilePath];
    vc.VideoString = outputFilePath;
    [self.navigationController pushViewController:vc animated:YES];
    [self.dataArray removeAllObjects];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self hideTabBar];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self showTabBar];
    [super viewWillDisappear:animated];
}
- (CGFloat)wtFriendCalculatedHeight:(NSString *)string {
    NSString *messageString1 = [NSString stringWithFormat:@"%@", string];
    CGSize messagesize1 = [messageString1 boundingRectWithSize:CGSizeMake(KscreeWidth - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    return messagesize1.height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
