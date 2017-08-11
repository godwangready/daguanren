//
//  AddCommityViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/26.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "AddCommityViewController.h"
#import "DetailCommityViewController.h"
#import "ImagePickTableViewCell.h"

//相册
#import "LLImageCollectionCell.h"
#import "Config.h"
#import "LLImagePickerController.h"
#import "UIImage+LLAdd.h"
#import "LLCameraViewController.h"
static NSString *cellid = @"pickcell";
@interface AddCommityViewController ()<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    UIButton *postButton;
    
    UIView *downView;
    
    UILabel *nameLabel;
    UITextField *nameTF;
    UIView *oneview;
    
    UILabel *phoneLable;
    UITextField *phoneTF;
    UIView *twoView;
    
    UILabel *locationLable;
    
    UIView *threeView;
    
    UILabel *imageLable;
    UITextField *imageTF;
    UIView * fourView;
    
    UILabel *noteLable;
    UITextField *noteTF;
    UIView *fiveView;
    
    UILabel *trueImageLable;
    UIView *sixView;
    
    UILabel *detailLale;
    UIButton *detail;
    UIButton *detailImageView;
    
    UITableView *imageTV;
    
    UIImage *image;
    UIAlertController *alert;
}
@property (nonatomic, copy) NSMutableArray *dataArray;
@property (nonatomic, strong) UITextField *locationTF;
@end

@implementation AddCommityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self wtTopViewWithBackString:@"返回-" andTitlestring:@"新增商品"];
    // Do any additional setup after loading the view.
    [self setLayOut];
    postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [postButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    postButton.frame = CGRectMake(KscreeWidth / 2 - 140, 484, 280, 45);//
    [postButton setBackgroundColor:[UIColor colorWithHexString:@"ff8042"]];
    [postButton setTitle:@"保存商品" forState:UIControlStateNormal];
    postButton.layer.masksToBounds = YES;
    postButton.layer.cornerRadius = 45 / 2;
    [self.view addSubview:postButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteimage:) name:NsNotficationDeleteImage object:nil];
    [self tapTF];
}
- (void) deleteimage:(NSNotification *)notification {
    UIImageView *imageV = [notification.userInfo objectForKey:@"delete"];
    [_dataArray removeObject:imageV.image];
    dispatch_async(dispatch_get_main_queue(), ^{
        [imageTV reloadData];
    });
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        image = [UIImage imageNamed:@"添加"];
        _dataArray = [NSMutableArray arrayWithObjects:image, nil];
    }
    return _dataArray;
}
- (void) setLayOut {

        downView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, KscreeWidth, 350)];
        downView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        [self.view addSubview:downView];
    
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 30)];
        nameLabel.text = @"商品名称";
        nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
        nameLabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
        [downView addSubview:nameLabel];
        nameTF = [[UITextField alloc] initWithFrame:CGRectMake(120, 12, KscreeWidth - 140, 30)];
        nameTF.placeholder = @"请输入商品名称";
        nameTF.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:14];
        [downView addSubview:nameTF];
        oneview = [[UIView alloc] initWithFrame:CGRectMake(0, 50, KscreeWidth, 1)];
        oneview.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
        [downView addSubview:oneview];
        
        phoneLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 100, 30)];
        phoneLable.text = @"商品类型";
    phoneLable.textColor = [UIColor colorWithHexString:@"333333"];
    phoneLable.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
        [downView addSubview:phoneLable];
    phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(120, 62, KscreeWidth - 140, 30)];
    phoneTF.placeholder = @"请输入商品类型";
    phoneTF.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:14];
    [downView addSubview:phoneTF];
        twoView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, KscreeWidth, 1)];
        twoView.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
        [downView addSubview:twoView];
        
        locationLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 100, 30)];
        locationLable.text = @"商品简介";
    locationLable.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    locationLable.textColor = [UIColor colorWithHexString:@"333333"];
        [downView addSubview:locationLable];
    _locationTF = [[UITextField alloc] initWithFrame:CGRectMake(120, 112, KscreeWidth - 140, 30)];
    _locationTF.placeholder = @"简介";
    _locationTF.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:14];
    [downView addSubview:_locationTF];
        threeView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, KscreeWidth, 1)];
        threeView.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
        [downView addSubview:threeView];
        
        imageLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 100, 30)];
        imageLable.text = @"门店价";
    imageLable.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    imageLable.textColor = [UIColor colorWithHexString:@"333333"];
        [downView addSubview:imageLable];
    imageTF = [[UITextField alloc] initWithFrame:CGRectMake(120, 162, KscreeWidth - 140, 30)];
    imageTF.placeholder = @"请输入门店价";
    imageTF.keyboardType = UIKeyboardTypeDecimalPad;
    imageTF.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:14];
    [downView addSubview:imageTF];
        fourView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, KscreeWidth, 1)];
        fourView.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
        [downView addSubview:fourView];
        
        noteLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, 100, 30)];
        noteLable.text =@"平台价";
    noteLable.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    noteLable.textColor = [UIColor colorWithHexString:@"333333"];
        [downView addSubview:noteLable];
    noteTF = [[UITextField alloc] initWithFrame:CGRectMake(120, 212, KscreeWidth - 140, 30)];
    noteTF.placeholder = @"请输入平台价";
    noteTF.keyboardType = UIKeyboardTypeDecimalPad;
    noteTF.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:14];
    [downView addSubview:noteTF];
    fiveView = [[UIView alloc] initWithFrame:CGRectMake(0, 250, KscreeWidth, 1)];
    fiveView.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    [downView addSubview:fiveView];
    
    trueImageLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, 100, 30)];
    trueImageLable.textColor = [UIColor colorWithHexString:@"333333"];
    trueImageLable.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    trueImageLable.text = @"商品图";
    [downView addSubview:trueImageLable];
    sixView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, KscreeWidth, 1)];
    sixView.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    [downView addSubview:sixView];
    
    detailLale = [[UILabel alloc] initWithFrame:CGRectMake(20, 310, 100, 30)];
    detailLale.text = @"商品详情";
    [downView addSubview:detailLale];
    detail = [UIButton buttonWithType:UIButtonTypeCustom];
    [detail setTitle:@"请填写商品信息" forState:UIControlStateNormal];
    detail.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    detail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    detail.contentEdgeInsets
    detail.frame = CGRectMake(120, 312, KscreeWidth - 180, 30);
//    detail.titleLabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:10];
    [detail.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [detail setTitleColor:[UIColor colorWithHexString:@"cccccc"] forState:UIControlStateNormal];
    [detail addTarget:self action:@selector(detailAction) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:detail];
    //width == 40
    detailImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    detailImageView.frame = CGRectMake(KscreeWidth - 60, 312, 40, 30);
    [detailImageView setImage:[UIImage imageNamed:@"进入"] forState:UIControlStateNormal];
    [detailImageView addTarget:self action:@selector(tapImageDetailAction) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:detailImageView];
    
    imageTV = [[UITableView alloc] init];
    imageTV.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    imageTV.frame = CGRectMake(120, 255, KscreeWidth - 120 - 20, 40);
    [imageTV registerNib:[UINib nibWithNibName:@"ImagePickTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    imageTV.delegate = self;
    imageTV.dataSource = self;
    imageTV.scrollEnabled = NO;
    imageTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    imageTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [downView addSubview:imageTV];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    if (self.dataArray.count == 1) {
    return self.dataArray.count;
    //    }else {
    //        return self.dataArray.count + 1;
    //    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImagePickTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ImagePickTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.pickImage.image = self.dataArray[indexPath.row];
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
    if (_dataArray.count >2) {
        [CMMUtility showFailureWith:@"最多上传四张"];
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ((indexPath.row + 1) == _dataArray.count) {
        [self presentViewController:alert animated:YES completion:nil];
    }
}
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
#warning mark -
- (void) imagePickAction {
    LLImagePickerController *navigationController = [[LLImagePickerController alloc] init];
    navigationController.autoJumpToPhotoSelectPage = YES;
    navigationController.allowSelectReturnType = YES;
    navigationController.maxSelectedCount = 1;
    if (iOS8Upwards) {
        [navigationController getSelectedPHAssetsWithBlock:^(NSArray<UIImage *> *imageArray, NSArray<PHAsset *> *assetsArray) {
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
            self.dataArray = (NSMutableArray *)[NSArray arrayWithArray:imageArray];
            [imageTV reloadData];
            //            [self imagePiCK];
        }];
    }
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)tapImageDetailAction {
    DetailCommityViewController *vc = [[DetailCommityViewController alloc] initWithNibName:@"DetailCommityViewController" bundle:nil];
    __weak AddCommityViewController *weakself = self;
    vc.passValue = ^(NSString *str) {
        weakself.locationTF.text = str;
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [nameTF resignFirstResponder];
    [phoneTF resignFirstResponder];
    [imageTF resignFirstResponder];
    [noteTF resignFirstResponder];
}
- (void) detailAction {
    DetailCommityViewController *vc = [[DetailCommityViewController alloc] initWithNibName:@"DetailCommityViewController" bundle:nil];
    __weak AddCommityViewController *weakself = self;
    vc.passValue = ^(NSString *str) {
        weakself.locationTF.text = str;
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void) saveAction {
    postButton.userInteractionEnabled = NO;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"" forKey:@"productId"];
    if (_productID) {
        [dict setObject:_productID forKey:@"productId"];
    }
    [dict setObject:[NSString stringWithFormat:@"%@", nameTF.text] forKey:@"productName"];
    [dict setObject:[NSString stringWithFormat:@"%@", imageTF.text] forKey:@"price"];
    [dict setObject:@"http:\\" forKey:@"productPicture"];
    [dict setObject:@"1" forKey:@"productDetails"];
    NSMutableDictionary *outDict = [self makeDict];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Redactproduct] parameters:outDict success:^(NSDictionary *data) {
        postButton.userInteractionEnabled = YES;
        NSLog(@"%@", data);
        if (([[data objectForKey:@"resCode"] integerValue] == 100)) {
            [CMMUtility showSucessWith:@"添加成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NsNotficationAddProduct object:nil];
        }else {
            [CMMUtility showFailureWith:@"添加失败"];
        }
//        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"添加失败"];
        postButton.userInteractionEnabled = YES;
    }];
    for (int i = 0; i < _dataArray.count; i++) {
//        UIImage *imagee = [UIImage imageNamed:@"one.png"];
//    UIImage *imageee = [UIImage imageNamed:@"two.png"];
        NSData *data = UIImagePNGRepresentation([_dataArray objectAtIndex:i]);
//        NSData *dataa = UIImageJPEGRepresentation([_dataArray objectAtIndex:i], .1);
//    NSData *data = UIImagePNGRepresentation(imagee);
//    NSData *dataa = UIImagePNGRepresentation(imageee);
        AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
//        NSString *url = @"http://192.168.0.100:8080/statics/uploadresource";
        [manage POST:ALIpullImageAndVideo parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:data name:@"file" fileName:@"one.png" mimeType:@"png"];
//            [formData appendPartWithFileData:dataa name:@"file" fileName:@"two.png" mimeType:@"png"];
            NSLog(@"%@", _dataArray);
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"%@", uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@", responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error.userInfo);
        }];
    }

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
