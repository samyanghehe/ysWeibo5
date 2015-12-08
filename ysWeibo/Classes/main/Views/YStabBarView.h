//
//  YStabBarView.h
//  ysWeibo
//
//  Created by ys on 15/11/29.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YStabBarView;
@protocol YStabBarViewDelegate<NSObject>
@optional

-(void)tabBarView:(YStabBarView *)tabBarView DidSelectedButtonFrom:(int)from to:(int)to;
-(void)tabBarViewDidClickPlusButton:(YStabBarView *)tabBarView;
@end

@interface YStabBarView : UIView

@property(nonatomic,weak)id<YStabBarViewDelegate>delegate;

-(void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
