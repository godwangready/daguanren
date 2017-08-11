//
//  JiShiListTableViewCell.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/31.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiShiListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *bianhao;
@property (weak, nonatomic) IBOutlet UIButton *tuijian;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bianhaoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *sixImage;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@property (nonatomic, strong) NSString *mainkey;
@property (nonatomic, strong) NSString *serverNumber;
@end
