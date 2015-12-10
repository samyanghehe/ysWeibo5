//
//  YSaccountTool.m
//  ysWeibo
//
//  Created by ys on 15/12/3.
//  Copyright (c) 2015年 ys. All rights reserved.
//


#import "YSaccountTool.h"
#import "YSaccount.h"
#import "MJExtension.h"
#import "YSHttpTool.h"
@implementation YSaccountTool

+(void)saveAccount:(YSaccount *)account
{
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:YSAccountFile];
}

+(YSaccount *)account
{
    YSaccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:YSAccountFile];
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) {
        return account;
    }else{
        return nil;
    }
}

+(void)accountWithParam:(YSAccountParam *)param success:(void (^)(YSAccountResult *))success failure:(void (^)(NSError *))failure
{

    [YSHttpTool postWithURL:@"https://api.weibo.com/oauth2/access_token" params:param.mj_keyValues success:^(id json) {
        if (success) {
            YSAccountResult *result = [YSAccountResult mj_objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

@end
