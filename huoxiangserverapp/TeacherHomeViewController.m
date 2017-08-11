//
//  TeacherHomeViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "TeacherHomeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LoginViewController.h"

#import "PKRecordShortVideoViewController.h"
#import "PKFullScreenPlayerViewController.h"

@interface TeacherHomeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, PKRecordShortVideoDelegate>

@end

@implementation TeacherHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *test = [UIButton buttonWithType:UIButtonTypeSystem];
    test.frame = CGRectMake(0, 0, KscreeWidth, 150);
    [test setTitle:@"技师测试退出" forState:UIControlStateNormal];
    [test addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    UIButton *test1 = [UIButton buttonWithType:UIButtonTypeSystem];
    test1.frame = CGRectMake(0, 150, KscreeWidth, 150);
    [test1 setTitle:@"相机测试" forState:UIControlStateNormal];
    [test1 addTarget:self action:@selector(startPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test1];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
}
- (void) startPlay {
//    [self choosevideo];
    [self readyGo];
}
- (void)readyGo {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [NSProcessInfo processInfo].globallyUniqueString;
    NSString *path = [paths[0] stringByAppendingPathComponent:[fileName stringByAppendingPathExtension:@"mp4"]];
    //跳转默认录制视频ViewController
    PKRecordShortVideoViewController *viewController = [[PKRecordShortVideoViewController alloc] initWithOutputFilePath:path outputSize:CGSizeMake(320, 240) themeColor:[UIColor orangeColor]];//[UIColor colorWithRed:0/255.0 green:153/255.0 blue:255/255.0 alpha:1]
    //通过代理回调
    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}
//视频拍摄完  开始播放
- (void)didFinishRecordingToOutputFilePath:(NSString *)outputFilePath {
    NSLog(@"%@", outputFilePath);
    
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:outputFilePath];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(0, 20, 300, 300);
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:playerLayer];
    
    [player play];
    
    UIView *videoMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    videoMaskView.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.3];
    [self.view addSubview:videoMaskView];

    //自定义的生成小视频聊天对象方法
    //    [self.demoData addShortVideoMediaMessageWithVideoPath:outputFilePath playType:PKPlayTypeAVPlayer];
    //JSQMessagesViewController的完成发送滚动到底端方法
    //    [self finishSendingMessageAnimated:YES];
    //跳转全屏播放小视频界面
    //    PKFullScreenPlayerViewController *viewController = [[PKFullScreenPlayerViewController alloc] initWithVideoPath:outputFilePath previewImage:[UIImage imageNamed:@"one.png"]];
    //    [self presentViewController:viewController animated:NO completion:NULL];
}
- (void) backAction {
    LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    SGLNavigationViewController *nav = [[SGLNavigationViewController alloc] initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark - delegate
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
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
