//
//  YSStatusToolBarView.m
//  ysWeibo
//
//  Created by ys on 15/12/5.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSStatusToolBarView.h"
#import "UIImage+YS.h"

@interface YSStatusToolBarView()
@property(nonatomic,strong)NSMutableArray *btns;
@property(nonatomic,strong)NSMutableArray *dividers;
@end
@implementation YSStatusToolBarView


-(NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
-(NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage resizeImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_bottom_background_highlighted"];
        [self setupButtonWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        [self setupButtonWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        [self setupButtonWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

-(void)setupButtonWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:bgImage] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:button];
    [self.btns addObject:button];
}

-(void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    divider.contentMode = UIViewContentModeCenter;
    [self addSubview:divider];
    [self.dividers addObject:divider];
}
-(void)layoutSubviews
{   
    [super layoutSubviews];
    NSInteger btnCount = self.btns.count;
    self.userInteractionEnabled = YES;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width/btnCount;
    CGFloat buttonH = self.frame.size.height;
    
    for (int index = 0; index<btnCount; index++) {
        UIButton *button = self.btns[index];
        CGFloat buttonX = index * buttonW;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        NSLog(@"%@",NSStringFromCGRect(button.frame));
    }
    NSInteger dividerCount = self.dividers.count;
    for (int index =0; index<dividerCount; index++) {
        UIImageView *divider = self.dividers[index];
        
        CGFloat dividerY = 0;
        CGFloat dividerW = 3;
        CGFloat dividerH = self.frame.size.height;
        CGFloat dividerX = (index+1) *buttonW;
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}
@end
