//
//  YSStatusTool.h
//  ysWeibo
//
//  Created by ys on 15/12/9.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSHomeStatusParam.h"
#import "YSHomeStatusResult.h"
#import "YSSendStatusParam.h"
#import "YSSendStatusResult.h"

@interface YSStatusTool : NSObject

+(void)homeStatusWithParam:(YSHomeStatusParam *)param success:(void(^)(YSHomeStatusResult *result))success failure:(void(^)(NSError *error))failure;

+(void)sendStatusWithParam:(YSSendStatusParam *)param success:(void(^)(YSSendStatusResult *result))success failure:(void(^)(NSError *error))failure;

+(void)sendStatusWithParam:(YSSendStatusParam *)param formDataArray:(NSArray *)formDataArray success:(void(^)(YSSendStatusResult *result))success failure:(void(^)(NSError *error))failure;
@end
