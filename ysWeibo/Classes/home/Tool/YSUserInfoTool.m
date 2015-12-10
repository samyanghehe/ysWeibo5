//
//  YSUserInfoTool.m
//  ysWeibo
//
//  Created by ys on 15/12/10.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSUserInfoTool.h"
#import "YSHttpTool.h"
#import "MJExtension.h"

@implementation YSUserInfoTool

+(void)userInfoWithParam:(YSUserInfoParam *)param success:(void (^)(YSUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [YSHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:param.mj_keyValues success:^(id json) {
        if (success) {
            YSUserInfoResult *result = [YSUserInfoResult mj_objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
