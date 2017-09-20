//
//  StoreManageViewController.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/2.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^changeIconImage)(UIImage *);
@interface StoreManageViewController : BaseViewController
@property (nonatomic, copy) changeIconImage pullIconImage;
@property (nonatomic, strong) NSString *storenamels;
@property (nonatomic, strong) NSString *storephones;
@property (nonatomic, strong) NSString *storeadress;
@property (nonatomic, strong) NSMutableArray *storepictureArray;
@property (nonatomic, strong) NSString *storenotes;
@property (nonatomic, strong) NSString *lats;
@property (nonatomic, strong) NSString *lngs;
@property (nonatomic, strong) NSString *adcodes;
@end
