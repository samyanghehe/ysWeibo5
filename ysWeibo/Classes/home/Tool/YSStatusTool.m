//
//  YSStatusTool.m
//  ysWeibo
//
//  Created by ys on 15/12/9.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSStatusTool.h"
#import "YSHttpTool.h"
#import "YSHomeStatusParam.h"
#import "MJExtension.h"
@implementation YSStatusTool

+(void)homeStatusWithParam:(YSHomeStatusParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [YSHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
