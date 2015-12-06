//
//  YSPhotoView.m
//  ysWeibo
//
//  Created by ys on 15/12/6.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSPhotoView.h"
#import "YSPhoto.h"
#import "UIImageView+WebCache.h"
#import "UIImage+YS.h"

@interface YSPhotoView()

@property(nonatomic,weak)UIImageView *gifImageView;

@end



@implementation YSPhotoView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UIImageView *gifView = [[UIImageView alloc]init];
//        gifView.image = [UIImage imageWithName:@"timeline_image_gif"];
//        [self addSubview:gifView];
//        self.gifImageView = gifView;
        UIImage *image = [[UIImage alloc]init];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifImageView = gifView;
    }
    
    return self;
}

-(void)setPhoto:(YSPhoto *)photo
{
    _photo = photo;
//    self.gifImageView.hidden = ![photo.thumbnail_pic hasSuffix:@".jpg"];
    self.gifImageView.hidden = NO;
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.gifImageView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifImageView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}
@end
