//
//  FriendPictureModel.m
//  huoxiangserverapp
//
//  Created by mc on 17/8/14.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "FriendPictureModel.h"

@implementation FriendPictureModel
- (NSMutableArray *)commentFrameArray {
    if (!_commentFrameArray) {
        _commentFrameArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _commentFrameArray;
}
- (NSMutableArray *)commentArray {
    if (!_commentArray) {
        _commentArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _commentArray;
}
- (NSMutableArray *)replyImagesArray {
    if (!_replyImagesArray) {
        _replyImagesArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _replyImagesArray;
}
@end
