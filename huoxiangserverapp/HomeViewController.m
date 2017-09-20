//
//  HomeViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/19.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "HomeViewController.h"
#import "ManagemetViewController.h"
#import "CommentViewController.h"
#import "JishiViewController.h"
#import "StoreManagementViewController.h"
#import "StoreManageViewController.h"
#import "AddServicesViewController.h"
#import "UserCommentViewController.h"
#import "NowCertificationViewController.h"
#import "WSDatePickerView.h"
#import "CaoCertificationingViewController.h"
#define UpButtonTag 10000
#define DownButtonTag 20000
#define ButtonSizeWH 60//35
//#define ButtonSizeHW
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#define ORIGINAL_MAX_WIDTH 640.0f
@interface HomeViewController ()<VPImageCropperDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate> {
    UIView *topView;
    
    UILabel *nameLabel;
    UILabel *timeLable;
    UIButton *timeButton;
    
    UIView *downView;
    UIView *henView;
    UIView *shuoneView;
    UIView *shutwoView;
}
@property (nonatomic, strong) UIDatePicker *dataPick;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *postStartTime;
@property (nonatomic, strong) NSString *postEndTime;
@property (nonatomic, strong) UIImageView *iconImage;;

//店铺认证回显
@property (nonatomic, strong) NSString *storenamels;
@property (nonatomic, strong) NSString *storephones;
@property (nonatomic, strong) NSString *storeadress;
@property (nonatomic, strong) NSMutableArray *storepictureArray;
@property (nonatomic, strong) NSString *storenotes;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSString *adcode;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"f0f2f8"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNameAction) name:NsNotficationRefreshName object:nil];
    [self setTopView];
    [self setlayout];
//    [self requestPersonMessageData];
    [self ccrequestPersonMessageData];
}
- (NSMutableArray *)storepictureArray {
    if (!_storepictureArray) {
        _storepictureArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _storepictureArray;
}
- (void) changeNameAction {
    NSUserDefaults *userDF = [NSUserDefaults standardUserDefaults];
//        nameLabel.text = [NSString stringWithFormat:@"%@", [userDF objectForKey:@"nickname"]];
}
- (void) setTopView {
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 200)];
    topView.backgroundColor = [UIColor colorWithHexString:@"ff8042"];
    [self.view addSubview:topView];
    _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(KscreeWidth / 2 - 30, 45, 60, 60)];
    NSUserDefaults *userDF = [NSUserDefaults standardUserDefaults];
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[userDF objectForKey:@"headimage"]] placeholderImage:[UIImage imageNamed:@""]];
//    iconImage.image = [UIImage imageNamed:@"删除"];
    _iconImage.layer.masksToBounds = YES;
    _iconImage.layer.cornerRadius = 30;
    _iconImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPickIconAction)];
    [_iconImage addGestureRecognizer:tap];
    [topView addSubview:_iconImage];
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, KscreeWidth, 30)];
    if ([NSString stringWithFormat:@"%@", [userDF objectForKey:@"nickname"]].length != 0) {
//        nameLabel.text = [NSString stringWithFormat:@"%@", [userDF objectForKey:@"nickname"]];
    }else {
//        nameLabel.text = @"";
    }
    nameLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    [topView addSubview:nameLabel];
    timeLable = [[UILabel alloc] initWithFrame:CGRectMake(KscreeWidth / 2 - 100, 155, 100, 30)];
    timeLable.text = @"营业时间：";
    timeLable.textColor = [UIColor colorWithHexString:@"ffffff"];
    timeLable.textAlignment = NSTextAlignmentRight;
    timeLable.font = [UIFont systemFontOfSize:12];
    [topView addSubview:timeLable];
    timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    timeButton.frame = CGRectMake(KscreeWidth / 2, 155, KscreeWidth / 2, 30);
    timeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [timeButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [timeButton setTitle:@"09:00-24:00" forState:UIControlStateNormal];
    [timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [timeButton addTarget:self action:@selector(pickTimeAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:timeButton];
}
- (void) pickTimeAction {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowHourMinute CompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"HH:mm"];
        NSLog(@"时间： %@",date);
        _postStartTime = [startDate stringWithFormat:@"HHmm"];
        NSString *string = [NSString stringWithFormat:@"%@-24:00", date];
        _startTime = date;
        [timeButton setTitle:string forState:UIControlStateNormal];
        
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowHourMinute CompleteBlock:^(NSDate *startDate) {
            NSString *date = [startDate stringWithFormat:@"HH:mm"];
            _postEndTime = [startDate stringWithFormat:@"HHmm"];
            NSLog(@"时间： %@",date);
            _endTime = date;
            NSString *string = [NSString stringWithFormat:@"%@-%@",_startTime, _endTime];
            [timeButton setTitle:string forState:UIControlStateNormal];
            
            NSDate *datett =[NSDate date];
            //获取年月日
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy"];
            NSInteger currentYear=[[formatter stringFromDate:datett] integerValue];
            NSString *wtyear = [formatter stringFromDate:datett];
            [formatter setDateFormat:@"MM"];
            NSInteger currentMonth=[[formatter stringFromDate:datett]integerValue];
            NSString *wtmonth = [formatter stringFromDate:datett];
            [formatter setDateFormat:@"dd"];
            NSInteger currentDay=[[formatter stringFromDate:datett] integerValue];
            NSString *wtday = [formatter stringFromDate:datett];
            NSLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",date,currentYear,currentMonth,currentDay);
            NSMutableDictionary *outDict = [self makeDict];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
            [dict setObject:[NSString stringWithFormat:@"%@%@%@ %@", wtyear,wtmonth, wtday, _postStartTime] forKey:@"operatingStart"];
            [dict setObject:[NSString stringWithFormat:@"%@%@%@ %@", wtyear, wtmonth,wtday,_postEndTime] forKey:@"operatingEnd"];
            [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
            NSLog(@"%@", dict);
            NSLog(@"%@", outDict);
            [outDict setObject:@"store_index" forKey:@"logView"];
            [WTNewRequest postWithURLString:[self createRequestUrl:Alterbusinesstime] parameters:outDict success:^(NSDictionary *data) {
                if ([[data objectForKey:@"resCode"] integerValue] == 100) {
                    [CMMUtility showSucessWith:@"修改成功"];
                }else {
                    [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
                }
            } failure:^(NSError *error) {
                [CMMUtility showFailureWith:@"服务器故障"];
            }];
        }];
        datepicker.doneButtonColor = [UIColor colorWithHexString:@"ff8042"];//确定按钮的颜色
        [datepicker show];
        
    }];
    datepicker.doneButtonColor = [UIColor colorWithHexString:@"ff8042"];//确定按钮的颜色
    [datepicker show];
}
- (void)setlayout {
    //(KscreeWidth - 30)
    downView = [[UIView alloc] initWithFrame:CGRectMake(15, 215, KscreeWidth - 30, 230)];
    downView.layer.masksToBounds = YES;
    downView.layer.cornerRadius = 5;
    downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:downView];
    
    henView = [[UIView alloc] initWithFrame:CGRectMake(10, 230 / 2, downView.frame.size.width - 20, 1)];
    henView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    [downView addSubview:henView];
    shuoneView = [[UIView alloc] initWithFrame:CGRectMake((downView.frame.size.width / 3), 10, 1, 210)];
    shuoneView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    [downView addSubview:shuoneView];
    shutwoView = [[UIView alloc] initWithFrame:CGRectMake((downView.frame.size.width / 3) * 2, 10, 1, 210)];
    shutwoView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    [downView addSubview:shutwoView];
    //NSArray *upArray = @[@"店铺",@"技师",@"商品"];
    NSArray *upArray = @[@"门店管理",@"技师管理",@"商品管理"];
    NSArray *upimagearr = @[@"店铺",@"技师",@"商品"];
    NSArray *downAray = @[@"评价管理",@"增值服务",@"访问记录"];
    NSArray *dowmimagearr = @[@"评价",@"增值服务",@"访问记录"];
    
    for (int i = 0; i < 3; i++) {
        switch (i) {
            case 0:
            {//(KscreeWidth - 30) - ((KscreeWidth - 30) / 3) / 2 - ButtonSizeWH / 2
                //(KscreeWidth - 30) - ((KscreeWidth - 30) / 3 / 2 - ButtonSizeWH / 2)
                UIButton *upbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                upbutton.tag = UpButtonTag + i;
                upbutton.frame = CGRectMake((KscreeWidth - 30) - ((KscreeWidth - 30) - ((KscreeWidth - 30) / 3 / 2 - ButtonSizeWH / 2)), 10, ButtonSizeWH, ButtonSizeWH);
                [upbutton setImage:[UIImage imageNamed:[upimagearr objectAtIndex:i]] forState:UIControlStateNormal];
                [upbutton addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
                upbutton.layer.masksToBounds = YES;
                upbutton.layer.cornerRadius = ButtonSizeWH / 2;
                [downView addSubview:upbutton];
            }
                break;
            case 1:
            {
                UIButton *upbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                upbutton.tag = UpButtonTag + i;
                upbutton.frame = CGRectMake((((KscreeWidth - 30) - (ButtonSizeWH * 3 )) / 4) + (((KscreeWidth - 30) - (ButtonSizeWH * 3 )) / 4) * i + ButtonSizeWH * i, 10, ButtonSizeWH, ButtonSizeWH);
                [upbutton setImage:[UIImage imageNamed:[upimagearr objectAtIndex:i]] forState:UIControlStateNormal];
                [upbutton addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
                upbutton.layer.masksToBounds = YES;
                upbutton.layer.cornerRadius = ButtonSizeWH / 2;
                [downView addSubview:upbutton];
            }
                break;
            case 2:
            {
                UIButton *upbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                upbutton.tag = UpButtonTag + i;
                upbutton.frame = CGRectMake((KscreeWidth - 30) - ((KscreeWidth - 30) / 3) / 2 - ButtonSizeWH / 2 , 10, ButtonSizeWH, ButtonSizeWH);
                [upbutton setImage:[UIImage imageNamed:[upimagearr objectAtIndex:i]] forState:UIControlStateNormal];
                [upbutton addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
                upbutton.layer.masksToBounds = YES;
                upbutton.layer.cornerRadius = ButtonSizeWH / 2;
                [downView addSubview:upbutton];
            }
                break;
            default:
                break;
        }
    }
    for (int k = 0; k < 3; k++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((downView.frame.size.width / 3) * k, 70, (downView.frame.size.width / 3), 21)];
        label.text = [NSString stringWithFormat:@"%@", [upArray objectAtIndex:k]];
        label.textColor = [UIColor colorWithHexString:@"666666"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:13];
        [downView addSubview:label];
    }
    for (int p = 0; p < 3; p++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((downView.frame.size.width / 3) * p, 70 + 115, (downView.frame.size.width / 3), 21)];
        label.text = [NSString stringWithFormat:@"%@", [downAray objectAtIndex:p]];
        label.textColor = [UIColor colorWithHexString:@"666666"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:13];
        [downView addSubview:label];
    }
    for (int j = 0; j < 3; j++) {
        switch (j) {
            case 0:
            {//(KscreeWidth - 30) - ((KscreeWidth - 30) / 3) / 2 - ButtonSizeWH / 2
                //(KscreeWidth - 30) - ((KscreeWidth - 30) / 3 / 2 - ButtonSizeWH / 2)
                UIButton *upbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                upbutton.tag = DownButtonTag + j;
                upbutton.frame = CGRectMake((KscreeWidth - 30) - ((KscreeWidth - 30) - ((KscreeWidth - 30) / 3 / 2 - ButtonSizeWH / 2)), 140 - 15, ButtonSizeWH, ButtonSizeWH);
                [upbutton setImage:[UIImage imageNamed:[dowmimagearr objectAtIndex:j]] forState:UIControlStateNormal];
                [upbutton addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
//                upbutton.layer.masksToBounds = YES;
//                upbutton.layer.cornerRadius = ButtonSizeWH / 2;
                [downView addSubview:upbutton];
            }
                break;
            case 1:
            {
                UIButton *upbutton = [UIButton buttonWithType:UIButtonTypeSystem];
                upbutton.tag = DownButtonTag + j;
                upbutton.frame = CGRectMake((((KscreeWidth - 30) - (ButtonSizeWH * 3 )) / 4) + (((KscreeWidth - 30) - (ButtonSizeWH * 3 )) / 4) * j + ButtonSizeWH * j, 140 - 15, ButtonSizeWH, ButtonSizeWH);
                [upbutton setImage:[UIImage imageNamed:[dowmimagearr objectAtIndex:j]] forState:UIControlStateNormal];
                [upbutton addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
//                upbutton.layer.masksToBounds = YES;
//                upbutton.layer.cornerRadius = ButtonSizeWH / 2;
                [downView addSubview:upbutton];
            }
                break;
            case 2:
            {
                UIButton *upbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                upbutton.tag = DownButtonTag + j;
                upbutton.frame = CGRectMake((KscreeWidth - 30) - ((KscreeWidth - 30) / 3) / 2 - ButtonSizeWH / 2 , 140 - 15, ButtonSizeWH, ButtonSizeWH);
                [upbutton setImage:[UIImage imageNamed:[dowmimagearr objectAtIndex:j]] forState:UIControlStateNormal];
                [upbutton addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
//                upbutton.layer.masksToBounds = YES;
//                upbutton.layer.cornerRadius = ButtonSizeWH / 2;
                [downView addSubview:upbutton];
            }
                break;
            default:
                break;
        }

        
    }
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
    self.iconImage.image = editedImage;
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
    [dict setObject:@"2" forKey:@"roleId"];
    [dict setObject:imageaddress forKey:@"headPortrait"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [outDict setObject:@"server_index" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Changeheadportrait] parameters:outDict success:^(NSDictionary *data) {
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            [CMMUtility showSucessWith:@"修改成功"];
            [self requestPersonMessageData];
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

#pragma mark - 主页入口
- (void)upAction:(UIButton *)sender {
    switch (sender.tag) {
        case 10000:
        {
        NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
        if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 1) {
            StoreManageViewController *vc = [[StoreManageViewController alloc] init];
            __weak HomeViewController *weakself = self;
            vc.pullIconImage = ^(UIImage *image) {
                weakself.iconImage.image = image;
            };
            //            StoreManagementViewController *vc = [[StoreManagementViewController alloc] initWithNibName:@"StoreManagementViewController" bundle:nil];
            vc.storenotes = self.storenotes;
            vc.storenamels =self.storenamels;
            vc.storephones = self.storephones;
            vc.storeadress = self.storeadress;
            vc.storepictureArray = [self.storepictureArray mutableCopy];
            [self.storepictureArray removeAllObjects];
            vc.lats = self.lat;
            vc.lngs = self.lng;
            vc.adcodes = self.adcode;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 2) {
                
                CaoCertificationingViewController *vc =[[CaoCertificationingViewController  alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
            }else {
                NowCertificationViewController *vc = [[NowCertificationViewController alloc] initWithNibName:@"NowCertificationViewController" bundle:nil];
                vc.clanceID = @"0";
                [self presentViewController:vc animated:YES completion:nil];
                return;
            }

        }

        }
            break;
        case 10001:
        {
            NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
            if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 1) {
                JishiViewController *vc = [[JishiViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 2) {
                    
                    CaoCertificationingViewController *vc =[[CaoCertificationingViewController  alloc] init];
                    [self presentViewController:vc animated:YES completion:nil];
                }else {
                    NowCertificationViewController *vc = [[NowCertificationViewController alloc] initWithNibName:@"NowCertificationViewController" bundle:nil];
                    vc.clanceID = @"0";
                    [self presentViewController:vc animated:YES completion:nil];
                    return;
                }

            }
        }
            break;
        case 10002:
        {
            NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
            if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 1) {
                ManagemetViewController *vc = [[ManagemetViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 2) {
                    
                    CaoCertificationingViewController *vc =[[CaoCertificationingViewController  alloc] init];
                    [self presentViewController:vc animated:YES completion:nil];
                }else {
                    NowCertificationViewController *vc = [[NowCertificationViewController alloc] initWithNibName:@"NowCertificationViewController" bundle:nil];
                    vc.clanceID = @"0";
                    [self presentViewController:vc animated:YES completion:nil];
                    return;
                }

            }
        }
            break;
        case 20000:
        {
            NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
            if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 1) {
//                            CommentViewController *vc = [[CommentViewController alloc] init];
                UserCommentViewController *vc = [[UserCommentViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 2) {
                    
                    CaoCertificationingViewController *vc =[[CaoCertificationingViewController  alloc] init];
                    [self presentViewController:vc animated:YES completion:nil];
                }else {
                    NowCertificationViewController *vc = [[NowCertificationViewController alloc] initWithNibName:@"NowCertificationViewController" bundle:nil];
                    vc.clanceID = @"0";
                    [self presentViewController:vc animated:YES completion:nil];
                    return;
                }

            }
        }
            break;
        case 20001:
        {
            NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
            NSLog(@"%@", [NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]]);
            if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 1) {
                AddServicesViewController *vc = [[AddServicesViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 2) {
                    
                    CaoCertificationingViewController *vc =[[CaoCertificationingViewController  alloc] init];
                    [self presentViewController:vc animated:YES completion:nil];
                }else {
                    NowCertificationViewController *vc = [[NowCertificationViewController alloc] initWithNibName:@"NowCertificationViewController" bundle:nil];
                    vc.clanceID = @"0";
                    [self presentViewController:vc animated:YES completion:nil];
                    return;
                }

            }
        }
            break;
        case 20002:
        {
//            NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
//            if ([[NSString stringWithFormat:@"%@", [userdef objectForKey:CredentialsidentifyStatus]] integerValue] == 0) {
//                NowCertificationViewController *vc = [[NowCertificationViewController alloc] initWithNibName:@"NowCertificationViewController" bundle:nil];
//                vc.clanceID = @"0";
//                [self presentViewController:vc animated:YES completion:nil];
//                return;
//            }
            [CMMUtility showSucessWith:@"敬请期待!"];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 个人信息
- (void)requestPersonMessageData {
    [self.storepictureArray removeAllObjects];
    NSMutableDictionary *dict = [self makeDict];
    [dict setObject:@"store_index" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Userdetail] parameters:dict success:^(NSDictionary *data) {
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
        
            }else {
                if ([[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"address"] == nil) {
                    self.storeadress = @"";

                }else {
                    self.storeadress = [NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"address"]];

                }
                if ([[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"telephone"] == nil) {
                    self.storephones = @"";

                }else {
                    self.storephones = [NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"telephone"]];

                }
                if ([[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"storeName"] == nil) {
                    self.storenamels = @"";
                }else {
                    self.storenamels = [NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"storeName"]];
                }
                if ([[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"storeNotice"] == nil) {
                    self.storenotes = @"";
                }else {
                    self.storenotes = [NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"storeNotice"]];

                }
                if ([[NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"pictureUrl"]] rangeOfString:@","].location != NSNotFound) {
                     NSArray* array = [[NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"pictureUrl"]] componentsSeparatedByString:@","];
                    [self.storepictureArray addObjectsFromArray:array];
                }else {
                    if ([[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"pictureUrl"] == nil) {
//                        [self.storepictureArray addObject:[NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"headPortrait"]]];
                    }else {
                        [self.storepictureArray addObject:[NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"pictureUrl"]]];
                        NSLog(@"%@",[NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"pictureUrl"]] );
                    }
                }
                self.adcode = [NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"areaId"]];
                self.lng = [NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"longitude"]];
                self.lat = [NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"latitude"]];
                [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"headPortrait"]]] placeholderImage:[UIImage imageNamed:@""]];
                if ([[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"nickName"] == nil) {
                    nameLabel.text = @"";
                }else {
                    nameLabel.text = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"nickName"]];
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    [user setObject:[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"nickName"]] forKey:@"nickName"];
                    [user synchronize];
                }
                NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
                [userd setObject:[NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"storeId"]] forKey:@"storeId"];
                [userd synchronize];
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
#pragma mark - 个人认证信息
- (void)ccrequestPersonMessageData {
    NSMutableDictionary *dict = [self makeDict];
    [dict setObject:@"store_index" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Credentials] parameters:dict success:^(NSDictionary *data) {
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
                
            }else {
                NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
                NSUserDefaults *renzheng = [NSUserDefaults standardUserDefaults];
                [renzheng setObject:[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"identifyStatus"]] forKey:@"identifyStatus"];
                [renzheng synchronize];
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
        
        
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}

/*
 布局
 */
- (CGFloat)wLocation:(CGFloat)data {
    return (data * 1000 / 375) * KscreeWidth / 1000;
}
- (CGFloat)hLocation:(CGFloat)data {
    return (data * 1000 / 667) * KscreeHeight / 1000;
}

- (void)viewWillAppear:(BOOL)animated {
    [self requestPersonMessageData];
    [self ccrequestPersonMessageData];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [self showTabBar];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self hideTabBar];
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
