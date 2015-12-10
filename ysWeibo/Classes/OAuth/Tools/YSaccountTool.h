//
//  YSaccountTool.h
//  ysWeibo
//
//  Created by ys on 15/12/3.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSaccount.h"
#import "defineFile.h"
#import "YSAccountParam.h"
#import "YSAccountResult.h"


@interface YSaccountTool : NSObject
+(void)saveAccount:(YSaccount *)account;
+(YSaccount *)account;
+(void)accountWithParam:(YSAccountParam *)param success:(void(^)(YSAccountResult *result))success failure:(void(^)(NSError *error))failure;
@end
