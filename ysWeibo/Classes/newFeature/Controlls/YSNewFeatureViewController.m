//
//  YSNewFeatureViewController.m
//  ysWeibo
//
//  Created by ys on 15/12/2.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSNewFeatureViewController.h"
#import "YStabBarController.h"
#import "UIImage+YS.h"
@interface YSNewFeatureViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIPageControl *pageControl;
@end

@implementation YSNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNewFeatureView];
    [self setUpPageControl];
    
}
-(void)setUpNewFeatureView
{
    UIScrollView *newFeatureView = [[UIScrollView alloc]init];
//    newFeatureView.bounces = NO;
    newFeatureView.delegate = self;
    newFeatureView.frame = self.view.bounds;
    newFeatureView.backgroundColor = [UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1.0];
    [self.view addSubview:newFeatureView];
    for (int index = 0; index<3; index++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",index+1];
        imageView.image = [UIImage imageWithName:name];
        imageView.frame = CGRectMake(self.view.bounds.size.width * index, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [newFeatureView addSubview:imageView];
        if (index == 2) {
            [self setUpLastImageView:(UIImageView *)imageView];
        }
    }
    newFeatureView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 0);
    newFeatureView.pagingEnabled = YES;
    newFeatureView.showsHorizontalScrollIndicator = NO;
}

-(void)setUpLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    enterButton.layer.cornerRadius = 4.0;
    enterButton.center = CGPointMake(imageView.frame.size.width*0.5, imageView.frame.size.height*0.6);
    enterButton.bounds = CGRectMake(0, 0, 100, 40);
    enterButton.backgroundColor = [UIColor orangeColor];
    [enterButton setTitle:@"进入围脖" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [enterButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:enterButton];
    
    UIButton *checkButton = [[UIButton alloc]init];
    checkButton.selected = YES;
    checkButton.center = CGPointMake(imageView.frame.size.width*0.5, imageView.frame.size.height*0.5);
    checkButton.bounds = CGRectMake(0, 0, 200, 30);
    [checkButton setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkButton setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    [checkButton setTitle:@"将更新分享给大家" forState:UIControlStateNormal];
    checkButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    checkButton.contentEdgeInsets;
//    checkButton.imageEdgeInsets;
    [checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkButton];
}

-(void)start
{
    self.view.window.rootViewController = [[YStabBarController alloc]init];
}

-(void)checkButtonClick:(UIButton *)checkButton
{
//    if (checkButton.tag == 0) {
//        [checkButton setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateNormal];
//        checkButton.tag =1;
//    }else{
//        [checkButton setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
//        checkButton.tag = 0;
//    }
    checkButton.Selected = !checkButton.isSelected;
}

-(void)setUpPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = 3;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height - 30);
    pageControl.bounds = CGRectMake(0, 0, 50, 10);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPage = scrollView.contentOffset.x * 1.5 / self.view.frame.size.width;
    self.pageControl.currentPage = currentPage;
}
@end
