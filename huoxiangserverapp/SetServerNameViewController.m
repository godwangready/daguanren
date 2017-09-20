//
//  SetServerNameViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/9/15.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "SetServerNameViewController.h"
#import "WSDatePickerView.h"
@interface SetServerNameViewController (){
    
    UIButton *rightButton;
}

@end

@implementation SetServerNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self requestPersonMessageData];
    [self HHwtTopViewWithBackString:@"返回-" andTitlestring:@"修改昵称" andrighttitle:@"保存"];
    [self setDownView];
}
#pragma mark - 个人信息
- (void)requestPersonMessageData {
    NSMutableDictionary *dict = [self makeDict];
    [WTNewRequest postWithURLString:[self createRequestUrl:Userdetail] parameters:dict success:^(NSDictionary *data) {
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
                
            }else {
                //[[[data objectForKey:@"resDate"] objectForKey:@"store"] objectForKey:@""]
                NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
                
                self.serversixs = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"sex"]];
                self.servernames = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"nickName"]];
                self.serverbirthdays = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"birthday"]];
                self.serverperosnSign = [NSString stringWithFormat:@"%@", [[WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]] objectForKey:@"signature"]];
                self.nameTF.text = self.servernames;
                [self.birthdayB setTitle:[self timeToDeadline:self.serverbirthdays] forState:UIControlStateNormal];
                self.serverbirthdays = [self timeToDeadline:self.serverbirthdays];
                if (self.serversixs.length == 0) {
                    [self.six setTitle:@"保密" forState:UIControlStateNormal];
                    [self.six setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
                    
                }else {
                    switch ([self.serversixs integerValue]) {
                        case 0:
                        {
                            [self.six setTitle:@"保密" forState:UIControlStateNormal];
                            [self.six setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
                        }
                            break;
                        case 1:
                        {
                            [self.six setTitle:@"男" forState:UIControlStateNormal];
                            [self.six setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
                        }
                            break;
                        case 2:
                        {
                            [self.six setTitle:@"女" forState:UIControlStateNormal];
                            [self.six setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
                        }
                            break;
                            
                        default:
                            break;
                    }
                }
                self.personSignatureTF.text = self.serverperosnSign;

            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
        
        
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"服务器故障"];
    }];
}
- (NSString *)timeToDeadline:(NSString *)timedate {
    NSTimeInterval time= ([timedate doubleValue]+28800) / 1000.0;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"-date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,设置需要的格式
    //    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    NSLog(@"-%@", currentDateStr);
    return currentDateStr;
}
- (void) HHwtTopViewWithBackString:(NSString *)backstring andTitlestring:(NSString *)titlestring andrighttitle:(NSString *)titlestrings {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 30, 18)];
    [backButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", backstring]] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(newbackAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KscreeWidth / 2) - 50, 30, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [NSString stringWithFormat:@"%@", titlestring];
    titleLabel.font = [UIFont fontWithName:@"PingFang Regular.ttf" size:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:titleLabel];
    
    rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake((KscreeWidth - 100 - 20), 30, 100, 20);
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment = NSTextAlignmentRight;
    //    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    rightButton.titleLabel.font = [UIFont fontWithName:@"PingFang Light.ttf" size:16];
    //    [rightButton.titleLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
    [rightButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(baserightAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightButton];
}
- (void) setDownView {
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, KscreeWidth, 55 * 4 + 3)];
    downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:downView];
    
    self.namelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 42, 30)];
    self.namelabel.text = @"昵称";
    self.namelabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    [downView addSubview:self.namelabel];
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(62, 10, KscreeWidth - 82, 30)];
    //    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    //    _nameTF.text = [userinfo objectForKey:@"nickname"];
    _nameTF.clearButtonMode = UITextFieldViewModeAlways;
    _nameTF.borderStyle = UITextBorderStyleNone;
    _nameTF.textColor = [UIColor colorWithHexString:@"333333"];
    _nameTF.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    _nameTF.textAlignment = NSTextAlignmentRight;
    self.nameTF.text = [NSString stringWithFormat:@"%@", self.servernames];
    [downView addSubview:_nameTF];
    self.oneline = [[UIView alloc] initWithFrame:CGRectMake(0, 55, KscreeWidth, 1)];
    self.oneline.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [downView addSubview:self.oneline];
    
    self.birthdaylabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 66, 42, 30)];
    self.birthdaylabel.text = @"生日";
    self.birthdaylabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    [downView addSubview:self.birthdaylabel];
    self.birthdayB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.birthdayB.frame = CGRectMake(62, 66, KscreeWidth - 82, 30);
    self.birthdayB.contentHorizontalAlignment = NSTextAlignmentRight;
    [self.birthdayB addTarget:self action:@selector(pickTimeAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.serverbirthdays.length == 0) {
        [self.birthdayB setTitle:@"出生日期" forState:UIControlStateNormal];
        [self.birthdayB setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    }else {
        
        [self.birthdayB setTitle:[NSString stringWithFormat:@"%@", [self timeToDeadline:self.serverbirthdays]] forState:UIControlStateNormal];
        [self.birthdayB setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    }
    [downView addSubview:self.birthdayB];
    self.twoline = [[UIView alloc] initWithFrame:CGRectMake(0, 111, KscreeWidth, 1)];
    self.twoline.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [downView addSubview:self.twoline];
    self.sixlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 112 + 10, 42, 30)];
    self.sixlabel.text = @"性别";
    self.sixlabel.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    [downView addSubview:self.sixlabel];
    self.six = [UIButton buttonWithType:UIButtonTypeCustom];
    self.six.frame = CGRectMake(62, 122, KscreeWidth - 82, 30);
    self.six.contentHorizontalAlignment = NSTextAlignmentRight;
    [self.six addTarget:self action:@selector(sixAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.serversixs.length == 0) {
        [self.six setTitle:@"保密" forState:UIControlStateNormal];
        [self.six setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        
    }else {
        switch ([self.serversixs integerValue]) {
            case 0:
            {
                [self.six setTitle:@"保密" forState:UIControlStateNormal];
                [self.six setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
            }
                break;
            case 1:
            {
                [self.six setTitle:@"男" forState:UIControlStateNormal];
                [self.six setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
            }
                break;
            case 2:
            {
                [self.six setTitle:@"女" forState:UIControlStateNormal];
                [self.six setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
            }
                break;
                
            default:
                break;
        }
    }
    [downView addSubview:self.six];
    _threeline = [[UIView alloc] initWithFrame:CGRectMake(0, 55 * 3 + 3, KscreeWidth, 1)];
    self.threeline.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [downView addSubview:self.threeline];
    self.personSignature = [[UILabel alloc] initWithFrame:CGRectMake(20, 112 + 55 + 10+ 1, 84, 30)];
    self.personSignature.text = @"个性签名";
    self.personSignature.font = [UIFont fontWithName:@"PingFang Medium.ttf" size:16];
    [downView addSubview:self.personSignature];
    self.personSignatureTF = [[UITextField alloc] initWithFrame:CGRectMake(104, 112 + 55 + 10 + 1, KscreeWidth - 104, 30)];
    self.personSignatureTF.placeholder = @"设置个性签名";
    self.personSignatureTF.textAlignment = NSTextAlignmentRight;
    self.personSignatureTF.clearButtonMode = UITextFieldViewModeAlways;
    self.personSignatureTF.borderStyle = UITextBorderStyleNone;
    [downView addSubview:self.personSignatureTF];
}
- (void) sixAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.serversixs = @"1";
        [self.six setTitle:@"男" forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.serversixs = @"2";
        [self.six setTitle:@"女" forState:UIControlStateNormal];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.serversixs = @"0";
        [self.six setTitle:@"保密" forState:UIControlStateNormal];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void) pickTimeAction {
    [self.nameTF resignFirstResponder];
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        NSString *datee = [startDate stringWithFormat:@"yyyyMMdd"];
        NSLog(@"时间： %@",date);
        [self.birthdayB setTitle:date forState:UIControlStateNormal];
        self.serverbirthdays = datee;
    }];
    datepicker.doneButtonColor = [UIColor colorWithHexString:@"ff8042"];//确定按钮的颜色
    [datepicker show];
}

- (void) newbackAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void) baserightAction {
    rightButton.userInteractionEnabled = NO;
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:[NSString stringWithFormat:@"%@", _nameTF.text] forKey:@"nickName"];
    [dict setObject:@"3" forKey:@"roleId"];
    [dict setObject:[NSString stringWithFormat:@"%@", self.serverbirthdays] forKey:@"birthday"];
    [dict setObject:[NSString stringWithFormat:@"%@", self.serversixs] forKey:@"sex"];
    [dict setObject:[NSString stringWithFormat:@"%@", self.personSignatureTF.text] forKey:@"signature"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Changenickname] parameters:outDict success:^(NSDictionary *data) {
        rightButton.userInteractionEnabled = YES;
        if (([[data objectForKey:@"resCode"] integerValue] == 100)) {
            [CMMUtility showSucessWith:@"修改成功"];
            NSUserDefaults *userionfo = [NSUserDefaults standardUserDefaults];
            [userionfo setObject:[NSString stringWithFormat:@"%@", _nameTF.text] forKey:@"nickname"];
            [userionfo synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [CMMUtility showFailureWith:@"修改昵称失败"];
        }
    } failure:^(NSError *error) {
        rightButton.userInteractionEnabled = YES;
        [CMMUtility showFailureWith:@"修改昵称失败"];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nameTF resignFirstResponder];
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
