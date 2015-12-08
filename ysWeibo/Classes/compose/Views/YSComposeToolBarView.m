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
    }
    return self;
}

@end
