//
//  TeacherBindedViewController.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/28.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"

@interface TeacherBindedViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *backimageView;
@property (weak, nonatomic) IBOutlet UILabel *backImageNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;
@property (weak, nonatomic) IBOutlet UILabel *whatLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *outBindButton;
@property (nonatomic, strong) NSMutableArray *backimageArray;
@property (nonatomic, strong) NSString *bindingId;
@property (nonatomic, strong) NSString *storeId;

@end
