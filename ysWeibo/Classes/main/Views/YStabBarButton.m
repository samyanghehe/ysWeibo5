//
//  YStabBarButton.m
//  ysWeibo
//
//  Created by ys on 15/11/29.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YStabBarButton.h"
#import "UIImage+YS.h"
#import "YSbadgeValueButton.h"

@interface YStabBarButton()
@property (nonatomic,weak)YSbadgeValueButton *badgeButton;
@end

@implementation YStabBarButton

-(instancetype)initWithFrame:(CGRect)frame
{
     self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        YSbadgeValueButton *badgeButton = [[YSbadgeValueButton alloc]init];
        
        //badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
        badgeButton.hidden = YES;
        badgeButton.userInteractionEnabled = NO;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*0.6);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height*0.6, contentRect.size.width, contentRect.size.height*0.4);
}

-(void)setItem:(UITabBarItem *)item
{
    _item = item;
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
}
-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"badgeValue"];
    [self removeObserver:self forKeyPath:@"title"];
    [self removeObserver:self forKeyPath:@"image"];
    [self removeObserver:self forKeyPath:@"selectedImage"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    //[self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
    self.badgeButton.badgeValue = self.item.badgeValue;
    CGRect frame = self.badgeButton.frame;
    CGFloat badgeButtonX = 40;
    CGFloat badgeButtonY = 5;
    frame.origin.x = badgeButtonX;
    frame.origin.y = badgeButtonY;
    self.badgeButton.frame = frame;
}
@end
