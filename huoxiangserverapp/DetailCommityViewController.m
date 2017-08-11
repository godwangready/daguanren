//
//  DetailCommityViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/2.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "DetailCommityViewController.h"
#import "WSDatePickerView.h"
@interface DetailCommityViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startTime;
@property (weak, nonatomic) IBOutlet UIButton *endTime;
@property (weak, nonatomic) IBOutlet UIButton *fuwuTime;
@property (weak, nonatomic) IBOutlet UIButton *fuwuEndTime;
@property (weak, nonatomic) IBOutlet UIButton *safeButton;
@property (weak, nonatomic) IBOutlet UITextField *yuyueTF;
@property (weak, nonatomic) IBOutlet UITextField *guizeTF;

@end

@implementation DetailCommityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    self.safeButton.layer.masksToBounds = YES;
    self.safeButton.layer.cornerRadius = 45 / 2;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)startTimeAction:(UIButton *)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        NSLog(@"时间： %@",date);
        [_startTime setTitle:date forState:UIControlStateNormal];
        
    }];
    datepicker.doneButtonColor = [UIColor colorWithHexString:@"ff8042"];//确定按钮的颜色
    [datepicker show];
}
- (IBAction)endAction:(UIButton *)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        NSLog(@"时间： %@",date);
        [_endTime setTitle:date forState:UIControlStateNormal];
        
    }];
    datepicker.doneButtonColor = [UIColor colorWithHexString:@"ff8042"];//确定按钮的颜色
    [datepicker show];
}
- (IBAction)fuwuTimeAction:(UIButton *)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowHourMinute CompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"HH:mm"];
        NSLog(@"时间： %@",date);
        [_fuwuTime setTitle:date forState:UIControlStateNormal];
        
    }];
    datepicker.doneButtonColor = [UIColor colorWithHexString:@"ff8042"];//确定按钮的颜色
    [datepicker show];
}
- (IBAction)fuwuEndTime:(UIButton *)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowHourMinute CompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"HH:mm"];
        NSLog(@"时间： %@",date);
        [_fuwuEndTime setTitle:date forState:UIControlStateNormal];
        
    }];
    datepicker.doneButtonColor = [UIColor colorWithHexString:@"ff8042"];//确定按钮的颜色
    [datepicker show];
}
- (IBAction)safeAction:(UIButton *)sender {
    NSString *str = @"www";
    self.passValue(str);
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_yuyueTF resignFirstResponder];
    [_guizeTF resignFirstResponder];
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
