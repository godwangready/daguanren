//
//  SetServerNameViewController.h
//  huoxiangserverapp
//
//  Created by mc on 17/9/15.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"

@interface SetServerNameViewController : BaseViewController
@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UIView *oneline;
@property (nonatomic, strong) UILabel *birthdaylabel;
@property (nonatomic, strong) UIView *twoline;
@property (nonatomic, strong) UILabel *sixlabel;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UIButton *birthdayB;
@property (nonatomic, strong) UIButton *six;
@property (nonatomic, strong) UIView *threeline;
@property (nonatomic, strong) UILabel *personSignature;
@property (nonatomic, strong) UITextField *personSignatureTF;

@property (nonatomic, strong) NSString *servernames;
@property (nonatomic, strong) NSString *serverbirthdays;
@property (nonatomic, strong) NSString *serversixs;
@property (nonatomic, strong) NSString *serverperosnSign;
@end
