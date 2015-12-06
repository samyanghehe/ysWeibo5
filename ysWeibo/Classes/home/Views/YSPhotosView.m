//
//  YSPhotosView.m
//  ysWeibo
//
//  Created by ys on 15/12/6.
//  Copyright (c) 2015年 ys. All rights reserved.
//
#define IWPhotoW 70
#define IWPhotoH 70
#define IWPhotoMargin 10
#import "YSPhotosView.h"
#import "YSPhotoView.h"
@implementation YSPhotosView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i<9; i++) {
            YSPhotoView *photoView = [[YSPhotoView alloc]init];
            
            [self addSubview:photoView];
        }
    }
    return self;
}

-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    for (int i = 0; i<self.subviews.count; i++) {
        
        YSPhotoView *photoView = self.subviews[i];
        if (i<photos.count) {
            photoView.hidden = NO;
            photoView.photo =photos[i];
            
            // 设置子控件的frame
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int col = i % maxColumns;
            int row = i / maxColumns;
            CGFloat photoX = col * (IWPhotoW + IWPhotoMargin);
            CGFloat photoY = row * (IWPhotoH + IWPhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, IWPhotoW, IWPhotoH);
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            }else{
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        }else{
            photoView.hidden = YES;
        }
    }
}

+(CGSize)photosSizeWithPhotosCount:(int)count
{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * IWPhotoH + (rows - 1) * IWPhotoMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * IWPhotoW + (cols - 1) * IWPhotoMargin;
    
    return CGSizeMake(photosW, photosH);

}

@end
