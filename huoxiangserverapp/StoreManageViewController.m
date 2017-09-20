//
//  StoreManageViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/2.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "StoreManageViewController.h"
#import "PostStoreManageViewController.h"

//相册
#import "LLImageCollectionCell.h"
#import "Config.h"
#import "LLImagePickerController.h"
#import "UIImage+LLAdd.h"
#import "LLCameraViewController.h"

#import "ImagePickTableViewCell.h"
static NSString *cellid = @"pickcell";
@interface StoreManageViewController ()<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    UIView *downView;
    
    UILabel *nameLabel;
    UITextField *nameTF;
    UIView *oneview;
    
    UILabel *phoneLable;
    UITextField *phoneTF;
    UIView *twoView;
    
    UILabel *locationLable;
    UITextField *locationTF;
    
    UIView *threeView;
    
    UILabel *imageLable;
    UIView * fourView;
    
    UILabel *noteLable;
    UITextField *noteTF;
    
    UITableView *imageTV;
    UIImage *image;
    
    UIButton *sendbutton;
    
    UIAlertController *alert;
}
@property (nonatomic, strong) UILabel *tapMapLabel;
@property (nonatomic, copy) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *imageAdress;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *longlat;
@property (nonatomic, strong) NSString *qubianma;

@property (nonatomic, assign) NSInteger index;
@end

@implementation StoreManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%ld", self.storepictureArray.count);
//    if (self.storepictureArray.count != 0) {
//        [self.dataArray removeAllObjects];
//    }else {
        //没图
//    }
    if (self.lats.length != 0) {
        self.lat = self.lats;
    }
    if (self.lngs.length != 0) {
        self.longlat = self.lngs;
    }
    if (self.adcodes.length != 0) {
        self.qubianma = self.adcodes;
    }
    _index = 0;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self wtTopViewWithBackString:@"返回-" andTitlestring:@"门店信息"];
    [self setlayOut];
    [self tapTF];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteimage:) name:NsNotficationDeleteImage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detailAction:) name:NsnotificationDetailAddress object:nil];
}
- (void) deleteimage:(NSNotification *)notification {
    UIImageView *imageV = [notification.userInfo objectForKey:@"delete"];
    [_dataArray removeObject:imageV.image];
    dispatch_async(dispatch_get_main_queue(), ^{
        [imageTV reloadData];
    });
}
- (NSMutableArray *)storepictureArray {
    if (!_storepictureArray) {
        _storepictureArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _storepictureArray;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        image = [UIImage imageNamed:@"添加"];
        _dataArray = [NSMutableArray arrayWithObjects:image, nil];
    }
    return _dataArray;
}
- (void)setlayOut {
    downView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, KscreeWidth, 250)];
    downView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.view addSubview:downView];
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 30)];
    nameLabel.text = @"店铺名称";
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    nameLabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    [downView addSubview:nameLabel];
    nameTF = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, KscreeWidth - 140, 30)];
    if (self.storenamels.length != 0) {
        nameTF.text = self.storenamels;
    }else {
        nameTF.placeholder = @"天天足浴";
    }
    nameTF.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:14];
    [downView addSubview:nameTF];
    oneview = [[UIView alloc] initWithFrame:CGRectMake(0, 50, KscreeWidth, 1)];
    oneview.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    [downView addSubview:oneview];
    
    phoneLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 100, 30)];
    phoneLable.text = @"联系电话";
    [downView addSubview:phoneLable];
    phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(120, 60, KscreeWidth - 140, 30)];
    if (self.storephones.length != 0) {
        phoneTF.text = self.storephones;
    }else {
        phoneTF.placeholder = @"请输入电话号码";
    }
    phoneTF.keyboardType =  UIKeyboardTypePhonePad;
    phoneTF.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:14];
    [downView addSubview:phoneTF];
    twoView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, KscreeWidth, 1)];
    twoView.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    [downView addSubview:twoView];
    
    locationLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 100, 30)];
    locationLable.text = @"详细地址";
    locationLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapMapAction)];
//    [locationLable addGestureRecognizer:tap];
    [downView addSubview:locationLable];
    _tapMapLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 110, KscreeWidth - 140, 30)];
    if (self.storeadress.length != 0) {
        _tapMapLabel.text = self.storeadress;
        self.address =  _tapMapLabel.text;
    }else {
        _tapMapLabel.text = @"点我选择地址";

    }
    _tapMapLabel.font = [UIFont systemFontOfSize:14];
    _tapMapLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _tapMapLabel.userInteractionEnabled = YES;
    _tapMapLabel.adjustsFontSizeToFitWidth = YES;
    [_tapMapLabel addGestureRecognizer:tap];
    [downView addSubview:_tapMapLabel];
    threeView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, KscreeWidth, 1)];
    threeView.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    [downView addSubview:threeView];
    
    imageLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 100, 30)];
    imageLable.text = @"门店图";
    [downView addSubview:imageLable];
    fourView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, KscreeWidth, 1)];
    fourView.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    [downView addSubview:fourView];
    
    noteLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, 100, 30)];
    noteLable.text =@"店铺公告";
    [downView addSubview:noteLable];
    noteTF = [[UITextField alloc] initWithFrame:CGRectMake(120, 210, KscreeWidth - 140, 30)];
    if (self.storenotes.length != 0) {
        noteTF.text = self.storenotes;
    }else {
        noteTF.placeholder = @"全场半价";
    }
    noteTF.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:14];
    [downView addSubview:noteTF];
    
//    _dataArray = [NSMutableArray arrayWithCapacity:0];
//    image = [UIImage imageNamed:@"删除"];
//    [_dataArray arrayByAddingObject:image];
    imageTV = [[UITableView alloc] init];
    imageTV.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    imageTV.frame = CGRectMake(120, 155, kScreenWidth - 120 - 20, 40);
    [imageTV registerNib:[UINib nibWithNibName:@"ImagePickTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    imageTV.delegate = self;
    imageTV.dataSource = self;
    imageTV.scrollEnabled = NO;
    imageTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    imageTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [downView addSubview:imageTV];
    
    sendbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    sendbutton.frame = CGRectMake((KscreeWidth - 260) / 2, 300 + 84, 260, 45);
    [sendbutton setBackgroundColor:[UIColor colorWithHexString:@"ff8042"]];
    sendbutton.layer.masksToBounds = YES;
    sendbutton.layer.cornerRadius = 45 / 2;
    [sendbutton setTitle:@"保存" forState:UIControlStateNormal];
    [sendbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendbutton.titleLabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:17];
    [sendbutton addTarget:self action:@selector(postStoreMessagehahha) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendbutton];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [nameTF resignFirstResponder];
    [phoneTF resignFirstResponder];
    [noteTF resignFirstResponder];
}
#pragma mark - 循环发送图片
- (void)postStoreMessagehahha {
    if (nameTF.text.length == 0) {
        [CMMUtility showFailureWith:@"请输入店铺名称"];
        return;
    }
    if (phoneTF.text.length == 0) {
        [CMMUtility showFailureWith:@"请输入手机号码"];
        return;
    }
    if (noteTF.text.length == 0) {
        [CMMUtility showFailureWith:@"请输入店铺公告"];
        return;
    }
    if ([self.tapMapLabel.text isEqualToString:@"点我选择地址"]) {
        [CMMUtility showFailureWith:@"请选择地址"];
        return;
    }
    if (self.dataArray.count < 2) {
        [CMMUtility showFailureWith:@"请上传至少一张商品展示图"];
        return;
    }
    sendbutton.userInteractionEnabled = NO;
    for (int i = 0; i < self.dataArray.count - 1; i++) {
//        UIImage *image = [UIImage imageNamed:@"one.png"];
//        NSData *data = UIImagePNGRepresentation([_dataArray objectAtIndex:i + 1]);
//        UIImageView *sdsdsd = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, KscreeWidth, 100)];
//        sdsdsd.image = self.dataArray[0];
//        [self.view addSubview:sdsdsd];
//        return;
        NSData *data = UIImageJPEGRepresentation([self.dataArray objectAtIndex:i], 0.5);
        AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
            manage.responseSerializer = [AFHTTPResponseSerializer serializer];
            manage.requestSerializer = [AFHTTPRequestSerializer serializer];
//        NSString *url = @"http://192.168.0.100:8080/statics/uploadresource";
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
                    [CMMUtility showFailureWith:@"请添加图片"];
                }
                    break;
                case 2:
                {
                    _imageAdress = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:body] objectForKey:@"url"]];
                    [self totleMessage];
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
                            [self totleMessage];
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
                        [self totleMessage];
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
                        [self totleMessage];
                    }
                    }
                }
                    break;
                    
                default:
                    break;
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [CMMUtility showFailureWith:@"上传失败服务器故障"];
        }];
    }
}
- (void)totleMessage {
    NSLog(@"%@", _imageAdress);
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        NSMutableDictionary *outDict = [self makeDict];
        [dict setObject:[NSString stringWithFormat:@"%@", nameTF.text] forKey:@"storeName"];
        [dict setObject:[NSString stringWithFormat:@"%@", phoneTF.text] forKey:@"phone"];
        [dict setObject:[NSString stringWithFormat:@"%@", _address] forKey:@"address"];
        [dict setObject:[NSString stringWithFormat:@"%@", _imageAdress] forKey:@"pictureUrl"];
        [dict setObject:[NSString stringWithFormat:@"%@", _longlat] forKey:@"longitude"];
        [dict setObject:[NSString stringWithFormat:@"%@", _lat] forKey:@"latitude"];
        [dict setObject:[NSString stringWithFormat:@"%@", noteTF.text] forKey:@"storeNotice"];
        [dict setObject:[NSString stringWithFormat:@"%@", self.qubianma] forKey:@"areaId"];
        [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
        [outDict setObject:@"store_manage" forKey:@"logView"];
        [WTNewRequest postWithURLString:[self createRequestUrl:Alterstore] parameters:outDict success:^(NSDictionary *data) {
            sendbutton.userInteractionEnabled = YES;
            if ([[data objectForKey:@"resCode"] integerValue] == 100) {
                _imageAdress = nil;
                _index = 0;
                [CMMUtility showSucessWith:@"上传成功"];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:[NSString stringWithFormat:@"%@", nameTF.text] forKey:@"nickname"];
                [user synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:NsNotficationRefreshName object:nil];
                self.pullIconImage([self.dataArray firstObject]);
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                _imageAdress = nil;
                _index = 0;
                [CMMUtility showFailureWith:[data objectForKey:@"resMsg"]];
            }

        } failure:^(NSError *error) {
            sendbutton.userInteractionEnabled = YES;
            [CMMUtility showFailureWith:@"服务器故障"];
        }];
}
#pragma mark - 赋值location
- (void) detailAction:(NSNotification *)notification {
    NSDictionary *dict = notification.userInfo;
    self.lat = [NSString stringWithFormat:@"%@", [dict objectForKey:@"lat"]];
    self.longlat = [NSString stringWithFormat:@"%@", [dict objectForKey:@"long"]];
    self.address = [NSString stringWithFormat:@"%@", [dict objectForKey:@"address"]];
    self.tapMapLabel.text = [NSString stringWithFormat:@"%@", [dict objectForKey:@"addressLablel"]];
}
- (void) TapMapAction {
    PostStoreManageViewController *vc = [[PostStoreManageViewController alloc] init];
    StoreManageViewController *weakSelf = self;
    vc.location = ^(NSDictionary *dict) {
        NSLog(@"%@", dict);
        weakSelf.lat = [NSString stringWithFormat:@"%@", [dict objectForKey:@"lat"]];
        weakSelf.longlat = [NSString stringWithFormat:@"%@", [dict objectForKey:@"long"]];
        weakSelf.address = [NSString stringWithFormat:@"%@", [dict objectForKey:@"address"]];
        weakSelf.tapMapLabel.text = [NSString stringWithFormat:@"%@", [dict objectForKey:@"addressLablel"]];
        weakSelf.qubianma = [NSString stringWithFormat:@"%@", [dict objectForKey:@"adcode"]];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (self.storepictureArray.count != 0) {
//        return self.storepictureArray.count;
//    }else {
        return self.dataArray.count;
//    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImagePickTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ImagePickTableViewCell" owner:nil options:nil] lastObject];
    }
//    if (self.storepictureArray.count != 0) {
//            [cell.pickImage sd_setImageWithURL:[NSURL URLWithString:[self.storepictureArray objectAtIndex:indexPath.row]]];
//    }else {
        cell.pickImage.image = self.dataArray[indexPath.row];
//    }
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    if (indexPath.row == _dataArray.count - 1) {
        cell.deletButton.hidden = YES;
        return cell;
    }
    cell.deletButton.hidden = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_dataArray.count >5) {
        [CMMUtility showFailureWith:@"最多上传四张"];
        return;
    }
//    if (self.storepictureArray.count != 0) {
//        [self presentViewController:alert animated:YES completion:nil];
//    }else {
        if ((indexPath.row + 1) == _dataArray.count) {
            [self presentViewController:alert animated:YES completion:nil];
//        }
    }
}
#pragma mark - 获取相册
- (void) tapTF {
    alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imagePickAction];
//        //初始化UIImagePickerController
//        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
//        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
//        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
//        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
//        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        //允许编辑，即放大裁剪
//        PickerImage.allowsEditing = YES;
//        //自代理
//        PickerImage.delegate = self;
//        //页面跳转
//        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
//        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
//        //获取方式:通过相机
//        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
//        PickerImage.allowsEditing = YES;
//        PickerImage.delegate = self;
//        [self presentViewController:PickerImage animated:YES completion:nil];
        LLCameraViewController *cameraVC = [[LLCameraViewController alloc] init];
        // 拍照获取相片回调
        [cameraVC getResultFromCameraWithBlock:^(UIImage *image, NSDictionary *info) {
            if (_dataArray.count <= 0) {
                [_dataArray removeAllObjects];
                [_dataArray addObject:image];
                UIImage * addimage = [UIImage imageNamed:@"添加"];
                [_dataArray addObject:addimage];
                [imageTV reloadData];
            }else {
                [_dataArray removeLastObject];
                [_dataArray addObject:image];
                UIImage * addimage = [UIImage imageNamed:@"添加"];
                [_dataArray addObject:addimage];
                [imageTV reloadData];
            }

        }];
        [self presentViewController:cameraVC animated:YES completion:nil];
    }]];
    /*
    添加录制视频按钮
     */
//    [alert addAction:[UIAlertAction actionWithTitle:@"录制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////        [self startvideo];
//        [self choosevideo];
//    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
}
//- (void) imagePiCK {
//    for (int i = 0; i < _dataArray.count + 1; i++) {
//        UIButton *imagePick = [UIButton buttonWithType:UIButtonTypeCustom];
//        imagePick.frame = CGRectMake(120 + 40 * i + i * 10 , 155, 40, 40);
//        [imagePick setBackgroundImage:[UIImage imageNamed:[_dataArray objectAtIndex:i]] forState:UIControlStateNormal];
//        if (i == _dataArray.count) {
//            [imagePick setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
//            [imagePick addTarget:self action:@selector(imagePickAction) forControlEvents:UIControlEventTouchUpInside];
//        }
//        [downView addSubview:imagePick];
//    }
//}
#pragma pickimageDelegate
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    /*
     视频上传
     */
    /*
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
    */
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSLog(@"%@",info);
    [_dataArray addObject:newPhoto];
//    [imageTV reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 获取图片回调
- (void) imagePickAction {
    LLImagePickerController *navigationController = [[LLImagePickerController alloc] init];
    navigationController.autoJumpToPhotoSelectPage = YES;
    navigationController.allowSelectReturnType = NO;
    navigationController.maxSelectedCount = 4;
    if (iOS8Upwards) {
        [navigationController getSelectedPHAssetsWithBlock:^(NSArray<UIImage *> *imageArray, NSArray<PHAsset *> *assetsArray) {
//            [self.storepictureArray removeAllObjects];
            if (_dataArray.count <= 0) {
                [_dataArray removeAllObjects];
                [_dataArray addObjectsFromArray:[NSArray arrayWithArray:imageArray]];
                //            self.dataArray = [NSArray arrayWithArray:imageArray].mutableCopy;
                //            self.dataArray = [NSMutableArray arrayWithArray:[NSArray arrayWithArray:imageArray]];
                UIImage * addimage = [UIImage imageNamed:@"添加"];
                [_dataArray addObject:addimage];
                [imageTV reloadData];
            }else {
                [_dataArray removeLastObject];
                [_dataArray addObjectsFromArray:[NSArray arrayWithArray:imageArray]];
                //            self.dataArray = [NSArray arrayWithArray:imageArray].mutableCopy;
                //            self.dataArray = [NSMutableArray arrayWithArray:[NSArray arrayWithArray:imageArray]];
                UIImage * addimage = [UIImage imageNamed:@"添加"];
                [_dataArray addObject:addimage];
                [imageTV reloadData];
                //            [self imagePiCK];
            }
 
        }];
    } else {
        [navigationController getSelectedALAssetsWithBlock:^(NSArray<UIImage *> *imageArray, NSArray<ALAsset *> *assetsArray) {
//            [self.storepictureArray removeAllObjects];
            self.dataArray = (NSMutableArray *)[NSArray arrayWithArray:imageArray];
            [imageTV reloadData];
//            [self imagePiCK];
        }];
    }
    [self presentViewController:navigationController animated:YES completion:nil];
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

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self hideTabBar];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
