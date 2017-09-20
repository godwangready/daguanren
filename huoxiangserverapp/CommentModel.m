//
//  CommentModel.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/15.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
- (NSMutableArray *)commentArray {
    if (!_commentArray) {
        _commentArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _commentArray;
}
- (NSMutableArray *)commentFrameArray {
    if (!_commentFrameArray) {
        _commentFrameArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _commentFrameArray;
}
- (NSMutableArray *)replyImagesArray {
    if (!_replyImagesArray) {
        _replyImagesArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _replyImagesArray;
}
@end
