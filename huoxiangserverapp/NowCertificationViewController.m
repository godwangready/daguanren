//
//  NowCertificationViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/25.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "NowCertificationViewController.h"
#import "CertificationIngViewController.h"

@interface NowCertificationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *personNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *certificationTF;
@property (weak, nonatomic) IBOutlet UIButton *postCertification;

@end

@implementation NowCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postCertification.layer.masksToBounds = YES;
    self.postCertification.layer.cornerRadius = 45 / 2;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)postAction:(UIButton *)sender {
    if (self.nameTF.text.length == 0 || self.phoneTF.text.length == 0 || self.personNumberTF.text.length == 0 || self.certificationTF.text.length == 0) {
        [CMMUtility showFailureWith:@"请完整填写资料"];
        return;
    }
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:_nameTF.text forKey:@"principalName"];
    [dict setObject:_phoneTF.text forKey:@"telephone"];
    [dict setObject:_personNumberTF.text forKey:@"cardId"];
    [dict setObject:_certificationTF.text forKey:@"businessLicense"];
    NSString *postdatastring = [WTCJson dictionaryToJson:dict];
    [outDict setObject:postdatastring forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:ApproveUrl] parameters:outDict success:^(NSDictionary *data) {
        NSDictionary *dictt = [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]];
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            [CMMUtility showSucessWith:@"认证提交成功"];
            CertificationIngViewController *vc = [[CertificationIngViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            //identifyStatus
        }else {
            [CMMUtility showFailureWith:@"认证提交失败"];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nameTF resignFirstResponder];
    [self.phoneTF resignFirstResponder];
    [self.personNumberTF resignFirstResponder];
    [self.certificationTF resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self hideTabBar];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
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
