//
//  YSStatusFrame.h
//  ysWeibo
//
//  Created by ys on 15/12/4.
//  Copyright (c) 2015年 ys. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "defineFile.h"
@class YSStatus;

@interface YSStatusFrame : NSObject

@property (nonatomic,strong)YSStatus *status;
//自己微博的控件
/** 顶部的view */
@property (nonatomic,assign ,readonly)CGRect topViewF;
/** 头像的view */
@property (nonatomic,assign ,readonly)CGRect iconViewF;
/** 会员的view */
@property (nonatomic,assign ,readonly)CGRect vipViewF;
/** 配图的view */
@property (nonatomic,assign ,readonly)CGRect photosViewF;
/** 昵称的label */
@property (nonatomic,assign ,readonly)CGRect nameLabelF;
/** 发表时间的label */
@property (nonatomic,assign ,readonly)CGRect timeLabelF;
/** 来源的label */
@property (nonatomic,assign ,readonly)CGRect sourceLabelF;
/** 正文的label */
@property (nonatomic,assign ,readonly)CGRect contentLabelF;

//被转发微博的控件
/** 下面三个view的父view,要添加到自己微博的控件topView */
@property (nonatomic,assign ,readonly)CGRect retweetViewF;
/** 昵称的label */
@property (nonatomic,assign ,readonly)CGRect retweetNameLabelF;
/** 正文的label */
@property (nonatomic,assign ,readonly)CGRect retweetContentLabelF;
/** 配图的view */
@property (nonatomic,assign ,readonly)CGRect retweetPhotosViewF;

//每条微博底部的工具条
/** 配图的view */
@property (nonatomic,assign ,readonly)CGRect toolBarViewF;
/** cell的高度 */
@property (nonatomic,assign ,readonly)CGFloat cellHeight;

@end
