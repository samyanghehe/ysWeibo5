//
//  YSsearchBar.m
//  ysWeibo
//
//  Created by ys on 15/12/1.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSsearchBar.h"
#import "UIImage+YS.h"
@implementation YSsearchBar

+(instancetype)searchBar
{
        return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.background = [UIImage resizeImageWithName:@"searchbar_textfield_background"];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageWithName:@"searchbar_textfield_search_icon"];
    imageView.contentMode = UIViewContentModeCenter;
    self.leftView = imageView;
    self.font = [UIFont systemFontOfSize:15];
    //    searchBar.placeholder = @"搜索";
    self.clearButtonMode = UITextFieldViewModeAlways;
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索" attributes:attr];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.returnKeyType = UIReturnKeySearch;
    self.enablesReturnKeyAutomatically = YES;
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftView.frame = CGRectMake(0, 0,30, self.frame.size.height);
}
@end
