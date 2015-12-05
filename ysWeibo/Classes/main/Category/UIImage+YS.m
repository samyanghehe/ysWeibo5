//
//  UIImage+YS.m
//  ysWeibo
//
//  Created by ys on 15/11/29.
//  Copyright (c) 2015年 ys. All rights reserved.
//
#define ios7 ( [[UIDevice currentDevice].systemVersion doubleValue]>7.0)
#import "UIImage+YS.h"

@implementation UIImage (YS)
+(UIImage *)imageWithName:(NSString *)name
{
    UIImage *image;
    if (ios7) {
        image = [UIImage imageNamed:[name stringByAppendingString:@"_os7"]];
        if (image == nil) {
            image =[UIImage imageNamed:name];
        }
    }else{
        image = [UIImage imageNamed:name];
    }
    return image;
}

+(UIImage *)resizeImageWithName:(NSString *)name
{
    
    return [self resizeImageWithName:name left:0.5 top:0.5];
}

+(UIImage *)resizeImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageWithName:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
}
@end
