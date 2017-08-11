//
//  JishiViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/31.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "JishiViewController.h"
#import "JishiListViewController.h"
#import "BindingViewController.h"
#import "RecordViewController.h"
@interface JishiViewController () {
    UIButton *storebutton;
    UIButton *userbutton;
    UIButton *threebutton;
}
@property (nonatomic, assign) CGFloat tag;
@end

@implementation JishiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tag = 10000;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self clickBar];
    [self contentView];
    [self controllerArray];
    [self initClickBar];
    [self initScrollViewContainer];
    [self addChildControllers];
    // Do any additional setup after loading the view.
}
- (UIView *)clickBar {
    if (!_clickBar) {
        _clickBar = [[UIView alloc] init];
        _clickBar.backgroundColor = [UIColor whiteColor];
        CGFloat width = 75;
        CGFloat height = 30;
//        if (KscreeWidth == 320) {
//            width = 80;
//        }
        UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backbutton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        backbutton.frame = CGRectMake(15, 30, 30, 18);
        [backbutton setImage:[UIImage imageNamed:@"返回-"] forState:UIControlStateNormal];
        [_clickBar addSubview:backbutton];
        storebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        storebutton.frame = CGRectMake((KscreeWidth / 2) - width - (width / 2), 24, width, height);
        [storebutton addTarget:self action:@selector(setTopViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [storebutton setBackgroundColor:[UIColor colorWithHexString:@"ff8042"]];
        storebutton.layer.masksToBounds = YES;
        storebutton.layer.cornerRadius = 3;
        storebutton.layer.borderWidth = 1;
        storebutton.layer.borderColor = [UIColor colorWithHexString:@"ff8042"].CGColor;
        [storebutton setTitle:@"技师列表" forState:UIControlStateNormal];
//        [storebutton.titleLabel setFont:[UIFont fontWithName:@"PingFang Medium.ttf" size:13]];
        storebutton.titleLabel.font = [UIFont systemFontOfSize:13];
        [storebutton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        storebutton.tag = _tag;
        [_clickBar addSubview:storebutton];
        userbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        userbutton.frame = CGRectMake((KscreeWidth / 2) - (width / 2) - 2, 24, width, height);
        [userbutton addTarget:self action:@selector(setTopViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [userbutton setTitle:@"申请绑定" forState:UIControlStateNormal];
        userbutton.layer.masksToBounds = YES;
        userbutton.layer.cornerRadius = 3;
        userbutton.layer.borderWidth = 1;
        userbutton.layer.borderColor = [UIColor colorWithHexString:@"ff8042"].CGColor;
//        [userbutton.titleLabel setFont:[UIFont fontWithName:@"PingFang Medium.ttf" size:13]];
        userbutton.titleLabel.font = [UIFont systemFontOfSize:13];
        [userbutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
        [userbutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
        userbutton.tag = _tag + 1;
        [_clickBar addSubview:userbutton];
        threebutton = [UIButton buttonWithType:UIButtonTypeCustom];
         [threebutton addTarget:self action:@selector(setTopViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [threebutton setTitle:@"解绑记录" forState:UIControlStateNormal];
        threebutton.frame = CGRectMake((KscreeWidth / 2) + (width / 2) - 4, 24, width, height);
        [threebutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
        [threebutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
        threebutton.tag = _tag + 2;
        threebutton.layer.masksToBounds = YES;
        threebutton.layer.cornerRadius = 3;
        threebutton.layer.borderWidth = 1;
        threebutton.layer.borderColor = [UIColor colorWithHexString:@"ff8042"].CGColor;
        threebutton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_clickBar addSubview:threebutton];
        
    }
    return _clickBar;
}
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.pagingEnabled = YES;
//        _contentView.delegate = self;
        _contentView.scrollEnabled = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.contentSize = CGSizeMake(KscreeWidth * 3, KscreeHeight - 84);
        
    }
    return _contentView;
}
- (NSArray *)controllerArray {
    if (!_controllerArray) {
        _controllerArray = @[@"技师列表",@"绑定申请",@"解绑记录"];
    }
    return _controllerArray;
}
- (void) addChildControllers {
    JishiListViewController *listvc = [[JishiListViewController alloc] init];
    [self addChildViewController:listvc];
    BindingViewController *bindvc = [[BindingViewController alloc] init];
    [self addChildViewController:bindvc];
    RecordViewController *recordvc = [[RecordViewController alloc] init];
    [self addChildViewController:recordvc];
    [self scrollViewDidEndDecelerating:self.contentView];
}
- (void) initScrollViewContainer {
    _contentView.frame = CGRectMake(0, 84, KscreeWidth, KscreeHeight - 84);
    [self.view addSubview:self.contentView];
}
- (void) initClickBar {
    _clickBar.frame = CGRectMake(0, 0, KscreeWidth, 64);
    [self.view addSubview:self.clickBar];
}
- (void) setTopViewAction:(UIButton *)sender {
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag - 10000) {
        case 0:
        {
            [storebutton setBackgroundColor:[UIColor colorWithHexString:@"ff8042"]];
            [storebutton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
            [userbutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
            [userbutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
            [threebutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
            [threebutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];

        }
            break;
        case 1:
        {
            [userbutton setBackgroundColor:[UIColor colorWithHexString:@"ff8042"]];
            [userbutton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
            [storebutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
            [storebutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
            [threebutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
            [threebutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [threebutton setBackgroundColor:[UIColor colorWithHexString:@"ff8042"]];
            [threebutton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
            [userbutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
            [userbutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
            [storebutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
            [storebutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }

    [self.contentView setContentOffset:CGPointMake((sender.tag - 10000) * KscreeWidth, 0) animated:YES];
    UIViewController *vc = self.childViewControllers[(sender.tag - 10000)];
    [self.contentView addSubview:vc.view];
    vc.view.frame = CGRectMake((sender.tag - 10000) * KscreeWidth, 0, KscreeWidth, KscreeHeight - 84);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint currentOffSize = scrollView.contentOffset;
    NSInteger page = currentOffSize.x / KscreeWidth;
    switch (page) {
        case 0:
        {
            [storebutton setBackgroundColor:[UIColor colorWithHexString:@"ff8042"]];
            [storebutton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
            [userbutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
            [userbutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
            [threebutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
            [threebutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            [userbutton setBackgroundColor:[UIColor colorWithHexString:@"ff8042"]];
            [userbutton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
            [storebutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
            [storebutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
            [threebutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
            [threebutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [threebutton setBackgroundColor:[UIColor colorWithHexString:@"ff8042"]];
            [threebutton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
            [userbutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
            [userbutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
            [storebutton setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
            [storebutton setTitleColor:[UIColor colorWithHexString:@"ff8042"] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    UIViewController *vc = self.childViewControllers[page];
    [self.contentView addSubview:vc.view];
    vc.view.frame = CGRectMake(page * KscreeWidth, 0, KscreeWidth, KscreeHeight - 84);
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
