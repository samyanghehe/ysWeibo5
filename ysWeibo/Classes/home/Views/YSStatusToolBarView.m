//
//  YSStatusToolBarView.m
//  ysWeibo
//
//  Created by ys on 15/12/5.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSStatusToolBarView.h"
#import "UIImage+YS.h"
#import "YSStatus.h"

@interface YSStatusToolBarView()
@property(nonatomic,strong)NSMutableArray *btns;
@property(nonatomic,strong)NSMutableArray *dividers;
@property(nonatomic,weak)UIButton * retweetBtn;
@property(nonatomic,weak)UIButton * commentBtn;
@property(nonatomic,weak)UIButton * attitudeBtn;
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
        self.retweetBtn = [self setupButtonWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        self.commentBtn = [self setupButtonWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        self.attitudeBtn = [self setupButtonWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

-(UIButton *)setupButtonWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
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
    return button;
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
//        NSLog(@"%@",NSStringFromCGRect(button.frame));
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

-(void)setStatus:(YSStatus *)status
{
    _status = status;
    [self setupButton:self.retweetBtn title:@"转发" count:self.status.reposts_count];
    [self setupButton:self.commentBtn title:@"评论" count:self.status.comments_count];
    [self setupButton:self.attitudeBtn title:@"呵呵" count:self.status.attitudes_count];
}

-(void)setupButton:(UIButton *)button title:(NSString *)title count:(int)count
{
    if (count) {
        [button setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
    } else {
        [button setTitle:title forState:UIControlStateNormal];
    }
}
@end
