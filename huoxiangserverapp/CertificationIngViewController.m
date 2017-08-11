//
//  CertificationIngViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/25.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "CertificationIngViewController.h"

@interface CertificationIngViewController () {
    UILabel *onelabel;
    UILabel *twolabel;
    UILabel *threelabel;
}

@end

@implementation CertificationIngViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    // Do any additional setup after loading the view.
    [self wtTopViewWithBackString:@"返回-" andTitlestring:@"店家认证"];
    onelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, KscreeWidth, 30)];
    onelabel.textColor = [UIColor colorWithHexString:@"666666"];
    onelabel.font = [UIFont systemFontOfSize:14];
    onelabel.textAlignment = NSTextAlignmentCenter;
    onelabel.text = @"你的认证信息已提交成功";
    [self.view addSubview:onelabel];
    twolabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 230, KscreeWidth, 30)];
    twolabel.text = @"审核将在1~3个工作日内完成";
    twolabel.textColor = [UIColor colorWithHexString:@"666666"];
    twolabel.font = [UIFont systemFontOfSize:14];
    twolabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:twolabel];
    threelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, KscreeWidth, 30)];
    threelabel.text = @"请耐心等待，谢谢";
    threelabel.textColor = [UIColor colorWithHexString:@"666666"];
    threelabel.font = [UIFont systemFontOfSize:14];
    threelabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:threelabel];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [self hideTabBar];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self showTabBar];
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
