//
//  YSStatusTableViewCell.m
//  ysWeibo
//
//  Created by ys on 15/12/4.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSStatusTableViewCell.h"

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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加原创微博内部的子控件
        [self setupOriginalSubviews];
        //添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        //添加工具条子控件
        [self setupStatusToolBarSubviews];
    }
    
    return self;
}
//添加原创微博内部的子控件
-(void)setupOriginalSubviews
{
    /** 顶部的view */
    UIImageView *topView = [[UIImageView alloc]init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    /** 头像的view */
    UIImageView *iconView = [[UIImageView alloc]init];
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
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间的label */
    UILabel *timeLabel = [[UILabel alloc]init];
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;

    /** 来源的label */
    UILabel *sourceLabel = [[UILabel alloc]init];
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文的label */
    UILabel *contentLabel = [[UILabel alloc]init];
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

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
