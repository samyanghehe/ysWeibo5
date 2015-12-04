//
//  YSStatus.h
//  ysWeibo
//
//  Created by ys on 15/12/3.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSUser;
@interface YSStatus : NSObject
/**
 *  微博的内容(文字)
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的赞
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  用户的配图
 */
@property (nonatomic, copy) NSString *thumbnail_pic;
/**
 *  发表时间
 */
@property (nonatomic ,copy) NSString *created_at;
/**
 *  微博的作者
 */
@property (nonatomic, strong) YSUser *user;
/**
 *  被转发的微博
 */
@property (nonatomic, strong) YSStatus *retweeted_status;

@end
