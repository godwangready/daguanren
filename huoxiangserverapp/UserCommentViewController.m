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
#import "CommentCellModel.h"
#import "CommentCellFrameModel.h"
#import "LMJKeyboardShowHiddenNotificationCenter.h"

static NSString *cellId = @"commentcellid";
//, LMJKeyboardShowHiddenNotificationCenterDelegate, UITextFieldDelegate
@interface UserCommentViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate> {
    //回复遮罩层
    UIView*commentView;
}
//回复按钮
@property(nonatomic,strong)UIWindow*commentW;
@property(nonatomic,strong)UITextView*textView;

@property (nonatomic, strong) UITableView *commentTV;
//外层数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
//外层控件高度
@property (nonatomic, strong) NSMutableArray *frameArray;
//二层数据源
@property (nonatomic, strong) NSMutableArray *commentArray;
//二层控件高度
@property (nonatomic, strong) NSMutableArray *commentFrameArray;
//二层cell高度计算整个二层高度
@property (nonatomic, assign) CGFloat commentTotleH;
//@property (nonatomic, strong) UITextField *replyTF;
/*
 @回复ID
 @回复userID
 */
@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *toUserID;

@property (nonatomic, assign) NSInteger indexPage;
@end

@implementation UserCommentViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wtTopViewWithBackString:@"返回-" andTitlestring:@"店铺评论"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f8"];
    [self.view addSubview:self.commentTV];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(replyAction:) name:NsnotificationReplyComment object:nil];
//    self.replyTF = [[UITextField alloc] initWithFrame:CGRectMake(10, KscreeHeight, KscreeWidth - 20, 30)];
//    self.replyTF.delegate = self;
//    self.replyTF.placeholder = @"请输入评论";
//    self.replyTF.borderStyle = UITextBorderStyleRoundedRect;
//    [self.view addSubview:self.replyTF];
}
- (UITableView *)commentTV {
    if (!_commentTV) {
        _commentTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, KscreeWidth, KscreeHeight - 84) style:UITableViewStylePlain];
        _commentTV.delegate = self;
        _commentTV.dataSource = self;
        _commentTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_commentTV registerClass:[CommentTableViewCell class] forCellReuseIdentifier:cellId];
        _commentTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
        _commentTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
        [_commentTV.mj_header beginRefreshing];
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
- (void) downRefresh {
    [self requestData];
}
- (void) upRefresh {
    if (self.dataSource.count < 20) {
        [_commentTV.mj_footer endRefreshing];
        return;
    }
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"" forKey:@"currentPage"];
    [dict setObject:@"20" forKey:@"num"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [outDict setObject:@"store_visit_manage" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Usercomment] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", data);
        [_commentTV.mj_footer endRefreshing];
        /*
         防止空数据
         */
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
                
            }else {
                NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
                /*
                 提起外层数据
                 */
                for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
                    NSLog(@"%@", dict);
                    /*
                     外层模型赋值
                     */
                    CommentModel *model = [[CommentModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    CommentFrameModel *modelFrame = [[CommentFrameModel alloc] init];
                    modelFrame.contentFrame = CGRectMake(0, 0, 0, [self wtCalculatedHeight:[NSString stringWithFormat:@"%@", model.content]]);
                    /*
                     评论是否带图
                     */
                    if ([NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]].length != 0) {
                        if (KscreeWidth == 320) {
                            modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 50);
                            NSString *str = @",";
                            if ([[NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]] rangeOfString:str].location != NSNotFound) {
                                model.replyImagesArray = [NSMutableArray arrayWithArray:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]] componentsSeparatedByString:@","]];
                            }else {
                                [model.replyImagesArray addObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]]];
                            }
                            switch (model.replyImagesArray.count) {
                                case 1:
                                {
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                }
                                    break;
                                case 2:
                                {
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                    modelFrame.replyImageFrame2 = CGRectMake(52, 0, 50, 50);
                                }
                                    break;
                                case 3:
                                {
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                    modelFrame.replyImageFrame2 = CGRectMake(52, 0, 50, 50);
                                    modelFrame.replyImageFrame3 = CGRectMake(104, 0, 50, 50);
                                }
                                    break;
                                    
                                default:
                                    break;
                            }
                        }else {
                            modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 75);
                            NSString *str = @",";
                            if ([[NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]] rangeOfString:str].location != NSNotFound) {
                                model.replyImagesArray = [NSMutableArray arrayWithArray:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]] componentsSeparatedByString:@","]];
                            }else {
                                [model.replyImagesArray addObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]]];
                            }
                            //                            model.replyImagesArray = [NSMutableArray arrayWithArray:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"picture_url"]] componentsSeparatedByString:@","]];
                            switch (model.replyImagesArray.count) {
                                case 1:
                                {
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                }
                                    break;
                                case 2:
                                {
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(77, 0, 75, 75);
                                    
                                }
                                    break;
                                case 3:
                                {
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(77, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(154, 0, 75, 75);
                                }
                                    break;
                                    
                                default:
                                    break;
                            }
                        }
                        
                    }else {
                        modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 0);
                    }
                    /*
                     是否有回复
                     */
                    model.iscomment = @"0";
                    if ([NSMutableArray arrayWithArray:[dict objectForKey:@"sonComment"]].count != 0) {
                        /*
                         遍历
                         */
                        model.iscomment = @"1";
                        for (NSDictionary *dictt in [dict objectForKey:@"sonComment"]) {
                            /*
                             评论封装model数组
                             */
                            CommentCellModel *modell = [[CommentCellModel alloc] init];
                            [modell setValuesForKeysWithDictionary:dictt];
                            [self.commentArray addObject:modell];
                            [model.commentArray addObject:modell];
                            /*
                             评论高度封装model数组
                             */
                            CommentCellFrameModel *modelcellFrame = [[CommentCellFrameModel alloc] init];
                            NSString *strr = [NSString stringWithFormat:@"商家回复:%@",[dictt objectForKey:@"content"]];
                            modelcellFrame.cellFrameH = [self wtCalculatedHeight:strr];
                            [self.commentFrameArray addObject:modelcellFrame];
                            [model.commentFrameArray addObject:modelcellFrame];
                            /*
                             计算评论总高度
                             */
                            self.commentTotleH = self.commentTotleH + [self wtCalculatedHeight:[dictt objectForKey:@"content"]] + [self wtCalculatedHeight:@"商家回复:"];
                            modelFrame.replayDownViewFrame = CGRectMake(0, 0, 0, self.commentTotleH);
                            modelFrame.replayTableViewFrame = CGRectMake(0, 0, 0, self.commentTotleH);
                            [self.dataSource addObject:model];
                            [self.frameArray addObject:modelFrame];
                            
                        }
                        self.commentTotleH = 0;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.commentTV reloadData];
                        });
                    }else {
                        [self.dataSource addObject:model];
                        [self.frameArray addObject:modelFrame];
                        
                    }
                    
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.commentTV reloadData];
                });
                
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error.userInfo);
        [CMMUtility showFailureWith:@"服务器故障"];
        [_commentTV.mj_footer endRefreshing];
    }];
}
- (void)requestData {
    [self.dataSource removeAllObjects];
    NSMutableDictionary *outDict = [self makeDict];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"" forKey:@"currentPage"];
    [dict setObject:@"20" forKey:@"num"];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [outDict setObject:@"store_comment_manage" forKey:@"logView"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Usercomment] parameters:outDict success:^(NSDictionary *data) {
        NSLog(@"%@", data);
        [_commentTV.mj_header endRefreshing];
        /*
         防止空数据
         */
        if ([[data objectForKey:@"resCode"] integerValue] == 100) {
            if ([[data objectForKey:@"resDate"] integerValue] == 100) {
        
            }else {
                NSLog(@"%@", [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]);
                /*
                 提起外层数据
                 */
                for (NSDictionary *dict in [WTCJson dictionaryWithJsonString:[data objectForKey:@"resDate"]]) {
                    NSLog(@"%@", dict);
                    /*
                     外层模型赋值
                     */
                    CommentModel *model = [[CommentModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    CommentFrameModel *modelFrame = [[CommentFrameModel alloc] init];
                    modelFrame.contentFrame = CGRectMake(0, 0, 0, [self wtCalculatedHeight:[NSString stringWithFormat:@"%@", model.content]]);
                    /*
                     评论是否带图
                     */
                    if ([NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]].length != 0) {
                        if (KscreeWidth == 320) {
                            modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 50);
                            NSString *str = @",";
                            if ([[NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]] rangeOfString:str].location != NSNotFound) {
                                model.replyImagesArray = [NSMutableArray arrayWithArray:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]] componentsSeparatedByString:@","]];
                            }else {
                                [model.replyImagesArray addObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]]];
                            }
                            switch (model.replyImagesArray.count) {
                                case 1:
                                {
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                }
                                    break;
                                case 2:
                                {
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                    modelFrame.replyImageFrame2 = CGRectMake(52, 0, 50, 50);
                                }
                                    break;
                                case 3:
                                {
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 50, 50);
                                    modelFrame.replyImageFrame2 = CGRectMake(52, 0, 50, 50);
                                    modelFrame.replyImageFrame3 = CGRectMake(104, 0, 50, 50);
                                }
                                    break;
                                    
                                default:
                                    break;
                            }
                        }else {
                            modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 75);
                            NSString *str = @",";
                            if ([[NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]] rangeOfString:str].location != NSNotFound) {
                                model.replyImagesArray = [NSMutableArray arrayWithArray:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]] componentsSeparatedByString:@","]];
                            }else {
                                [model.replyImagesArray addObject:[NSString stringWithFormat:@"%@", [dict objectForKey:@"pictureUrl"]]];
                            }
//                            model.replyImagesArray = [NSMutableArray arrayWithArray:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"picture_url"]] componentsSeparatedByString:@","]];
                            switch (model.replyImagesArray.count) {
                                case 1:
                                {
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                }
                                    break;
                                case 2:
                                {
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(77, 0, 75, 75);

                                }
                                    break;
                                case 3:
                                {
                                    modelFrame.replyImageFrame1 = CGRectMake(0, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(77, 0, 75, 75);
                                    modelFrame.replyImageFrame2 = CGRectMake(154, 0, 75, 75);
                                }
                                    break;
                                    
                                default:
                                    break;
                            }
                        }
                        
                    }else {
                        modelFrame.replyImageFrame = CGRectMake(0, 0, 0, 0);
                    }
                    /*
                     是否有回复
                     */
                    model.iscomment = @"0";
                    if ([NSMutableArray arrayWithArray:[dict objectForKey:@"sonComment"]].count != 0) {
                        /*
                         遍历
                         */
                        model.iscomment = @"1";
                        for (NSDictionary *dictt in [dict objectForKey:@"sonComment"]) {
                            /*
                             评论封装model数组
                             */
                            CommentCellModel *modell = [[CommentCellModel alloc] init];
                            [modell setValuesForKeysWithDictionary:dictt];
                            [self.commentArray addObject:modell];
                            [model.commentArray addObject:modell];
                            /*
                             评论高度封装model数组
                             */
                            CommentCellFrameModel *modelcellFrame = [[CommentCellFrameModel alloc] init];
                            NSString *strr = [NSString stringWithFormat:@"商家回复:%@",[dictt objectForKey:@"content"]];
                            modelcellFrame.cellFrameH = [self wtCalculatedHeight:strr];
                            [self.commentFrameArray addObject:modelcellFrame];
                            [model.commentFrameArray addObject:modelcellFrame];
                            /*
                             计算评论总高度
                             */
                            self.commentTotleH = self.commentTotleH + [self wtCalculatedHeight:[dictt objectForKey:@"content"]] + [self wtCalculatedHeight:@"商家回复:"];
                            modelFrame.replayDownViewFrame = CGRectMake(0, 0, 0, self.commentTotleH);
                            modelFrame.replayTableViewFrame = CGRectMake(0, 0, 0, self.commentTotleH);
                            [self.dataSource addObject:model];
                            [self.frameArray addObject:modelFrame];
                            self.indexPage = model.currentPage.integerValue;

                        }
                        self.commentTotleH = 0;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.commentTV reloadData];
                        });
                    }else {
                        [self.dataSource addObject:model];
                        [self.frameArray addObject:modelFrame];
                        self.indexPage = model.currentPage.integerValue;

                    }
                    
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.commentTV reloadData];
                });
                
            }
        }else {
            [CMMUtility showFailureWith:[NSString stringWithFormat:@"%@", [data objectForKey:@"resMsg"]]];
        }

    } failure:^(NSError *error) {
        NSLog(@"%@", error.userInfo);
        [CMMUtility showFailureWith:@"服务器故障"];
        [_commentTV.mj_header endRefreshing];
    }];
}
- (void) replyAction:(NSNotification *)notification {
    self.commentId = [notification.userInfo objectForKey:@"commentId"];
    self.toUserID = [notification.userInfo objectForKey:@"touserid"];
    commentView=[[UIView alloc]initWithFrame:CGRectMake(0, KscreeHeight, KscreeWidth, 400)];
    commentView.backgroundColor=[UIColor whiteColor];
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(20, 20, KscreeWidth-40, 70)];
    self.textView.layer.cornerRadius=5;
    self.textView.backgroundColor=[UIColor colorWithHexString:@"#EBEBEB"];
    self.textView.font=[UIFont systemFontOfSize:15];
    
    //    UIButton*sendButton=[[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width-80, 130, 60, 30)];
    //
    //    sendButton.layer.borderColor=[UIColor grayColor].CGColor;
    //    sendButton.layer.borderWidth=1;
    //    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    //    sendButton.tintColor=[UIColor lightGrayColor];
    UIButton*sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setFrame:CGRectMake(KscreeWidth-90, 100, 70, 30)];
    
    sendButton.layer.cornerRadius=3;
    sendButton.layer.borderWidth=1;
    sendButton.layer.borderColor=[UIColor grayColor].CGColor;
    [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    sendButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    
    
    [sendButton addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:self.textView];
    [commentView addSubview:sendButton];
    
    [self.textView becomeFirstResponder];
    
    self.commentW=[[UIWindow alloc]initWithFrame:kScreen_Bounds];
    UIColor*backgroundColorx=[[UIColor blackColor]colorWithAlphaComponent:0.3];
    self.commentW.backgroundColor=backgroundColorx;
    
    UITapGestureRecognizer*touch=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quit)];
    touch.delegate=self;
    [self.commentW addGestureRecognizer:touch];
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:0
                     animations:^{
                         [commentView setFrame:CGRectMake(0, KscreeHeight-400, KscreeWidth, 400)];
                     }
                     completion:nil];
    [self.commentW addSubview:commentView];
    [self.commentW makeKeyAndVisible];
    [UIView setAnimationsEnabled:YES];

}
-(void)send:(id)idd
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:[NSString stringWithFormat:@"%@", self.commentId] forKey:@"commentId"];
    [dict setObject:[NSString stringWithFormat:@"%@", self.textView.text] forKey:@"content"];
    [dict setObject:@"" forKey:@"pictureUrl"];
    [dict setObject:[NSString stringWithFormat:@"%@", self.toUserID] forKey:@"toUserId"];
    NSMutableDictionary *outDict = [self makeDict];
    [outDict setObject:[WTCJson dictionaryToJson:dict] forKey:@"postDate"];
    [WTNewRequest postWithURLString:[self createRequestUrl:Revertcomment] parameters:outDict success:^(NSDictionary *data) {
        [self quit];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestData];
            [self.commentTV reloadData];
        });
    } failure:^(NSError *error) {
        [CMMUtility showFailureWith:@"网络故障"];
    }];
    
}
-(void)quit
{
    [self.textView resignFirstResponder];
    [self.commentW resignKeyWindow];
    self.commentW.hidden=YES;
    [UIView setAnimationsEnabled:YES];
    
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
    /*
     判断参数 控制外层height
     */
    if (frameModel.replyImageFrame.size.height >= 50) {
        //有图
        if (KscreeWidth == 320) {
            //5S
            if (frameModel.replayDownViewFrame.size.height == 0) {
                //无评论
                return 70 + 24 + 10 - 44 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 50;

            }else {
                //有评论
                return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 50;

            }
            
        }else {
            //678
            if (frameModel.replayDownViewFrame.size.height == 0) {
                return 70 + 24 + 10 - 44 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 75;

            }else {
                return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height + 75;

            }
            
        }
    }else {
        //无图
            return 70 + 24 + 10 + frameModel.contentFrame.size.height + 90 + frameModel.replayTableViewFrame.size.height - 40 - 10;
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
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self hideTabBar];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self showTabBar];
    [super viewWillDisappear:animated];
}
#pragma mark - LMJKeyboardShowHiddenNotificationCenterDelegate, UITextFieldDelegate
//- (void)showOrHiddenKeyboardWithHeight:(CGFloat)height withDuration:(CGFloat)animationDuration isShow:(BOOL)isShow {
//    [UIView animateWithDuration:animationDuration animations:^{
//        [self.replyTF setFrame:CGRectMake(self.replyTF.frame.origin.x, self.replyTF.frame.origin.y - height, self.replyTF.frame.size.width, self.replyTF.frame.size.height)];
//    }];
//}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}
//- (void)viewWillAppear:(BOOL)animated {
//    [LMJKeyboardShowHiddenNotificationCenter defineCenter].delegate = self;
//}
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
