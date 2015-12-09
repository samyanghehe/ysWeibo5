//
//  YSComposePhotosView.m
//  ysWeibo
//
//  Created by ys on 15/12/9.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSComposePhotosView.h"

@implementation YSComposePhotosView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageW = 70;
    CGFloat imageH = imageW;
    int maxCol = 3;
    CGFloat imageMargin = (self.frame.size.width - imageW * maxCol) / (maxCol + 1);
    for (int i = 0;i<self.subviews.count ;i++) {
        UIImageView *imageView = self.subviews[i];
        CGFloat imageY = (i / maxCol) * (imageH + imageMargin);
        CGFloat imageX = imageMargin + (i % maxCol) * (imageW + imageMargin);
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    }
}

-(void)addPhoto:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    [self addSubview:imageView];
}

-(NSArray *)photos
{
    NSMutableArray *photosArray = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [photosArray addObject:imageView.image];
    }
    return photosArray;
}
@end
