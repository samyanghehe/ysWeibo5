//
//  YSHomeStatusResult.h
//  ysWeibo
//
//  Created by ys on 15/12/9.
//  Copyright (c) 2015年 ys. All rights reserved.
//
//"total_number": 81655
#import <Foundation/Foundation.h>

@interface YSHomeStatusResult : NSObject

/**
 *  数组中N个封装微博数据
 */
@property (nonatomic,strong)NSArray *statuses;


@end
