//
//  YSdiscoverViewController.m
//  ysWeibo
//
//  Created by ys on 15/11/29.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSdiscoverViewController.h"
#import "UIImage+YS.h"
#import "YSsearchBar.h"
@implementation YSdiscoverViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    YSsearchBar *searchBar = [YSsearchBar searchBar];
    searchBar.bounds = CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView = searchBar;

}

@end
