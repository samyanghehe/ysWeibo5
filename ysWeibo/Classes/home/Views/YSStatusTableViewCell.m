//
//  YSStatusTableViewCell.m
//  ysWeibo
//
//  Created by ys on 15/12/4.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSStatusTableViewCell.h"
#import "YSStatus.h"
#import "YSStatusFrame.h"
#import "YSUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+YS.h"

@interface YSStatusTableViewCell ()

//自己微博的控件
/** 顶部的view */
@property (nonatomic,weak)UIImageView *topView;
/** 头像的view */
@property (nonatomic,weak)UIImageView *iconView;
/** 会员的view */
@property (nonatomic,weak)UIImageView *vipView;
/** 配图的view */
@property (nonatomic,weak)UIImageView *photoView;
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
@property (nonatomic,weak)UIImageView *retweetView;
/** 昵称的label */
@property (nonatomic,weak)UILabel *retweetNameLabel;
/** 正文的label */
@property (nonatomic,weak)UILabel *retweetContentLabel;
/** 配图的view */
@property (nonatomic,weak)UIImageView *retweetPhotoView;

//每条微博底部的工具条
/** 配图的view */
@property (nonatomic,weak)UIImageView *toolBarView;

@end

@implementation YSStatusTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"status";
    YSStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YSStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
        return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加原创微博内部的子控件
        [self setupOriginalSubviews];
        //添加被转发微博内部的子控件
//        [self setupRetweetSubviews];
        //添加工具条子控件
//        [self setupStatusToolBarSubviews];
    }
    return self;
}
//添加原创微博内部的子控件
-(void)setupOriginalSubviews
{
    /** 顶部的view */
    UIImageView *topView = [[UIImageView alloc]init];
    [self.contentView addSubview:topView];
    //topView.backgroundColor = [UIColor blackColor];
    self.topView = topView;
    
    /** 头像的view */
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.backgroundColor = [UIColor grayColor];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    /** 会员的view */
    UIImageView *vipView = [[UIImageView alloc]init];
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    /** 配图的view */
    UIImageView *photoView = [[UIImageView alloc]init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    /** 昵称的label */
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = YSStatusNameFont;
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间的label */
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = YSStatusTimeFont;
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;

    /** 来源的label */
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = YSStatusSourceFont;
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文的label */
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = YSStatusContentFont;
    contentLabel.numberOfLines = 0;
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
}
//添加被转发微博内部的子控件
-(void)setupRetweetSubviews
{
    /** 父view */
    UIImageView *retweetView = [[UIImageView alloc]init];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 昵称的label */
    UILabel *retweetNameLabel = [[UILabel alloc]init];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    /** 正文的label */
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 配图的view */
    UIImageView *retweetPhotoView = [[UIImageView alloc]init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}
//添加工具条子控件
-(void)setupStatusToolBarSubviews
{
    /** 配图的view */
    UIImageView *toolBarView = [[UIImageView alloc]init];
    [self.contentView addSubview:toolBarView];
    self.toolBarView = toolBarView;
}

-(void)setStatusFrame:(YSStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    //添加原创微博
    [self setupOriginalData];
    //添加被转发微博
//    [self setupRetweetData];
    //添加工具条子控件
//    [self setupStatusToolBarData];
}
//添加原创微博
-(void)setupOriginalData
{
    YSStatus *status = self.statusFrame.status;
    YSUser *user = status.user;
    //1.topView
    self.topView.frame = _statusFrame.topViewF;
    //2.头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    //3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    //4.VIP
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:@"common_icon_membership"];
        self.vipView.frame = self.statusFrame.vipViewF;
        
    }else{
        self.vipView.hidden = YES;
    }
    // 5.时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = self.statusFrame.timeLabelF;
    
    // 6.来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;

}

//添加被转发微博
-(void)setupRetweetData
{
    
}
@end
