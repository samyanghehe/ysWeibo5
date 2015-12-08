//
//  YSComposeToolBarView.m
//  ysWeibo
//
//  Created by ys on 15/12/8.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSComposeToolBarView.h"
#import "UIImage+YS.h"

@implementation YSComposeToolBarView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:ComposeToolBarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:ComposeToolBarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:ComposeToolBarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:ComposeToolBarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:ComposeToolBarButtonTypeEmotion];
        
    }
    return self;
}

-(void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(int)tag
{
    UIButton *btn = [[UIButton alloc]init];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    btn.tag = tag;
    [self addSubview:btn];
}

-(void)buttonClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolBarView:DidClickedWithType:)]) {
        [self.delegate composeToolBarView:self DidClickedWithType:btn.tag];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW = self.frame.size.width/5;
    CGFloat btnY = 0;
    CGFloat btnH = self.frame.size.height;
    for (int i = 0 ;i < 5; i++) {
        UIButton *btn = self.subviews[i];
        
        CGFloat btnX = i*btnW;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}

@end
