//
//  YSHomeViewController.m
//  ysWeibo
//
//  Created by ys on 15/11/29.
//  Copyright (c) 2015年 ys. All rights reserved.
//
// 2.获得RGB颜色

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
#import "YSStatusFrame.h"
#import "YSStatusTableViewCell.h"
#import "MJRefresh.h"
#import "defineFile.h"

static const CGFloat MJDuration = 2.0;

@interface YShomeViewController()
@property(nonatomic,strong)YStitleButton *titleButton;
@property(nonatomic,strong)NSMutableArray *statuseFrames;
@end
@implementation YShomeViewController

-(NSMutableArray *)statuseFrames
{
    if (_statuseFrames == nil) {
        _statuseFrames = [NSMutableArray array];
    }
    return _statuseFrames;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupRefresh];
    [self setupNavBar];
    [self setupUserName];
}

-(void)setupUserName
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    YSaccount *account = [YSaccountTool account];
    
    param[@"access_token"] = account.access_token;

    param[@"uid"] = @(account.uid);
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        YSUser *user = [YSUser mj_objectWithKeyValues:responseObject];
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
-(void)setupRefresh
{
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    [refresh addTarget:self action:@selector(refreshControlValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    [self refreshControlValueChange:refresh];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self loadMoreData];
    }];
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    // 1.添加假数据
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    YSaccount *account = [YSaccountTool account];
    
    param[@"access_token"] = account.access_token;
    param[@"count"] = @5;
    if (self.statuseFrames.count) {
        YSStatusFrame *statusFrame = [self.statuseFrames lastObject];
        long long idstring = [statusFrame.status.idstr longLongValue] - 1;
        param[@"max_id"] = @(idstring);
    }
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dictArray = responseObject[@"statuses"];
        //NSLog(@"%@",responseObject[@"statuses"]);
        //高级技术.运行时.字典转模型
        NSArray *statusArray = [YSStatus mj_objectArrayWithKeyValuesArray:dictArray];
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (YSStatus *status in statusArray) {
            YSStatusFrame *statusFrame = [[YSStatusFrame alloc]init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        NSMutableArray *temp = _statuseFrames;
        [temp addObjectsFromArray:statusFrameArray];
        _statuseFrames = temp;
        
        [self.tableView reloadData];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.mj_footer endRefreshing];
        [self showTipsWithStatusCount:statusArray.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)refreshFooter
{
    NSLog(@"footer");
}

-(void)refreshControlValueChange:(UIRefreshControl *)refresh
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    YSaccount *account = [YSaccountTool account];
    
    param[@"access_token"] = account.access_token;
    param[@"count"] = @5;
    if (self.statuseFrames.count) {
        YSStatusFrame *statusFrame = self.statuseFrames[0];
        param[@"since_id"] = statusFrame.status.idstr;
    }
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dictArray = responseObject[@"statuses"];
        //NSLog(@"%@",responseObject[@"statuses"]);
        //高级技术.运行时.字典转模型
        NSArray *statusArray = [YSStatus mj_objectArrayWithKeyValuesArray:dictArray];
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (YSStatus *status in statusArray) {
            YSStatusFrame *statusFrame = [[YSStatusFrame alloc]init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        [statusFrameArray addObjectsFromArray:_statuseFrames];
        _statuseFrames = statusFrameArray;
        
        [self.tableView reloadData];
        [refresh endRefreshing];
        [self showTipsWithStatusCount:statusArray.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [refresh endRefreshing];
    }];

}

-(void)showTipsWithStatusCount:(int)count
{
    UIButton *tipBtn = [[UIButton alloc]init];
    [self.navigationController.view insertSubview:tipBtn belowSubview:self.navigationController.navigationBar];
    CGFloat tipBtnX = 30;
    CGFloat tipBtnH = 30;
    CGFloat tipBtnY = CGRectGetMaxY(self.navigationController.navigationBar.frame) - tipBtnH;
    CGFloat tipBtnW = self.navigationController.view.frame.size.width - 2*tipBtnX;
    tipBtn.frame = CGRectMake(tipBtnX, tipBtnY, tipBtnW, tipBtnH);
    [tipBtn setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.8]];
    [tipBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    if (count>0) {
        NSString *title = [NSString stringWithFormat:@"%d条新微博",count];
        [tipBtn setTitle:title forState:UIControlStateNormal];
    } else {
        [tipBtn setTitle:@"没有新微博" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.5 animations:^{
        tipBtn.transform = CGAffineTransformMakeTranslation(0, tipBtnH +2);
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:0.5 delay:1.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            tipBtn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [tipBtn removeFromSuperview];
        }];
    }];
}

-(void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithNormalImage:@"navigationbar_friendsearch" HighlightedImage:@"navigationbar_friendsearch_highlighted" addTarget:self action:@selector(leftItemClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithNormalImage:@"navigationbar_pop" HighlightedImage:@"navigationbar_pop_highlighted" addTarget:self action:@selector(pop)];
    
    YStitleButton *titleButton = [YStitleButton titleButton];
    titleButton.frame = CGRectMake(0, 0, 0, 30);
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
     self.tableView.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
    [titleButton addTarget:self action:@selector(changeTitleImage:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return self.statuseFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSStatusTableViewCell *cell = [YSStatusTableViewCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statuseFrames[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSStatusFrame *statusFrame = self.statuseFrames[indexPath.row];
    return statusFrame.cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
