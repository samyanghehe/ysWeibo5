//
//  YStabBarController.m
//  ysWeibo
//
//  Created by ys on 15/11/29.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YStabBarController.h"
#import "YShomeViewController.h"
#import "YSmessageViewController.h"
#import "YSdiscoverViewController.h"
#import "YSmeViewController.h"
#import "UIImage+YS.h"
#import "YStabBarView.h"
#import "YSNavgationController.h"
#import "YSComposeViewController.h"

@interface YStabBarController()<YStabBarViewDelegate>
@property (nonatomic,strong)YStabBarView *customTabBar;
@end
@implementation YStabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setTabBar];
    [self addChildVC];
    
    
}

-(void)tabBarView:(YStabBarView *)tabBarView DidSelectedButtonFrom:(int)from to:(int)to
{
    //NSLog(@"%d---%d",from,to);
    self.selectedIndex = to;
}
-(void)tabBarViewDidClickPlusButton:(YStabBarView *)tabBarView
{
    YSComposeViewController *composeViewController = [[YSComposeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:composeViewController];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}
-(void)setTabBar
{
    YStabBarView *customTabBar = [[YStabBarView alloc]init];
    customTabBar.frame = self.tabBar.bounds;
    //customTabBar.backgroundColor = [UIColor redColor];
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    customTabBar.delegate = self;
}
-(void)addChildVC
{
    YShomeViewController *homeVC = [[YShomeViewController alloc]init];
    homeVC.tabBarItem.badgeValue = @"11";
    [self setChildViewControllerWithVC:homeVC title:@"主页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    YSmessageViewController *messageVC = [[YSmessageViewController alloc]init];
    messageVC.tabBarItem.badgeValue = @"222";
    [self setChildViewControllerWithVC:messageVC title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    YSdiscoverViewController *discoverVC = [[YSdiscoverViewController alloc]init];
    discoverVC.tabBarItem.badgeValue = @"";
    [self setChildViewControllerWithVC:discoverVC title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
     YSmeViewController *meVC = [[YSmeViewController alloc]init];
    meVC.tabBarItem.badgeValue = @"1";
    [self setChildViewControllerWithVC:meVC title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
}
-(void)setChildViewControllerWithVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
//    vc.view.backgroundColor = [UIColor grayColor];
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageWithName:image];
    UIImage * sImage = [UIImage imageWithName:selectedImage];
    vc.tabBarItem.selectedImage = [sImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    YSNavgationController *nav = [[YSNavgationController alloc]initWithRootViewController:vc];
    [self.customTabBar addTabBarButtonWithItem:vc.tabBarItem];
    [self addChildViewController:nav];
    
    
    
}

@end
