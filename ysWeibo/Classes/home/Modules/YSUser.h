//
//  YSUser.h
//  ysWeibo
//
//  Created by ys on 15/12/3.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSUser : NSObject
/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;
/**
 *  用户是否为vip
 */
@property (nonatomic, assign, getter=isVip) BOOL vip;


@end
