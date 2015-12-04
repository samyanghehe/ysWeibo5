//
//  YSStatusFrame.h
//  ysWeibo
//
//  Created by ys on 15/12/4.
//  Copyright (c) 2015年 ys. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@class YSStatus;

/** 昵称的字体 */
#define YSStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define YSRetweetNameFont YSStatusNameFont
/** 时间的字体 */
#define YSStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define YSStatusSourceFont YSStatusTimeFont
/** 正文的字体 */
#define YSStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define YSRetweetContentFont YSStatusContentFont
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
@property (nonatomic,assign ,readonly)CGRect photoViewF;
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
@property (nonatomic,assign ,readonly)CGRect retweetPhotoViewF;

//每条微博底部的工具条
/** 配图的view */
@property (nonatomic,assign ,readonly)CGRect toolBarViewF;
/** cell的高度 */
@property (nonatomic,assign ,readonly)CGFloat cellHeight;

@end
