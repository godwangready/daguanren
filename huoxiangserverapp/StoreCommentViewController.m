//
//  StoreCommentViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/31.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "StoreCommentViewController.h"
#import "StoreCommentTableViewCell.h"
#import "StoreListTableViewCell.h"

static NSString *cellcommentid = @"commentcell";
static NSString *cellcommentlistid = @"commentlistcell";
@interface StoreCommentViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *commentTableview;
@end

@implementation StoreCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commentTableview];

}
- (UITableView *)commentTableview {
    if (!_commentTableview) {
        _commentTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, KscreeHeight - 64 - 20)];
        _commentTableview.delegate = self;
        _commentTableview.dataSource = self;
        [self.view addSubview:_commentTableview];
    }
    return _commentTableview;
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     messageLabel.textColor = [UIColor colorWithHexString:@"666666"];
     NSString *phoneString = @"已发送短信验证码到12345678901";
     NSMutableAttributedString *atstring = [[NSMutableAttributedString alloc] initWithString:phoneString];
     [atstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"ff8042"] range:NSMakeRange(9, 11)];
     messageLabel.attributedText = atstring;
     */
    if (indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 6) {
        StoreCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellcommentid];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StoreCommentTableViewCell" owner:nil options:nil] lastObject];
        }
        return cell;
    }
    StoreListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellcommentlistid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StoreListTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 6) {
        return 190;
    }
    return 260 + 30;
    //手动计算
    /*
     NSString *messageString = @"尊敬的各位领导，各位来宾，女士们，先生们大家下午好！很高兴能够在这个生机勃勃的春天里，和大家相约在唐山创造力沙龙成立唐山创造力沙龙成立仪式暨第三届房地产业界营销精英论坛，本次活动由共青团唐山市委和唐山市文化广播电视新闻出版局主办，唐山电台，唐山电视台，唐山广播电视报社联合承办的。";
     CGSize messagesize = [messageString boundingRectWithSize:CGSizeMake(frame.size.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
     */
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
