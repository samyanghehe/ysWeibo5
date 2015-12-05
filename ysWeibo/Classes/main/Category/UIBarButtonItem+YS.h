//
//  UIBarButtonItem+YS.h
//  ysWeibo
//
//  Created by ys on 15/12/1.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YS)
+(UIBarButtonItem *)barButtonItemWithNormalImage:(NSString *)NormalImage HighlightedImage:(NSString *)HighlightedImage addTarget:(id)target action:(SEL)action;
@end
