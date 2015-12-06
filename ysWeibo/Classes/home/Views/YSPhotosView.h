//
//  YSPhotosView.h
//  ysWeibo
//
//  Created by ys on 15/12/6.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSPhotosView : UIView

@property (nonatomic,strong)NSArray *photos;

+(CGSize)photosSizeWithPhotosCount:(int)count;

@end
