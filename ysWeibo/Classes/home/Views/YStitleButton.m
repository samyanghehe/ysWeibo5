//
//  YStitleButton.m
//  ysWeibo
//
//  Created by ys on 15/12/1.
//  Copyright (c) 2015年 ys. All rights reserved.
//
#define YStitleButtonImageW 20
#import "YStitleButton.h"
#import "UIImage+YS.h"
@interface YStitleButton()
@end

@implementation YStitleButton

+(instancetype)titleButton
{
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setTitle:@"用户名" forState:UIControlStateNormal];
    }
    
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = contentRect.size.width - YStitleButtonImageW;
    CGFloat imageY = 0;
    CGFloat imageW = YStitleButtonImageW;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - YStitleButtonImageW;
    CGFloat titleH = contentRect.size.height;


    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
