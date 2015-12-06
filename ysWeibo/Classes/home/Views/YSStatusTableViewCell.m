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
#import "YSStatusFrame.h"
#import "YSStatusToolBarView.h"
#import "YSRetweetView.h"
#import "YSStatusTopView.h"

@interface YSStatusTableViewCell ()

//自己微博的控件
@property (nonatomic,weak)YSStatusTopView *topView;

//每条微博底部的工具条
@property (nonatomic,weak)YSStatusToolBarView *toolBarView;

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
        //添加工具条子控件
        [self setupStatusToolBarSubviews];
    }
    return self;
}
//添加原创微博内部的子控件
-(void)setupOriginalSubviews
{
    /** 顶部的view */
    YSStatusTopView *topView = [[YSStatusTopView alloc]init];
    
    [self.contentView addSubview:topView];
    self.topView = topView;

   }

////添加工具条子控件
-(void)setupStatusToolBarSubviews
{
    YSStatusToolBarView *toolBarView = [[YSStatusToolBarView alloc]init];
    [self.contentView addSubview:toolBarView];
    self.toolBarView = toolBarView;
}

-(void)setStatusFrame:(YSStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    //添加原创微博
    [self setupOriginalData];
    
    //添加工具条子控件
    [self setupStatusToolBarData];
}
//添加原创微博
-(void)setupOriginalData
{
    self.topView.frame = self.statusFrame.topViewF;
    self.topView.statusFrame = self.statusFrame;
    
}


//添加工具条子控件
-(void)setupStatusToolBarData
{
    self.toolBarView.frame = self.statusFrame.toolBarViewF;
    self.toolBarView.status = self.statusFrame.status;
    
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = YSStatusTableBorder;
    frame.size.width -= 2 * YSStatusTableBorder;
    frame.size.height -= 15;
    frame.origin.y += 5;
    
    [super setFrame:frame];
}
@end
