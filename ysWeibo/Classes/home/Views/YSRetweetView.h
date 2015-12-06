//
//  YSRetweetView.h
//  ysWeibo
//
//  Created by ys on 15/12/5.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSStatusFrame;
@interface YSRetweetView : UIImageView


/** 昵称的label */
@property (nonatomic,weak)UILabel *retweetNameLabel;
/** 正文的label */
@property (nonatomic,weak)UILabel *retweetContentLabel;
/** 配图的view */
@property (nonatomic,weak)UIImageView *retweetPhotoView;

@property (nonatomic,strong)YSStatusFrame *statusFrame;
@end
