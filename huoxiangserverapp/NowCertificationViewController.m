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
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation NowCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postCertification.layer.masksToBounds = YES;
    self.postCertification.layer.cornerRadius = 45 / 2;
    self.clanceButton.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    if (self.clanceID) {
        if ([self.clanceID integerValue] == 0) {
            self.clanceButton.hidden = NO;
            self.backButton.hidden = YES;
        }
    }
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)dismissAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)postAction:(UIButton *)sender {
//    [self judgeIdentityStringValid:[NSString stringWithFormat:@"%@", self.personNumberTF.text]];
    if (self.personNumberTF.text.length != 18){
        [CMMUtility showFailureWith:@"请输入有效身份证号码"];
        return;
    }
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:self.personNumberTF.text]) {
        [CMMUtility showFailureWith:@"请输入有效身份证号码"];
        return;
    }
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[self.personNumberTF.text substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [self.personNumberTF.text substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            [CMMUtility showFailureWith:@"请输入有效身份证号码"];
            return;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            [CMMUtility showFailureWith:@"请输入有效身份证号码"];
            return;
        }
    }
    if (self.phoneTF.text.length != 11) {
        [CMMUtility showFailureWith:@"请输入有效手机号码"];
        return;
    }
    if (self.certificationTF.text.length != 15) {
        [CMMUtility showFailureWith:@"请输入有效营业执照编号"];
        return;
    }
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
    [outDict setObject:@"store_authentication" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:ApproveUrl] parameters:outDict success:^(NSDictionary *data) {
//        NSDictionary *dictt = [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]];
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            [CMMUtility showSucessWith:@"认证提交成功"];
            NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
            [userid setObject:@"2" forKey:CredentialsidentifyStatus];
            [userid synchronize];
//            CertificationIngViewController *vc = [[CertificationIngViewController alloc] init];
            [self.navigationController popToRootViewControllerAnimated:YES];
            if (self.clanceID) {
                if ([self.clanceID integerValue] == 0) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }
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
