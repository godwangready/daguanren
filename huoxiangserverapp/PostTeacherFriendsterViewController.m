//
//  PostTeacherFriendsterViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/21.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "PostTeacherFriendsterViewController.h"
#import "ImagePickTableViewCell.h"
#import "PostTeacherFriendsterCollectionViewCell.h"
//相册
#import "LLImageCollectionCell.h"
#import "Config.h"
#import "LLImagePickerController.h"
#import "UIImage+LLAdd.h"
#import "LLCameraViewController.h"
#import "PKRecordShortVideoViewController.h"
#import <XLPhotoBrowser.h>

static NSString *cellid = @"pickcell";
static NSString *collectioncellid = @"friendsterCollectionCell";
@interface PostTeacherFriendsterViewController ()<UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    UIAlertController *alert;
}
@property (nonatomic, strong) UITextView *postFriendTV;
@property (nonatomic, strong) UILabel *tvPlaceHold;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) NSString *imageAdress;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UICollectionView *imageCollectView;
@property (nonatomic, strong) UITableView *imageTV;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) UIView *videoMaskView;
@end

@implementation PostTeacherFriendsterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch ([self.postfriendid integerValue]) {
        case 1:
        {
            self.dataArray = self.whatArray;
//            UIImage *images = [UIImage imageNamed:@"添加"];
//            [self.dataArray addObject:images];
        }
            break;
        case 2:
        {
            self.dataArray = self.whatArray;
            UIImage *images = [UIImage imageNamed:@"添加"];
            [self.dataArray addObject:images];
        }
            break;
        case 3:
        {
            self.dataArray = self.whatArray;

        }
            break;
            
        default:
            break;
    }
    [self postFriendsterHeadView];
//    [self.view addSubview:self.imageTV];
    [self.view addSubview:self.imageCollectView];
    [self tapTF];
    _index = 0;
}
- (UITableView *)imageTV {
    if (!_imageTV) {
        _imageTV = [[UITableView alloc] initWithFrame:CGRectMake(20, self.postFriendTV.frame.origin.y + 100 + 20, KscreeWidth - 40, 80)];
//        _imageTV.delegate = self;
//        _imageTV.dataSource = self;
        _imageTV.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        [_imageTV registerNib:[UINib nibWithNibName:@"ImagePickTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
        _imageTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _imageTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _imageTV;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
- (UICollectionView *)imageCollectView {
    if (!_imageCollectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _imageCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, self.postFriendTV.frame.origin.y + 100 + 20, KscreeWidth - 40, KscreeHeight - 20 - 200) collectionViewLayout:layout];
        _imageCollectView.backgroundColor = [UIColor whiteColor];
        [_imageCollectView registerNib:[UINib nibWithNibName:@"PostTeacherFriendsterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectioncellid];
        _imageCollectView.delegate = self;
        _imageCollectView.dataSource = self;
        _imageCollectView.scrollEnabled = NO;
    }
    return _imageCollectView;
}
- (void) postFriendsterHeadView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(15, 30, 42, 21);
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"PingFang Medium.ttf" size:13]];
    [backButton addTarget:self action:@selector(friendNewbackAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightButton.frame = CGRectMake((KscreeWidth - 15 - 42), 30, 42, 18);
    [_rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [_rightButton.titleLabel setFont:[UIFont fontWithName:@"PingFang Medium.ttf" size:13]];
    [_rightButton addTarget:self action:@selector(addFriendsterAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightButton];
    self.postFriendTV = [[UITextView alloc] initWithFrame:CGRectMake(20, 74, KscreeWidth - 40, 100)];
    self.postFriendTV.delegate = self;
    [self.view addSubview:self.postFriendTV];
    self.tvPlaceHold  = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, KscreeWidth - 40, 21)];
    self.tvPlaceHold.text = @"说点什么呢";
    self.tvPlaceHold.textColor = [UIColor colorWithHexString:@"999999"];
    self.tvPlaceHold.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:14];
    self.postFriendTV.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.tvPlaceHold];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 63, KscreeWidth, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    [topView addSubview:line];
}
#pragma mark - 取消
- (void) friendNewbackAction {
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"" message:@"退出此次编辑" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
    }];
    [aler addAction:cancelAction];
    [aler addAction:okAction];
    [self presentViewController:aler animated:YES completion:nil];
}
#pragma mark - 发送
- (void) addFriendsterAction {
    if (self.postFriendTV.text.length == 0) {
        [CMMUtility showFailureWith:@"说点什么呢"];
        return;
    }
    if ([self.postfriendid integerValue] != 3) {
        [self postFriendster];
        return;
    }
    if ([self.postfriendid integerValue] == 3) {
        [self postVideo];
        return;
    }
}
#pragma mark - 上传视频
- (void)postVideo {
    NSURL *videoURL = [NSURL fileURLWithPath:self.VideoString];
    NSLog(@"found a video");
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:videoURL options:NSDataReadingUncached error:&error];
    if (!error) {
        double size = (long)data.length / 1024. / 1024.;
        //        self.vediolb.text = [NSString stringWithFormat:@"%.2fMB", size];
        if (size > 30.0) {
            //文件过大
            UIAlertController *alertt = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"视频文件不得大于30M" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertt addAction:cancle];
            [self presentViewController:alertt animated:YES completion:nil];
        } else {
            //            //保存数据
            //            //获取视频的thumbnail
            //            MPMoviePlayerController *player = [[MPMoviePlayerController alloc]initWithContentURL:videoURL] ;
            //            UIImage  *thumbnail = [player thumbnailImageAtTime:0.01 timeOption:MPMovieTimeOptionNearestKeyFrame];
            //            player = nil;
            //            self.vedioimage.image = thumbnail;
        }
    }
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manage POST:ALIpullImageAndVideo47 parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"xxxoo.mp4" mimeType:@"mp4"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *body = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [WTCJson dictionaryWithJsonString:body];
        NSLog(@"%@", dict);
        self.imageAdress = [NSString stringWithFormat:@"%@", [dict objectForKey:@"url"]];
        [self totleFriendsterMessage:@"2"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [CMMUtility showFailureWith:@"服务器故障"];
    }];

}
#pragma mark - 循环发送图片
- (void)postFriendster {
    self.rightButton.userInteractionEnabled = NO;
    NSInteger j;
    if ([self.postfriendid integerValue] == 2) {
        j = self.dataArray.count - 1;
    }else {
        j = self.dataArray.count;
    }
    for (int i = 0; i < j; i++) {
//        NSData *data = UIImagePNGRepresentation([_dataArray objectAtIndex:i]);
        NSData *data = UIImageJPEGRepresentation([_dataArray objectAtIndex:i], 0.5);
        AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
        manage.responseSerializer = [AFHTTPResponseSerializer serializer];
        manage.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manage POST:ALIpullImageAndVideo47 parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:data name:@"file" fileName:@"store.png" mimeType:@"png"];
            NSLog(@"%@", _dataArray);
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"%@", uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@", responseObject);
            NSString *body = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", [WTCJson dictionaryWithJsonString:body]);
            switch (self.dataArray.count) {
                case 1:
                {
                    if ([self.postfriendid integerValue] == 2) {
                        [CMMUtility showFailureWith:@"请添加图片"];
                    }else {
                        _imageAdress = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                        [self totleFriendsterMessage:@"1"];
                    }
                }
                    break;
                case 2:
                {
                    _imageAdress = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                    [self totleFriendsterMessage:@"1"];
                }
                    break;
                case 3:
                {
                    _index++;
                    if (!_imageAdress) {
                        _imageAdress = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                    }else {
                        _imageAdress = [NSString stringWithFormat:@"%@,%@",[NSString stringWithFormat:@"%@", _imageAdress], [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                        if (_index == 2) {
                            [self totleFriendsterMessage:@"1"];
                        }
                    }
                }
                    break;
                case 4:
                {
                    _index++;
                    if (!_imageAdress) {
                        _imageAdress = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                    }else {
                        _imageAdress = [NSString stringWithFormat:@"%@,%@",[NSString stringWithFormat:@"%@", _imageAdress], [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                        if (_index == 3) {
                            [self totleFriendsterMessage:@"1"];
                        }
                    }
                }
                    break;
                case 5:
                {
                    _index++;
                    if (!_imageAdress) {
                        _imageAdress = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                    }else {
                        _imageAdress = [NSString stringWithFormat:@"%@,%@",[NSString stringWithFormat:@"%@", _imageAdress], [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                        if (_index == 4) {
                            [self totleFriendsterMessage:@"1"];
                        }
                    }
                }
                    break;
                case 6:
                {
                    _index++;
                    if (!_imageAdress) {
                        _imageAdress = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                    }else {
                        _imageAdress = [NSString stringWithFormat:@"%@,%@",[NSString stringWithFormat:@"%@", _imageAdress], [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                        if (_index == 5) {
                            [self totleFriendsterMessage:@"1"];
                        }
                    }
                }
                    break;
                case 7:
                {
                    _index++;
                    if (!_imageAdress) {
                        _imageAdress = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                    }else {
                        _imageAdress = [NSString stringWithFormat:@"%@,%@",[NSString stringWithFormat:@"%@", _imageAdress], [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                        if (_index == 6) {
                            [self totleFriendsterMessage:@"1"];
                        }
                    }
                }
                    break;
                case 8:
                {
                    _index++;
                    if (!_imageAdress) {
                        _imageAdress = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                    }else {
                        _imageAdress = [NSString stringWithFormat:@"%@,%@",[NSString stringWithFormat:@"%@", _imageAdress], [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                        if (_index == 7) {
                            [self totleFriendsterMessage:@"1"];
                        }
                    }
                }
                    break;
                case 9:
                {
                    _index++;
                    if (!_imageAdress) {
                        _imageAdress = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                    }else {
                        _imageAdress = [NSString stringWithFormat:@"%@,%@",[NSString stringWithFormat:@"%@", _imageAdress], [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                        if (_index == 8) {
                            [self totleFriendsterMessage:@"1"];
                        }
                    }
                }
                    break;
                case 10:
                {
                    _index++;
                    if (!_imageAdress) {
                        _imageAdress = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                    }else {
                        _imageAdress = [NSString stringWithFormat:@"%@,%@",[NSString stringWithFormat:@"%@", _imageAdress], [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                        if (_index == 9) {
                            [self totleFriendsterMessage:@"1"];
                        }
                    }
                }
                    break;
                case 11:
                {
                    _index++;
                    if (!_imageAdress) {
                        _imageAdress = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                    }else {
                        _imageAdress = [NSString stringWithFormat:@"%@,%@",[NSString stringWithFormat:@"%@", _imageAdress], [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                        if (_index == 10) {
                            [self totleFriendsterMessage:@"1"];
                        }
                    }
                }
                    break;
                    
                default:
                    break;
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [CMMUtility showFailureWith:@"上传失败服务器故障"];
            self.rightButton.userInteractionEnabled = YES;
        }];
    }
}
- (void) totleFriendsterMessage:(NSString *)typeid {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableDictionary *outDict  = [self makeDict];
    [dict setObject:[NSString stringWithFormat:@"%@", self.postFriendTV.text] forKey:@"content"];
    [dict setObject:[NSString stringWithFormat:@"%@", self.imageAdress] forKey:@"videoUrl"];
    [dict setObject:[NSString stringWithFormat:@"%@", typeid] forKey:@"resourceType"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Releasedynamic] parameters:outDict success:^(NSDictionary *data) {
        self.rightButton.userInteractionEnabled = YES;
        _index = 0;
        _imageAdress = nil;
        if ([[NSString stringWithFormat:@"%@", [data objectForKey:@"resCode"]] integerValue] == 100) {
            [CMMUtility showSucessWith:@"发表成功"];
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:Nsnotificationsuccesspostfriendster object:nil];
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
//        NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
    } failure:^(NSError *error) {
        self.rightButton.userInteractionEnabled = YES;
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
#pragma mark - UICollectionViewDataSource,
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PostTeacherFriendsterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectioncellid forIndexPath:indexPath];
    if ([self.postfriendid integerValue] == 3) {
        UIImageView *videoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"播放按钮"]];
        if (KscreeWidth == 320) {
            videoImageView.frame = CGRectMake((60 - 30) / 2, (60 - 30) / 2, 30, 30);
        }else {
            videoImageView.frame = CGRectMake((80 - 30) / 2, (80 - 30) / 2, 30, 30);
        }
        cell.cellImageView.image = self.videoimage;
        [cell.cellImageView addSubview:videoImageView];
        return cell;
    }else {
        cell.cellImageView.image = self.dataArray[indexPath.row];
        return cell;
    }

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
#pragma mark  - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (KscreeWidth == 320) {
        return CGSizeMake(60, 60);

    }else {
        return CGSizeMake(80, 80);

    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}
#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.postfriendid integerValue] == 2) {
        if (_dataArray.count >10) {
            [CMMUtility showFailureWith:@"最多上传九张"];
            return;
        }
    }
    if ([self.postfriendid integerValue] == 1) {
        [XLPhotoBrowser showPhotoBrowserWithImages:self.dataArray currentImageIndex:0];
        return;
    }
    if ([self.postfriendid integerValue] == 3) {
        [self postplayfriendplayer:self.VideoString];
        return;
    }else {
        if ((indexPath.row + 1) == _dataArray.count) {
            [self presentViewController:alert animated:YES completion:nil];
        }else {
            [XLPhotoBrowser showPhotoBrowserWithImages:self.dataArray currentImageIndex:0];
        }
    }
    
}
#pragma mark -播放视频通知
- (void) postplayfriendplayer:(NSString *)strurl {
//    NSURL *sourceMovieURL = [NSURL URLWithString:strurl];
        NSURL *sourceMovieURL = [NSURL fileURLWithPath:strurl];
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
#pragma mark - 获取相册
- (void) tapTF {
    alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LLCameraViewController *cameraVC = [[LLCameraViewController alloc] init];
        // 拍照获取相片回调
        [cameraVC getResultFromCameraWithBlock:^(UIImage *image, NSDictionary *info) {
                [_dataArray removeLastObject];
                [_dataArray addObject:image];
                UIImage * addimage = [UIImage imageNamed:@"添加"];
                [_dataArray addObject:addimage];
                [self.imageCollectView reloadData];
//            [self.imageTV reloadData];
        }];
        [self presentViewController:cameraVC animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imagePickAction];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
}
#pragma mark - 获取照片回调
- (void) imagePickAction {
    LLImagePickerController *navigationController = [[LLImagePickerController alloc] init];
    navigationController.autoJumpToPhotoSelectPage = YES;
    navigationController.allowSelectReturnType = NO;
    navigationController.maxSelectedCount = 9 - self.dataArray.count + 1;
    if (iOS8Upwards) {
        [navigationController getSelectedPHAssetsWithBlock:^(NSArray<UIImage *> *imageArray, NSArray<PHAsset *> *assetsArray) {
                [_dataArray removeLastObject];
                [_dataArray addObjectsFromArray:[NSArray arrayWithArray:imageArray]];
                UIImage * addimage = [UIImage imageNamed:@"添加"];
                [_dataArray addObject:addimage];
                [self.imageCollectView reloadData];
//            [self.imageTV reloadData];
        }];
    } else {
        [navigationController getSelectedALAssetsWithBlock:^(NSArray<UIImage *> *imageArray, NSArray<ALAsset *> *assetsArray) {
            self.dataArray = (NSMutableArray *)[NSArray arrayWithArray:imageArray];
            [self.imageCollectView reloadData];
//            [self.imageTV reloadData];


        }];
    }
    [self presentViewController:navigationController animated:YES completion:nil];
}
#pragma mark - 选取视频delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    /*
     视频上传
     */
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSLog(@"found a video");
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:videoURL options:NSDataReadingUncached error:&error];
    if (!error) {
        double size = (long)data.length / 1024. / 1024.;
        //        self.vediolb.text = [NSString stringWithFormat:@"%.2fMB", size];
        if (size > 30.0) {
            //文件过大
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"视频文件不得大于30M" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancle];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            //            //保存数据
            //            //获取视频的thumbnail
            //            MPMoviePlayerController *player = [[MPMoviePlayerController alloc]initWithContentURL:videoURL] ;
            //            UIImage  *thumbnail = [player thumbnailImageAtTime:0.01 timeOption:MPMovieTimeOptionNearestKeyFrame];
            //            player = nil;
            //            self.vedioimage.image = thumbnail;
        }
    }
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    NSString *url = @"http://192.168.0.100:8080/statics/uploadresource";
    [manage POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"xxxoo.mp4" mimeType:@"mp4"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/*
 获取视屏
 */
//选择本地视频
- (void)choosevideo
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.delegate = self;//设置委托
    
}
//录制视频
- (void)startvideo
{
    //Privacy - Camera Usage Description
    //NSMicrophoneUsageDescription
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.videoMaximumDuration = 30.0f;//30秒
    ipc.delegate = self;//设置委托
    
}
- (CGFloat) getFileSize:(NSString *)path
{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat) getVideoLength:(NSURL *)URL
{
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}//此方法可以获取视频文件的时长。

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.tvPlaceHold.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.postFriendTV.text.length == 0) {
        self.tvPlaceHold.hidden = NO;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.postFriendTV resignFirstResponder];
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
