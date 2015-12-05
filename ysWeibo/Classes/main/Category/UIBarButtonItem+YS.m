//
//  UIBarButtonItem+YS.m
//  ysWeibo
//
//  Created by ys on 15/12/1.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "UIBarButtonItem+YS.h"
#import "UIImage+YS.h"
@implementation UIBarButtonItem (YS)

+(UIBarButtonItem *)barButtonItemWithNormalImage:(NSString *)NormalImage HighlightedImage:(NSString *)HighlightedImage addTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:NormalImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:HighlightedImage] forState:UIControlStateHighlighted];
    button.bounds = CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
