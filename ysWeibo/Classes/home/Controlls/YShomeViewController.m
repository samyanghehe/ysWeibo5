//
//  YSHomeViewController.m
//  ysWeibo
//
//  Created by ys on 15/11/29.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSHomeViewController.h"
#import "UIImage+YS.h"
#import "UIBarButtonItem+YS.h"
#import "YStitleButton.h"
#import "AFNetworking.h"
#import "YSaccountTool.h"
#import "YSaccount.h"
#import "UIImageView+WebCache.h"
#import "YSStatus.h"
#import "YSUser.h"
#import "MJExtension.h"
@interface YShomeViewController()
@property(nonatomic,strong)NSArray *statuses;
@end
@implementation YShomeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNavBar];
    [self setUpWeiboList];
    
}
-(void)setUpWeiboList
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    YSaccount *account = [YSaccountTool account];
    
    param[@"access_token"] = account.access_token;
//    param[@"count"] = @99;
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dictArray = responseObject[@"statuses"];
        
        //高级技术.运行时.字典转模型
        self.statuses = [YSStatus mj_objectArrayWithKeyValuesArray:dictArray];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];
}
-(void)setUpNavBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithNormalImage:@"navigationbar_friendsearch" HighlightedImage:@"navigationbar_friendsearch_highlighted" addTarget:self action:@selector(leftItemClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithNormalImage:@"navigationbar_pop" HighlightedImage:@"navigationbar_pop_highlighted" addTarget:self action:@selector(pop)];
    
    YStitleButton *titleButton = [YStitleButton titleButton];
    titleButton.frame = CGRectMake(0, 0, 80, 30);
    
    [titleButton addTarget:self action:@selector(changeTitleImage:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}
-(void)changeTitleImage:(YStitleButton *)button
{
    if (button.tag ==-1) {
        [button setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        button.tag = 0;
    } else {
        [button setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        button.tag = -1;
    }
}

-(void)leftItemClick
{
    NSLog(@"dddd");
}

-(void)pop
{
    NSLog(@"pppp");
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"home";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    YSStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    YSUser *user = status.user;
    cell.detailTextLabel.text = user.name;
    NSURL *iconUrl = [NSURL URLWithString:user.profile_image_url];
    [cell.imageView setImageWithURL:iconUrl placeholderImage:[UIImage imageWithName:@"tabbar_compose_button"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
