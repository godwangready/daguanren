//
//  AddServicesTableViewCell.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/14.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "AddServicesTableViewCell.h"

@implementation AddServicesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)payServiesAction:(UIButton *)sender {
    NSDictionary *dict = @{@"1":@"1"};
    [[NSNotificationCenter defaultCenter] postNotificationName:NsnotificationStartPayServices object:nil userInfo:dict];
}

@end
