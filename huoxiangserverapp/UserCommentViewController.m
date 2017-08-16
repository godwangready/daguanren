//
//  UserCommentViewController.m
//  huoxiangserverapp
//
//  Created by mc on 17/7/31.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import "UserCommentViewController.h"
#import "CommentTableViewCell.h"
#import "CommentModel.h"
#import "CommentFrameModel.h"

static NSString *cellId = @"commentcellid";
@interface UserCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *commentTV;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *frameArray;

@end

@implementation UserCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    // Do any additional setup after loading the view.
    
    //手动计算
    NSString *messageString1 = @"店铺环节不错，装修不错，物有所值，下次还来，超级棒,哈哈哈哈哈";
    CGSize messagesize1 = [messageString1 boundingRectWithSize:CGSizeMake(KscreeWidth - 150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    CommentModel *model1 = [[CommentModel alloc] init];
    model1.contents = messageString1;
    model1.replys = messageString1;
    model1.names = @"我是小花呀";
    model1.marks = @"打分";
    model1.replyImagesArray = [[NSArray alloc] init];
    CommentFrameModel *frameModel1 = [[CommentFrameModel alloc] init];
    frameModel1.contentFrame = CGRectMake(0, 0, 0, messagesize1.height);
    frameModel1.replyLablelFrame = CGRectMake(0, 0, 0, messagesize1.height);
    frameModel1.replyImageFrame = CGRectMake(0, 0, 0, 0);
    frameModel1.replyImageFrame1 = CGRectMake(0, 0, 0, 0);
    frameModel1.replyImageFrame2 = CGRectMake(0, 0, 0, 0);
    frameModel1.replyImageFrame3 = CGRectMake(0, 0, 0, 0);
    [self.dataSource addObject:model1];
    [self.frameArray addObject:frameModel1];
    
    //手动计算
    NSString *messageString = @"店铺环节不错，装修不错，物有所值，下次还来，超级棒,哈哈哈哈哈";
    CGSize messagesize = [messageString boundingRectWithSize:CGSizeMake(KscreeWidth - 150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    CommentModel *model = [[CommentModel alloc] init];
    model.contents = messageString;
    model.replys = messageString;
    model.names = @"我是小花呀";
    model.marks = @"打分";
    model.replyImagesArray = @[@"s",@"s"];
    CommentFrameModel *frameModel = [[CommentFrameModel alloc] init];
    frameModel.contentFrame = CGRectMake(0, 0, 0, messagesize.height);
    frameModel.replyLablelFrame = CGRectMake(0, 0, 0, messagesize.height);
    if (KscreeWidth == 320) {
        frameModel.replyImageFrame = CGRectMake(0, 0, 0, 50);
        frameModel.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
        frameModel.replyImageFrame2 = CGRectMake(0, 0, 0, 0);
        frameModel.replyImageFrame3 = CGRectMake(0, 0, 0, 0);
        
    }else {
        frameModel.replyImageFrame = CGRectMake(0, 0, 0, 75);
        frameModel.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
        frameModel.replyImageFrame2 = CGRectMake(0, 0, 0, 0);
        frameModel.replyImageFrame3 = CGRectMake(0, 0, 0, 0);
    }
    [self.dataSource addObject:model];
    [self.frameArray addObject:frameModel];
    
    //手动计算
    NSString *messageString3 = @"店铺环节不错，装修不错，物有所值，下次还来，超级棒,哈哈哈哈哈";
    CGSize messagesize3 = [messageString3 boundingRectWithSize:CGSizeMake(KscreeWidth - 150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    CommentModel *model3 = [[CommentModel alloc] init];
    model3.contents = messageString3;
    model3.replys = messageString3;
    model3.names = @"我是小花呀";
    model3.marks = @"打分";
    model3.replyImagesArray = @[@"",@"",@""];
    CommentFrameModel *frameModel3 = [[CommentFrameModel alloc] init];
    frameModel3.contentFrame = CGRectMake(0, 0, 0, messagesize3.height);
    frameModel3.replyLablelFrame = CGRectMake(0, 0, 0, messagesize3.height);
    if (KscreeWidth == 320) {
        frameModel3.replyImageFrame = CGRectMake(0, 0, 0, 50);
        frameModel3.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
        frameModel3.replyImageFrame2 = CGRectMake(0, 0, 50, 50);
        frameModel3.replyImageFrame3 = CGRectMake(0, 0, 50, 50);
    }else {
        frameModel3.replyImageFrame = CGRectMake(0, 0, 0, 75);
        frameModel3.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
        frameModel3.replyImageFrame2 = CGRectMake(0, 0, 75, 75);
        frameModel3.replyImageFrame3 = CGRectMake(0, 0, 75, 75);
    }
    [self.dataSource addObject:model3];
    [self.frameArray addObject:frameModel3];
    
    [self.view addSubview:self.commentTV];
}
- (UITableView *)commentTV {
    if (!_commentTV) {
        _commentTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreeWidth, KscreeHeight - 84) style:UITableViewStylePlain];
        _commentTV.delegate = self;
        _commentTV.dataSource = self;
        _commentTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_commentTV registerClass:[CommentTableViewCell class] forCellReuseIdentifier:cellId];
    }
    return _commentTV;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (NSMutableArray *)frameArray {
    if (!_frameArray) {
        _frameArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _frameArray;
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
//24content间隔
//10底部间隔
//70出去replylabel contentlabel 空间高度
//50 75相册高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentFrameModel *frameModel = self.frameArray[indexPath.row];
    if (frameModel.replyImageFrame.size.height >= 50) {
        if (KscreeWidth == 320) {
            return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replyLablelFrame.size.height + 50;
            
        }else {
            return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replyLablelFrame.size.height + 75;
            
        }
    }else {
            return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replyLablelFrame.size.height ;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    CommentModel *model = self.dataSource[indexPath.row];
    CommentFrameModel *frameModel = self.frameArray[indexPath.row];
    cell.frameModel = frameModel;
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
