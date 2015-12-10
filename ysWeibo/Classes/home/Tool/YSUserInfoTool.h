//
//  YSUserInfoTool.h
//  ysWeibo
//
//  Created by ys on 15/12/10.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSUserInfoResult.h"
#import "YSUserInfoParam.h"
@interface YSUserInfoTool : NSObject

+(void)userInfoWithParam:(YSUserInfoParam *)param success:(void(^)(YSUserInfoResult *result))success failure:(void(^)(NSError *error))failure;

@end
