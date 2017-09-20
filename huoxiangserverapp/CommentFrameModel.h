//
//  CommentFrameModel.h
//  huoxiangserverapp
//
//  Created by mc on 17/8/15.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "BaseModel.h"

@interface CommentFrameModel : BaseModel
/*
 cell控件的高度数据
 */
@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect markFrame;
@property (nonatomic, assign) CGRect markStarFrame;
@property (nonatomic, assign) CGRect timeFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect selectFrame;
@property (nonatomic, assign) CGRect replyFrame;
@property (nonatomic, assign) CGRect lineFrame;
@property (nonatomic, assign) CGRect replyLablelFrame;
@property (nonatomic, assign) CGRect replyImageFrame;
@property (nonatomic, assign) CGRect replyImageFrame1;
@property (nonatomic, assign) CGRect replyImageFrame2;
@property (nonatomic, assign) CGRect replyImageFrame3;
@property (nonatomic, assign) CGRect replayDownViewFrame;
@property (nonatomic, assign) CGRect replayTableViewFrame;
@end
