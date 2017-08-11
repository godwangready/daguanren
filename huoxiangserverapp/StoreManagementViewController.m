//
//  StoreManagementViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/1.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "StoreManagementViewController.h"
#import "PostStoreManageViewController.h"

@interface StoreManagementViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@end

@implementation StoreManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    self.nameTF.text = @"";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)postAction:(UIButton *)sender {
    NSMutableDictionary *dictt = [NSMutableDictionary dictionaryWithCapacity:0];
    [dictt setObject:@"" forKey:@"file"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    UIImage *image = [UIImage imageNamed:@"one.png"];
//    imageData2 = UIImagePNGRepresentation(image);
//    float length2 = [imageData2 length]/1024;
//    NSLog(@"image length===%f",length2);
    NSData *data = UIImagePNGRepresentation(image);
    
//    NSData *data1 = ;
//    NSData *data = UIImageJPEGRepresentation(image, 1);
    //[self encodeBase64Data:data]
    [dict setObject:[self encodeBase64Data:data] forKey:@"file"];
    NSString *str = @"sdsd";
    NSData *dddd = [str dataUsingEncoding:NSUTF8StringEncoding];
//    [dict setObject:[self encodeBase64Data:dddd] forKey:@"file"];
//    [WTNewRequest postWithURLString:[NSString stringWithFormat:@"http://192.168.0.100:8080/uploadresource"] parameters:dict success:^(NSDictionary *data) {
//    } failure:^(NSError *error) {
//       
//    }];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"two" ofType:@"png"];
    UIImage *appleImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
        NSString *url = @"http://192.168.0.100:8080/statics/uploadresource";
    //放上传图片的网址
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //初始化请求对象
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
//    NSString* url = @"https://upload.api.weibo.com/2/statuses/upload.json";
//    NSString* content = _textField.text;
//    
//    NSString* filepath = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"jpg"];
//    
//    NSDictionary* param = @{@"access_token":_access_token,@"status":content,@"source":@"2582981980"};
    NSLog(@"%@", imagePath);
    NSData *dataa = [NSData dataWithContentsOfFile:imagePath];

//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];//这一行一定不能少，因为后面是转换成JSON发送的
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setHTTPMethod:@"POST"];
//    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
//    [request setTimeoutInterval:20];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [manager uploadTaskWithRequest:request fromData:dataa progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"%@", uploadProgress);
//    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        NSLog(@"%@", error.userInfo);
//    }];
    
    [manager POST:url parameters:dictt constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFormData:data name:@""];
        [formData appendPartWithFileData:data name:@"file" fileName:@"wangtong" mimeType:@"png"];
//        [formData appendPartWithFileData:data1 name:@"file" fileName:@"tong" mimeType:@"mp4"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.userInfo);
    }];
    
//    [[TFFileUploadManager shareInstance] uploadFileWithURL:url params:param fileKey:@"pic" filePath:filepath completeHander:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        if (connectionError) {
//            NSLog(@"请求出错 %@",connectionError);
//        }else{
//            NSLog(@"请求返回：\n%@",response);
//        }
//    }];
        //上传图片/文字，只能同POST
//        [manager POST:url parameters:dictt constructingBodyWithBlock:^(id  _Nonnull formData) {
//            //对于图片进行压缩
//            //UIImage *image = [UIImage imageNamed:@"111"];
//            NSData *data = UIImageJPEGRepresentation(image, 0.1);
//            //NSData *data = UIImagePNGRepresentation(image);
//            //第一个代表文件转换后data数据，第二个代表图片的名字，第三个代表图片放入文件夹的名字，第四个代表文件的类型
//            
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            formatter.dateFormat = @"yyyyMMddHHmmss";
//            NSString *str = [formatter stringFromDate:[NSDate date]];
//            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
//            
//            NSData *dataa = [NSData dataWithContentsOfFile:imagePath];
////            [formData appendPartWithFileData:data name:@"1" fileName:@"image.jpg" mimeType:@"image/jpg"];
////            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpg"];
//            [formData appendPartWithFormData:dataa name:@"file"];
//            [formData appendPartWithFileData:dataa name:@"file" fileName:@"image" mimeType:@"png"];
//             /**/
//        } progress:^(NSProgress * _Nonnull uploadProgress) {
//            NSLog(@"uploadProgress = %@",uploadProgress);
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"responseObject = %@, task = %@",responseObject,task);
//            //        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//            //        NSLog(@"obj = %@",obj);
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"error = %@",error);
//        }];
    
//    PostStoreManageViewController *vc =[[PostStoreManageViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
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
