//
//  BindingTableViewCell.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/31.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BindingTableViewCell.h"

@implementation BindingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)agreeAction:(UIButton *)sender {
    NSDictionary *dict = [NSDictionary dictionaryWithObject:self.mainkey forKey:@"mainkey"];
    [[NSNotificationCenter defaultCenter] postNotificationName:NsnotificationAgreeTeacherBinding object:nil userInfo:dict];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
