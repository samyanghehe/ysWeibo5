//
//  YSaccountTool.m
//  ysWeibo
//
//  Created by ys on 15/12/3.
//  Copyright (c) 2015年 ys. All rights reserved.
//
#define YSAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "YSaccountTool.h"
#import "YSaccount.h"

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

@end
