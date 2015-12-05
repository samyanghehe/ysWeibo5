//
//  YSStatusFrame.m
//  ysWeibo
//
//  Created by ys on 15/12/4.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSStatusFrame.h"
#import "YSStatus.h"
#import "YSUser.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@implementation YSStatusFrame
/**
 *  获得微博数据模型status之后根据数据模型算出cell子控件及cell的frame
 */
-(void)setStatus:(YSStatus *)status
{
    _status = status;
    
//    0. cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - YSStatusTableBorder * 2;
    
//    1. /** 顶部的view */
//    @property (nonatomic,assign ,readonly)CGRect topViewF;
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewH = 0;
    
//    2. /** 头像的view */
//    @property (nonatomic,assign ,readonly)CGRect iconViewF;
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = YSStatusCellBorder;
    CGFloat iconViewY = YSStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
//    NSLog(@"%@",NSStringFromCGRect(_iconViewF));
    
    
//    3. /** 昵称的label */
//    @property (nonatomic,assign ,readonly)CGRect nameLabelF;
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + YSStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithFont:YSStatusNameFont];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    
//    4./** 会员的view */
//    @property (nonatomic,assign ,readonly)CGRect vipViewF;
    if (status.user.mbrank) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + YSStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    
//    5. /** 发表时间的label */
//    @property (nonatomic,assign ,readonly)CGRect timeLabelF;
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + YSStatusCellBorder;
    CGSize timeLabelSize = [status.created_at sizeWithFont:YSStatusTimeFont];
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
//    6. /** 来源的label */
//    @property (nonatomic,assign ,readonly)CGRect sourceLabelF;
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + YSStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:YSStatusSourceFont];
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    


//    7. /** 正文的label */
//    @property (nonatomic,assign ,readonly)CGRect contentLabelF;
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF)) + YSStatusCellBorder;
    CGFloat contentLabelMaxW = topViewW - 2 * YSStatusCellBorder;
    CGSize contentLabelSize = [status.text sizeWithFont:YSStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
//    8. /** 配图的view */
//    @property (nonatomic,assign ,readonly)CGRect PhotoViewF;
    if (self.status.thumbnail_pic) {
        CGFloat photoViewWH = 70;
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF)+YSStatusCellBorder;
        _photoViewF = CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH);
    }
    
    if (self.status.retweeted_status) {
        //    9. /** 被转发微博view */
        //    @property (nonatomic,assign ,readonly)CGRect retweetViewF;
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) +YSStatusCellBorder;
        CGFloat retweetViewH = 0;
        
        //    10. /** 被转发微博作者昵称的label */
        //    @property (nonatomic,assign ,readonly)CGRect retweetNameLabelF;
        CGFloat retweetNameLabelX = YSStatusCellBorder;
        CGFloat retweetNameLabelY = YSStatusCellBorder;
        NSString *name = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
        CGSize retweetNameLabelSize = [name sizeWithFont:YSRetweetNameFont];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        //    11. /** 被转发微博正文的label */
        //    @property (nonatomic,assign ,readonly)CGRect retweetContentLabelF;
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + YSStatusCellBorder;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * YSStatusCellBorder;
        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:YSRetweetContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};

        //    812. /** 被转发微博配图的view */
        //    @property (nonatomic,assign ,readonly)CGRect retweetPhotoViewF;
        if (self.status.retweeted_status.thumbnail_pic) {
            CGFloat retweetPhotoViewWH = 70;
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF)+YSStatusCellBorder;
            _retweetPhotoViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewWH, retweetPhotoViewWH);
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF) + YSStatusCellBorder;
        }else{
            retweetViewH =CGRectGetMaxY(_retweetContentLabelF) +YSStatusCellBorder;
        }
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        //有转发微博
        topViewH = CGRectGetMaxY(_retweetViewF) + YSStatusCellBorder;
    }else{//没有转发微博
        if (self.status.thumbnail_pic) {//有配图
            topViewH = CGRectGetMaxY(_photoViewF) + YSStatusCellBorder;
        }else{//没有配图
            topViewH = CGRectGetMaxY(_contentLabelF) +YSStatusCellBorder;
        }
    }
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    CGFloat toolBarViewX = topViewX;
    CGFloat toolBarViewY = CGRectGetMaxY(_topViewF);
    CGFloat toolBarViewW = topViewW;
    CGFloat toolBarViewH = 35;
    _toolBarViewF = CGRectMake(toolBarViewX, toolBarViewY, toolBarViewW, toolBarViewH);
    //cell的高度
    _cellHeight = CGRectGetMaxY(_toolBarViewF) + 15;
////    //被转发微博的控件
////    /** 下面三个view的父view,要添加到自己微博的控件topView */
////    @property (nonatomic,assign ,readonly)CGRect retweetViewF;
//    CGFloat retweetViewX = 0;
//    CGFloat retweetViewY = 0;
//    CGFloat retweetViewW = cellW;
//    CGFloat retweetViewH = 0;
//    _topViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
////    /** 昵称的label */
////    @property (nonatomic,assign ,readonly)CGRect retweetNameLabelF;
//    CGFloat retweetNameLabelX = 0;
//    CGFloat retweetNameLabelY = 0;
//    CGFloat retweetNameLabelW = cellW;
//    CGFloat retweetNameLabelH = 0;
//    _topViewF = CGRectMake(retweetNameLabelX, retweetNameLabelY, retweetNameLabelW, retweetNameLabelH);
////    /** 正文的label */
////    @property (nonatomic,assign ,readonly)CGRect retweetContentLabelF;
//    CGFloat retweetContentLabelX = 0;
//    CGFloat retweetContentLabelY = 0;
//    CGFloat retweetContentLabelW = cellW;
//    CGFloat retweetContentLabelH = 0;
//    _topViewF = CGRectMake(retweetContentLabelX, retweetContentLabelY, retweetContentLabelW, retweetContentLabelH);
////    /** 配图的view */
////    @property (nonatomic,assign ,readonly)CGRect retweetPhotoViewF;
//    CGFloat retweetPhotoViewX = 0;
//    CGFloat retweetPhotoViewY = 0;
//    CGFloat retweetPhotoViewW = cellW;
//    CGFloat retweetPhotoViewH = 0;
//    _topViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewW, retweetPhotoViewH);
////    
////    //每条微博底部的工具条
////    @property (nonatomic,assign ,readonly)CGRect toolBarViewF;
//    CGFloat toolBarViewX = 0;
//    CGFloat toolBarViewY = 0;
//    CGFloat toolBarViewW = cellW;
//    CGFloat toolBarViewH = 0;
//    _topViewF = CGRectMake(toolBarViewX, toolBarViewY, toolBarViewW, toolBarViewH);
    
}


@end
