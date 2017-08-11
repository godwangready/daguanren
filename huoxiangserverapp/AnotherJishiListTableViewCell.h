//
//  AnotherJishiListTableViewCell.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/7.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnotherJishiListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *numberLable;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *sixImage;
@property (weak, nonatomic) IBOutlet UILabel *ageLable;
@property (weak, nonatomic) IBOutlet UIButton *cancleTuijian;
@property (weak, nonatomic) IBOutlet UIButton *bianhao;

@property (nonatomic, strong) NSString *mainkey;
@property (nonatomic, strong) NSString *serverNumber;
@end
