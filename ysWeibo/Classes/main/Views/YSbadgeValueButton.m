//
//  YSbadgeValueButton.m
//  ysWeibo
//
//  Created by ys on 15/12/1.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSbadgeValueButton.h"
#import "UIImage+YS.h"
@implementation YSbadgeValueButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage resizeImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    if (badgeValue.length>0) {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        CGFloat badgeY = 0;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length>1) {
            CGSize badgeValueSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeValueSize.width +10;
        }
        CGFloat badgeX = 0;
        
        self.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
    }else
    {
        self.hidden = YES;
    }

}
@end
