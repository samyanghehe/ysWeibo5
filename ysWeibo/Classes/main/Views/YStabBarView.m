//
//  YStabBarView.m
//  ysWeibo
//
//  Created by ys on 15/11/29.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YStabBarView.h"
#import "UIImage+YS.h"
#import "YStabBarButton.h"
@interface YStabBarView()
@property (nonatomic,strong)NSMutableArray *tabbarButtons;
@property (nonatomic,weak)UIButton *plusButton;
@property (nonatomic,weak)YStabBarButton *selectedButton;
@end

@implementation YStabBarView

-(NSMutableArray *)tabbarButtons
{
    if (_tabbarButtons == nil) {
        _tabbarButtons = [NSMutableArray array];
    }
    return _tabbarButtons;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
    }
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:plusButton];
    self.plusButton = plusButton;
    return self;
}


//
-(void)plusButtonClick
{
    if ([self .delegate respondsToSelector:@selector(tabBarViewDidClickPlusButton:)]) {
        [self.delegate tabBarViewDidClickPlusButton:self];
    }
}
-(void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    YStabBarButton *button = [[YStabBarButton alloc]init];
    button.item = item;
    [self addSubview:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.tabbarButtons addObject:button];
}

-(void)buttonClick:(YStabBarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBarView:DidSelectedButtonFrom:to:)]) {
        [self.delegate tabBarView:self DidSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.plusButton.bounds = CGRectMake( 0, 0, self.plusButton.currentBackgroundImage.size.width, self.plusButton.currentBackgroundImage.size.height);
    self.plusButton.center = CGPointMake(w*0.5, h*0.5);
    for (int index = 0; index<self.tabbarButtons.count; index++) {
        
        YStabBarButton *button =self.tabbarButtons[index];
        if (index == 0) {
            button.selected = YES;
            self.selectedButton = button;
        }
        button.tag = index;
        CGFloat buttonW =  w/ self.subviews.count;
        CGFloat buttonH = h;
        CGFloat buttonX = buttonW * index;
        CGFloat buttonY = 0;
        if (index>1) {
            buttonX +=buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}
@end
