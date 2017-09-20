//
//  TeacherDetailBindingViewController.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/18.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"

@interface TeacherDetailBindingViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (nonatomic, strong) NSString *storeId;
@property (weak, nonatomic) IBOutlet UIView *imageNumberView;
@property (weak, nonatomic) IBOutlet UILabel *imageNUmberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *detaillocationLabel;
@property (weak, nonatomic) IBOutlet UIButton *bindingButton;
@property (nonatomic, strong) NSMutableArray *backimageArray;

@end
