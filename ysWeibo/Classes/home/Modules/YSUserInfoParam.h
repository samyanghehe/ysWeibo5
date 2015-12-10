//
//  YSUserInfoParam.h
//  ysWeibo
//
//  Created by ys on 15/12/10.
//  Copyright (c) 2015年 ys. All rights reserved.
//
//access_token 	false 	string 	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
//uid 	false 	int64 	需要查询的用户ID。
#import <Foundation/Foundation.h>

@interface YSUserInfoParam : NSObject

@property (nonatomic,copy)NSString *access_token;

@property (nonatomic,assign)long long uid;


@end
