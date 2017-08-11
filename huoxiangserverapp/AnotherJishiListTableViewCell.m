//
//  AnotherJishiListTableViewCell.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/7.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "AnotherJishiListTableViewCell.h"

@implementation AnotherJishiListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)canleTuijianAction:(UIButton *)sender {
    NSDictionary *dict = @{@"mainkey":[NSString stringWithFormat:@"%@", self.mainkey]};
    [[NSNotificationCenter defaultCenter] postNotificationName:NsnotficationJishiCancleTuijian object:nil userInfo:dict];
}
- (IBAction)bianhaoAction:(UIButton *)sender {
    NSDictionary *dict = @{@"mainkey":[NSString stringWithFormat:@"%@", self.mainkey],@"servernum":[NSString stringWithFormat:@"%@", self.serverNumber]};
    [[NSNotificationCenter defaultCenter] postNotificationName:NsNotficationJishibianhao object:nil userInfo:dict];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
