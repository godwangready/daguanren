//
//  ImagePickTableViewCell.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/2.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "ImagePickTableViewCell.h"

@implementation ImagePickTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)deleteAction:(UIButton *)sender {
    NSLog(@"%@", sender);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:self.pickImage forKey:@"delete"];
    [[NSNotificationCenter defaultCenter] postNotificationName:NsNotficationDeleteImage object:nil userInfo:dict];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
