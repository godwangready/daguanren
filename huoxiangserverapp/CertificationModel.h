//
//  CertificationModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/1.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"
/*
 {
 auditTime = 1501556726000;
 businessLicense = 8;
 cardId = 8;
 currentPage = 0;
 id = 3;
 identifyStatus = 1;
 identifyVerifyTime = 1501556511000;
 limit = 20;
 maxRows = 5000;
 operatorId = 1;
 pages = 0;
 principalName = 8;
 resMsg = "\U4e0d\U884c";
 start = 0;
 telephone = 8;
 total = 0;
 userId = 9;
 }
 */
@interface CertificationModel : BaseModel
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *cardId;
@property (nonatomic, strong) NSString *principalName;
@property (nonatomic, strong) NSString *businessLicense;
@property (nonatomic, strong) NSString *auditTime;
@property (nonatomic, strong) NSString *telephone;
@end
