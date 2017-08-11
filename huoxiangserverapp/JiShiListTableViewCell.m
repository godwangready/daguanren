//
//  JiShiListTableViewCell.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/31.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "JiShiListTableViewCell.h"

@implementation JiShiListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)numberAction:(UIButton *)sender {
    NSDictionary *dict = @{@"mainkey":[NSString stringWithFormat:@"%@", self.mainkey],@"servernum":[NSString stringWithFormat:@"%@", self.serverNumber]};
    [[NSNotificationCenter defaultCenter] postNotificationName:NsNotficationJishibianhao object:nil userInfo:dict];;


}
- (IBAction)setUpAction:(UIButton *)sender {
    NSDictionary *dict = @{@"mainkey":[NSString stringWithFormat:@"%@", self.mainkey]};
    NSNotification *notification = [NSNotification notificationWithName:NsnotficationJiShiTuiJian object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
