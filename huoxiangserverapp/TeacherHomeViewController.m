//
//  TeacherHomeViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "TeacherHomeViewController.h"
#import "TeacherFriendsterViewController.h"
#import "TeacherBindingStoreViewController.h"
#import "TeacherVideoViewController.h"
#import "ClientCommentViewController.h"
#import "TeacherBindedViewController.h"
//录制
//#import "LLCameraViewController.h"
//#import "Config.h"
//#import "LLImagePickerController.h"
//#import "UIImage+LLAdd.h"
//#import "LLCameraViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#define ORIGINAL_MAX_WIDTH 640.0f
@interface TeacherHomeViewController ()<UITableViewDataSource, UITableViewDelegate, VPImageCropperDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate> {
    UIAlertController *alert;
}

@property (nonatomic, strong) UITableView *wtTableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *headNameLabel;
@property (nonatomic, strong) UILabel *headSixLabell;
@property (nonatomic, strong) UIImageView *headIconImageView;
@property (nonatomic, strong) UILabel *headAgeLabel;
@property (nonatomic, strong) UILabel *attentionLabel;
@property (nonatomic, strong) UILabel *visitLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSString *teacherBingBool;
@property (nonatomic, strong) UIImageView *backimageview;

@property (nonatomic, strong) UIButton *friendB;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIButton *bindindB;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIButton *commentB;
//解绑的主见ID
@property (nonatomic, strong) NSString *bindid;
//绑定店铺ID
@property (nonatomic, strong) NSString *storeId;
@end

@implementation TeacherHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestPersonMessage];
//    [self.view addSubview:self.wtTableView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    self.backimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 240)];
    self.backimageview.backgroundColor = [UIColor colorWithHexString:@"ff8042"];
    self.backimageview.userInteractionEnabled = YES;
    [self.view addSubview:self.backimageview];
//    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 240)];
//    self.wtTableView.tableHeaderView = self.headView;
//    self.headView.backgroundColor = [UIColor colorWithHexString:@"ff8042"];
    self.headIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(32, 80, 75, 75)];//76
    self.headIconImageView.layer.masksToBounds = YES;
    self.headIconImageView.layer.cornerRadius = 3;
    self.headIconImageView.userInteractionEnabled = YES;
    self.headIconImageView.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    UITapGestureRecognizer *tapPickIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPickIconAction)];
    [self.headIconImageView addGestureRecognizer:tapPickIcon];
    self.headNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(122, 80, 84, 21)];
    self.headSixLabell = [[UILabel alloc] initWithFrame:CGRectMake(122 + 84, 80, 42, 21)];
    self.headAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(122 + 84 + 42 + 12, 80, 42, 21)];
    self.attentionLabel = [[UILabel alloc] initWithFrame:CGRectMake(122, 80 + 75 - 21, 100, 21)];
    self.visitLabel = [[UILabel alloc] initWithFrame:CGRectMake(122 + 84 + 15, 80 + 75 - 21, 100, 21)];
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 220, KscreeWidth, 20)];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    self.headNameLabel.text = @"";
    self.headNameLabel.adjustsFontSizeToFitWidth = YES;
    self.headAgeLabel.text = @"";
    self.headSixLabell.text = @"";
    self.attentionLabel.text = @"";
    self.attentionLabel.adjustsFontSizeToFitWidth = YES;
    self.visitLabel.text = @"";
    self.visitLabel.adjustsFontSizeToFitWidth = YES;
    self.headNameLabel.textColor = [UIColor whiteColor];
    self.headAgeLabel.textColor = [UIColor whiteColor];
    self.headSixLabell.textColor = [UIColor whiteColor];
    self.attentionLabel.textColor = [UIColor whiteColor];
    self.visitLabel.textColor = [UIColor whiteColor];
    [self.backimageview addSubview:self.headIconImageView];
    [self.backimageview addSubview:self.headNameLabel];
    [self.backimageview addSubview:self.headSixLabell];
    [self.backimageview addSubview:self.headAgeLabel];
    [self.backimageview addSubview:self.attentionLabel];
    [self.backimageview addSubview:self.visitLabel];
    [self.backimageview addSubview:self.lineView];
    
    _friendB = [UIButton buttonWithType:UIButtonTypeCustom];
    _friendB.frame = CGRectMake(0, self.backimageview.frame.size.height, KscreeWidth, 55);
    _friendB.backgroundColor = [UIColor whiteColor];
    [self.friendB addTarget:self action:@selector(friendAction) forControlEvents:UIControlEventTouchUpInside];
//    UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    [_friendB.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_friendB setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [_friendB setTitleEdgeInsets:UIEdgeInsetsMake(0, - KscreeWidth / 2 - 100, 0, 0)];
    [_friendB setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, - KscreeWidth / 2 - 200)];
    [_friendB setImage:[UIImage imageNamed:@"进入"] forState:UIControlStateNormal];
    [_friendB setTitle:@"我的动态" forState:UIControlStateNormal];
    [self.view addSubview:self.friendB];
    
    _line1 = [[UIView alloc] initWithFrame:CGRectMake(0, _friendB.frame.origin.y + _friendB.frame.size.height, KscreeWidth, 1)];
    _line1.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    [self.view addSubview:_line1];
    
    _bindindB = [UIButton buttonWithType:UIButtonTypeCustom];
    _bindindB.backgroundColor = [UIColor whiteColor];
    _bindindB.frame = CGRectMake(0, self.backimageview.frame.size.height + 55 + 1, KscreeWidth, 55);
    [_bindindB addTarget:self action:@selector(bindingAction) forControlEvents:UIControlEventTouchUpInside];
    [_bindindB.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_bindindB setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [_bindindB setTitleEdgeInsets:UIEdgeInsetsMake(0, - KscreeWidth / 2 - 100, 0, 0)];
    [_bindindB setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, - KscreeWidth / 2 - 200)];
    [_bindindB setImage:[UIImage imageNamed:@"进入"] forState:UIControlStateNormal];
    [_bindindB setTitle:@"绑定店铺" forState:UIControlStateNormal];
    [self.view addSubview:self.bindindB];
    
    _line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _bindindB.frame.origin.y + _bindindB.frame.size.height, KscreeWidth, 1)];
    _line2.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    [self.view addSubview:_line2];
    
    _commentB = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentB.backgroundColor = [UIColor whiteColor];
    _commentB.frame = CGRectMake(0, self.backimageview.frame.size.height +55 + 55 + 2, KscreeWidth, 55);
    [_commentB addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [_commentB.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_commentB setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [_commentB setTitleEdgeInsets:UIEdgeInsetsMake(0, - KscreeWidth / 2 - 100, 0, 0)];
    [_commentB setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, - KscreeWidth / 2 - 200)];
    [_commentB setImage:[UIImage imageNamed:@"进入"] forState:UIControlStateNormal];
    [_commentB setTitle:@"客户评论" forState:UIControlStateNormal];
    [self.view addSubview:self.commentB];
}
- (void) friendAction {
    TeacherVideoViewController *vc = [[TeacherVideoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void) bindingAction{
    NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@", [userid objectForKey:@"bindingstatus"]);

    if ([[NSString stringWithFormat:@"%@",[userid objectForKey:@"bindingstatus"]] integerValue] == 1) {
        TeacherBindedViewController *vc = [[TeacherBindedViewController alloc] initWithNibName:@"TeacherBindedViewController" bundle:nil];
        vc.bindingId = self.bindid;
        vc.storeId = self.storeId;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        TeacherBindingStoreViewController *vc = [[TeacherBindingStoreViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void) commentAction {
    ClientCommentViewController *vc = [[ClientCommentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (UITableView *)wtTableView {
    if (!_wtTableView) {
        _wtTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, KscreeHeight - 48)];//165 + 240
        _wtTableView.delegate = self;
        _wtTableView.dataSource = self;
        _wtTableView.scrollEnabled = NO;
        _wtTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _wtTableView.backgroundColor = [UIColor whiteColor];
    }
    return _wtTableView;
}
- (void)requestPersonMessage {
    NSMutableDictionary *outDict = [self makeDict];
    [outDict setObject:@"server_index" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Userdetail] parameters:outDict success:^(NSDictionary *data) {
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
        
            }else {
                self.bindid = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"bindingId"]];
                self.storeId = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"storeId"]];
                NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
                [userid setObject:[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"bindingStatus"]] forKey:@"bindingstatus"];
                [userid synchronize];
                NSLog(@"%@", [userid objectForKey:@"bindingstatus"]);
                self.headNameLabel.text = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"nickName"]];
                self.servername = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"nickName"]];
                self.headAgeLabel.text = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"age"]];
                self.serverage = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"age"]];
                self.servericonimage = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"headPortrait"]];
//                [self.backimageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"headPortrait"]]] placeholderImage:[UIImage imageNamed:@"logo"]];
                switch ([[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"sex"]] integerValue]) {
                    case 0:
                    {
                        self.headSixLabell.text = @"保密";
                    }
                        break;
                    case 1:
                    {
                        self.headSixLabell.text = @"男";
                    }
                        break;
                    case 2:
                    {
                        self.headSixLabell.text = @"女";
                    }
                        break;
                        
                    default:
                        break;
                }
                self.attentionLabel.text = @"";
                self.attentionLabel.adjustsFontSizeToFitWidth = YES;
                self.visitLabel.text = @"";
                [self.headIconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"headPortrait"]]] placeholderImage:[UIImage imageNamed:@"logo"]];
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
#pragma mark - 设置头像
- (void) tapPickIconAction {
    [self editPortrait];
}

- (void)editPortrait {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}
#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.headIconImageView.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
        [self postheadpicture:editedImage];
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - 上传头像
- (void) postheadpicture:(UIImage *)selectimage {
    NSData *data = UIImageJPEGRepresentation(selectimage, 0.5);
    //    NSData *dataa = UIImagePNGRepresentation(imageee);
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    //        NSString *url = @"http://192.168.0.100:8080/statics/uploadresource";
    [manage POST:ALIpullImageAndVideo47 parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"one.png" mimeType:@"png"];
        //            [formData appendPartWithFileData:dataa name:@"file" fileName:@"two.png" mimeType:@"png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSString *body = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        [self postimage:[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.userInfo);
    }];
}
- (void) postimage:(NSString *)imageaddress {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableDictionary *outDict = [self makeDict];
    [dict setObject:@"3" forKey:@"roleId"];
    [dict setObject:imageaddress forKey:@"headPortrait"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [outDict setObject:@"server_index" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Changeheadportrait] parameters:outDict success:^(NSDictionary *data) {
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            [CMMUtility showSucessWith:@"修改成功"];
            [self requestPersonMessage];
        }else {
//            [CMMUtility showFailureWith:@"%@", [WTCJson j]];
        }
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // present the cropper view controller
        VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgCropperVC.delegate = self;
        [self presentViewController:imgCropperVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark - 发布类容选项
//- (void) tapTF {
//    alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    /*
//     拍照上传
//     */
//    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        LLCameraViewController *cameraVC = [[LLCameraViewController alloc] init];
//        // 拍照获取相片回调
//        [cameraVC getResultFromCameraWithBlock:^(UIImage *image, NSDictionary *info) {
//            
//        }];
//        [self presentViewController:cameraVC animated:YES completion:nil];
//    }]];
//    /*
//     相册选择
//     */
//    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self imagePickAction];
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//}
//#pragma mark - 点击选择相册
//- (void) imagePickAction {
//    LLImagePickerController *navigationController = [[LLImagePickerController alloc] init];
//    navigationController.autoJumpToPhotoSelectPage = NO;
//    navigationController.allowSelectReturnType = NO;
//    navigationController.maxSelectedCount = 1;
//    if (iOS8Upwards) {
//        [navigationController getSelectedPHAssetsWithBlock:^(NSArray<UIImage *> *imageArray, NSArray<PHAsset *> *assetsArray) {
//            
//        }];
//    } else {
//        [navigationController getSelectedALAssetsWithBlock:^(NSArray<UIImage *> *imageArray, NSArray<ALAsset *> *assetsArray) {
////            self.dataArray = (NSMutableArray *)[NSArray arrayWithArray:imageArray];
//            
//        }];
//    }
//    [self presentViewController:navigationController animated:YES completion:nil];
//}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            TeacherVideoViewController *vc = [[TeacherVideoViewController alloc] init];
            vc.serverage = self.serverage;
            vc.servername = self.servername;
            vc.servericonimage = self.servericonimage;
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 1:
        {
            NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
            if ([[NSString stringWithFormat:@"%@", [userid objectForKey:@"bindingstatus"]] integerValue] == 1) {
                TeacherBindedViewController *vc = [[TeacherBindedViewController alloc] initWithNibName:@"TeacherBindedViewController" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                TeacherBindingStoreViewController *vc = [[TeacherBindingStoreViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }

//            te
        }
            break;
        case 2:
        {
            ClientCommentViewController *vc = [[ClientCommentViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;//self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"我的动态";
            cell.textLabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"绑定店铺";
            cell.textLabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];


        }
            break;
        case 2:
        {
            cell.textLabel.text = @"客户评论";
            cell.textLabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];


        }
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [self requestPersonMessage];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self showTabBar];
    [super viewWillAppear:animated];

}
- (void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
