//
//  YSweiboTool.m
//  ysWeibo
//
//  Created by ys on 15/12/3.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSweiboTool.h"
#import "YStabBarController.h"
#import "YSNewFeatureViewController.h"

@implementation YSweiboTool
+(void)chooseRootController
{
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[YStabBarController alloc] init];
    } else { // 新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[YSNewFeatureViewController alloc] init];
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }

}
@end
