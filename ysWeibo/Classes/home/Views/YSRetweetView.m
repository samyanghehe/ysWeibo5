//
//  YSRetweetView.m
//  ysWeibo
//
//  Created by ys on 15/12/5.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSRetweetView.h"
#import "UIImage+YS.h"
#import "YSStatus.h"
#import "YSUser.h"
#import "YSStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "YSPhoto.h"
#import "YSPhotosView.h"
@implementation YSRetweetView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage resizeImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        /** 昵称的label */
        UILabel *retweetNameLabel = [[UILabel alloc]init];
        [self addSubview:retweetNameLabel];
        retweetNameLabel.font = YSRetweetNameFont;
        retweetNameLabel.textColor = [UIColor colorWithRed:0/255.0 green:30/255.0 blue:250/255.0 alpha:1.0];
        self.retweetNameLabel = retweetNameLabel;
        
        /** 正文的label */
        UILabel *retweetContentLabel = [[UILabel alloc]init];
        
        retweetContentLabel.font = YSRetweetContentFont;
        [self addSubview:retweetContentLabel];
        retweetContentLabel.numberOfLines = 0;
        self.retweetContentLabel = retweetContentLabel;
        
        /** 配图的view */
        YSPhotosView *retweetPhotosView = [[YSPhotosView alloc]init];
        [self addSubview:retweetPhotosView];
        self.retweetPhotosView = retweetPhotosView;
    }
    
    return self;
}


-(void)setStatusFrame:(YSStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    YSStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    YSUser *retweetUser = retweetStatus.user;
    //3.昵称
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",retweetUser.name];
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
    
    // 7.正文
    self.retweetContentLabel.text = retweetStatus.text;
    //        NSLog(@"%@",retweetStatus.text);
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
    
    // 8.配图
    if(retweetStatus.pic_urls.count){
        //            NSLog(@"%@",retweetStatus.thumbnail_pic);
        self.retweetPhotosView.hidden = NO;
        self.retweetPhotosView.frame = self.statusFrame.retweetPhotosViewF;
        self.retweetPhotosView.photos = retweetStatus.pic_urls;
    }else{
        self.retweetPhotosView.hidden = YES;
    }
}
@end
