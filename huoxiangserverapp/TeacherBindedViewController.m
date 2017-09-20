//
//  TeacherBindedViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/28.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "TeacherBindedViewController.h"

@interface TeacherBindedViewController ()
@property (weak, nonatomic) IBOutlet UIView *backimagenumberdown;

@end

@implementation TeacherBindedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.outBindButton.layer.masksToBounds = YES;
    self.outBindButton.layer.cornerRadius = self.outBindButton.frame.size.height / 2;
    self.backimagenumberdown.layer.masksToBounds = YES;
    self.backimagenumberdown.layer.cornerRadius = 2;
    [self requeststoredetail];
}
- (NSMutableArray *)backimageArray {
    if (!_backimageArray) {
        _backimageArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _backimageArray;
}
- (IBAction)outBindAction:(UIButton *)sender {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableDictionary *outDict = [self makeDict];
    [dict setObject:[NSString stringWithFormat:@"%@", self.bindingId] forKey:@"bindingId"];
    [dict setObject:@"2" forKey:@"bindingStatus"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Bindingstatus] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:@"2" forKey:@"bindingstatus"];
        [user synchronize];
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            [CMMUtility showSucessWith:@"解绑成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
- (void)requeststoredetail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableDictionary *outDict = [self makeDict];
    [dict setObject:[NSString stringWithFormat:@"%@", self.storeId] forKey:@"storeId"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Storedetail] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
        self.storeLabel.text = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"storeName"]];
        self.locationLabel.text = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"address"]];
        switch ([[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"start"]] integerValue]) {
            case 0:
            {
                self.star1.image = [UIImage imageNamed:@"星-拷贝-4"];
                self.star2.image = [UIImage imageNamed:@"星-拷贝-4"];
                self.star3.image = [UIImage imageNamed:@"星-拷贝-4"];
                self.star4.image = [UIImage imageNamed:@"星-拷贝-4"];
                self.star5.image = [UIImage imageNamed:@"星-拷贝-4"];
                
            }
                break;
            case 1:
            {
                self.star1.image = [UIImage imageNamed:@"星"];
                self.star2.image = [UIImage imageNamed:@"星-拷贝-4"];
                self.star3.image = [UIImage imageNamed:@"星-拷贝-4"];
                self.star4.image = [UIImage imageNamed:@"星-拷贝-4"];
                self.star5.image = [UIImage imageNamed:@"星-拷贝-4"];
            }
                break;
            case 2:
            {
                self.star1.image = [UIImage imageNamed:@"星"];
                self.star2.image = [UIImage imageNamed:@"星"];
                self.star3.image = [UIImage imageNamed:@"星-拷贝-4"];
                self.star4.image = [UIImage imageNamed:@"星-拷贝-4"];
                self.star5.image = [UIImage imageNamed:@"星-拷贝-4"];
            }
                break;
            case 3:
            {
                self.star1.image = [UIImage imageNamed:@"星"];
                self.star2.image = [UIImage imageNamed:@"星"];
                self.star3.image = [UIImage imageNamed:@"星"];
                self.star4.image = [UIImage imageNamed:@"星-拷贝-4"];
                self.star5.image = [UIImage imageNamed:@"星-拷贝-4"];
            }
                break;
            case 4:
            {
                self.star1.image = [UIImage imageNamed:@"星"];
                self.star2.image = [UIImage imageNamed:@"星"];
                self.star3.image = [UIImage imageNamed:@"星"];
                self.star4.image = [UIImage imageNamed:@"星"];
                self.star5.image = [UIImage imageNamed:@"星-拷贝-4"];
            }
                break;
            case 5:
            {
                self.star1.image = [UIImage imageNamed:@"星"];
                self.star2.image = [UIImage imageNamed:@"星"];
                self.star3.image = [UIImage imageNamed:@"星"];
                self.star4.image = [UIImage imageNamed:@"星"];
                self.star5.image = [UIImage imageNamed:@"星"];
            }
                break;
                
            default:
                break;
        }
        if ([[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"pictureUrl"]] rangeOfString:@","].location != NSNotFound) {
            NSArray* array = [[NSString stringWithFormat:@"%@", [[[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"store"] objectForKey:@"pictureUrl"]] componentsSeparatedByString:@","];
            [self.backimageArray addObjectsFromArray:array];
            [self.backimageView sd_setImageWithURL:[NSURL URLWithString:[self.backimageArray firstObject]]];
        }else {
            if ([NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"pictureUrl"]].length != 0) {
                [self.backimageArray addObject:[NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"pictureUrl"]]];
                [self.backimageView sd_setImageWithURL:[NSURL URLWithString:[self.backimageArray firstObject]]];
            }else {
                //没图
            }
            
        }
        self.backImageNumberLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.backimageArray.count];
//        [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"pictureUrl"]];
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self hideTabBar];
    [super viewWillAppear:animated];
}
//- (void)viewDidDisappear:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self showTabBar];
//    [super viewWillDisappear:animated];
//}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
