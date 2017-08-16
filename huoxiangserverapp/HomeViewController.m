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

#import "WSDatePickerView.h"
#define UpButtonTag 10000
#define DownButtonTag 20000
#define ButtonSizeWH 60//35
//#define ButtonSizeHW
@interface HomeViewController () {
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
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"f0f2f8"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNameAction) name:NsNotficationRefreshName object:nil];
    [self setTopView];
    [self setlayout];    
}
- (void) changeNameAction {
    NSUserDefaults *userDF = [NSUserDefaults standardUserDefaults];
        nameLabel.text = [NSString stringWithFormat:@"%@", [userDF objectForKey:@"nickname"]];
}
- (void) setTopView {
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, 200)];
    topView.backgroundColor = [UIColor colorWithHexString:@"ff8042"];
    [self.view addSubview:topView];
    _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(KscreeWidth / 2 - 30, 45, 60, 60)];
    NSUserDefaults *userDF = [NSUserDefaults standardUserDefaults];
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[userDF objectForKey:@"headimage"]] placeholderImage:[UIImage imageNamed:@"删除"]];
//    iconImage.image = [UIImage imageNamed:@"删除"];
    _iconImage.layer.masksToBounds = YES;
    _iconImage.layer.cornerRadius = 30;
    [topView addSubview:_iconImage];
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, KscreeWidth, 30)];
    if ([NSString stringWithFormat:@"%@", [userDF objectForKey:@"nickname"]].length != 0) {
        nameLabel.text = [NSString stringWithFormat:@"%@", [userDF objectForKey:@"nickname"]];
    }else {
        nameLabel.text = @"天天足浴点";
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
            [WTNewRequest postWithURLString:[self createRequestUrl:Alterbusinesstime] parameters:outDict success:^(NSDictionary *data) {
                
            } failure:^(NSError *error) {
                
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
- (void)upAction:(UIButton *)sender {
    switch (sender.tag) {
        case 10000:
        {
            StoreManageViewController *vc = [[StoreManageViewController alloc] init];
            __weak HomeViewController *weakself = self;
            vc.pullIconImage = ^(UIImage *image) {
                weakself.iconImage.image = image;
            };
//            StoreManagementViewController *vc = [[StoreManagementViewController alloc] initWithNibName:@"StoreManagementViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10001:
        {
            JishiViewController *vc = [[JishiViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10002:
        {
            ManagemetViewController *vc = [[ManagemetViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 20000:
        {
            CommentViewController *vc = [[CommentViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 20001:
        {
            AddServicesViewController *vc = [[AddServicesViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 20002:
        {
            
        }
            break;
        default:
            break;
    }
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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
