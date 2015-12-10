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
#import "YSHomeStatusResult.h"
@implementation YSStatusTool

+(void)homeStatusWithParam:(YSHomeStatusParam *)param success:(void (^)(YSHomeStatusResult *))success failure:(void (^)(NSError *))failure
{
    [YSHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.mj_keyValues success:^(id json) {
        if (success) {
            YSHomeStatusResult *result = [YSHomeStatusResult mj_objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+(void)sendStatusWithParam:(YSSendStatusParam *)param success:(void (^)(YSSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [YSHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:param.mj_keyValues success:^(id json) {
        if (success) {
            YSSendStatusResult *result = [YSSendStatusResult mj_objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)sendStatusWithParam:(YSSendStatusParam *)param formDataArray:(NSArray *)formDataArray success:(void (^)(YSSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [YSHttpTool postWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" params:param.mj_keyValues formDataArray:formDataArray success:^(id json) {
        if (success) {
            YSSendStatusResult *result = [YSSendStatusResult mj_objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
