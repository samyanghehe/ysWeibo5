//
//  YSStatusTopView.m
//  ysWeibo
//
//  Created by ys on 15/12/5.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSStatusTopView.h"
#import "YSStatus.h"
#import "YSStatusFrame.h"
#import "YSUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+YS.h"
#import "YSRetweetView.h"
#import "YSPhoto.h"
#import "YSPhotosView.h"
@interface YSStatusTopView()

/** 头像的view */
@property (nonatomic,weak)UIImageView *iconView;
/** 会员的view */
@property (nonatomic,weak)UIImageView *vipView;
/** 配图的view */
@property (nonatomic,weak)YSPhotosView *photosView;
/** 昵称的label */
@property (nonatomic,weak)UILabel *nameLabel;
/** 发表时间的label */
@property (nonatomic,weak)UILabel *timeLabel;
/** 来源的label */
@property (nonatomic,weak)UILabel *sourceLabel;
/** 正文的label */
@property (nonatomic,weak)UILabel *contentLabel;
//被转发微博的控件
/** 下面三个view的父view,要添加到自己微博的控件topView */
@property (nonatomic,weak)YSRetweetView *retweetView;

@end


@implementation YSStatusTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
        self.image = [UIImage resizeImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_top_background_highlighted"];
        self.backgroundColor = [UIColor clearColor];
        /** 头像的view */
        UIImageView *iconView = [[UIImageView alloc]init];
        iconView.backgroundColor = [UIColor clearColor];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /** 会员的view */
        UIImageView *vipView = [[UIImageView alloc]init];
        vipView.backgroundColor = [UIColor clearColor];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /** 配图的view */
        YSPhotosView *photosView = [[YSPhotosView alloc]init];
        photosView.backgroundColor = [UIColor clearColor];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        /** 昵称的label */
        UILabel *nameLabel = [[UILabel alloc]init];
        //    nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = YSStatusNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 时间的label */
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor colorWithRed:240/255.0 green:140/255.0 blue:19/255.0 alpha:1.0];
        timeLabel.font = YSStatusTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 来源的label */
        UILabel *sourceLabel = [[UILabel alloc]init];
        sourceLabel.backgroundColor = [UIColor clearColor];
        sourceLabel.font = YSStatusSourceFont;
        sourceLabel.textColor = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1.0];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 正文的label */
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.font = YSStatusContentFont;
        contentLabel.textColor = [UIColor colorWithRed:35/255.0 green:35/255.0 blue:35/255.0 alpha:1.0];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        /** 父view */
        YSRetweetView *retweetView = [[YSRetweetView alloc]init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;

    }
    return self;
}

-(void)setStatusFrame:(YSStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    YSStatus *status = statusFrame.status;
    YSUser *user = status.user;
    //1.topView
    //self.frame = _statusFrame.topViewF;
    //2.头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    //3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    //4.VIP
    if (user.mbrank) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.vipView.frame = self.statusFrame.vipViewF;
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    
    //    5. /** 发表时间的label */
    //    @property (nonatomic,assign ,readonly)CGRect timeLabelF;
    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + YSStatusCellBorder;
    CGSize timeLabelSize = [status.created_at sizeWithFont:YSStatusTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    //    6. /** 来源的label */
    //    @property (nonatomic,assign ,readonly)CGRect sourceLabelF;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + YSStatusCellBorder;
    CGFloat sourceLabelY = self.timeLabel.frame.origin.y;
    CGSize sourceLabelSize = [status.source sizeWithFont:YSStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 5.时间
    self.timeLabel.text = status.created_at;
//    NSLog(@"%@",status.created_at);
    //self.timeLabel.frame = self.statusFrame.timeLabelF;
    
    // 6.来源
    self.sourceLabel.text = status.source;
    //self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    // 8.配图
    if(status.pic_urls.count){
//        NSLog(@"%d",status.pic_urls.count);
        self.photosView.hidden = NO;
        self.photosView.frame = self.statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
    }else{
//        NSLog(@"-----------");
        self.photosView.hidden = YES;
    }
    
    YSStatus *retweetStatus = status.retweeted_status;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        self.retweetView.statusFrame = self.statusFrame;
    }else{
        self.retweetView.hidden = YES;
    }
    
}

@end
