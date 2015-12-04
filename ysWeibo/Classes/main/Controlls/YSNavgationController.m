//
//  YSNavgationController.m
//  ysWeibo
//
//  Created by ys on 15/12/1.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSNavgationController.h"
#import "UIImage+YS.h"
@implementation YSNavgationController

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

+(void)initialize
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    [item setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [item setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[UITextAttributeTextColor] = [UIColor orangeColor];
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    dict2[UITextAttributeTextColor] = [UIColor grayColor];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:dict2 forState:UIControlStateDisabled];
    [item setTitleTextAttributes:dict forState:UIControlStateHighlighted];
}
@end
