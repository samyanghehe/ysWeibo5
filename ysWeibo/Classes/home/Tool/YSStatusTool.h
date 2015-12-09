//
//  YSStatusTool.h
//  ysWeibo
//
//  Created by ys on 15/12/9.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSHomeStatusParam;
@interface YSStatusTool : NSObject

+(void)homeStatusWithParam:(YSHomeStatusParam *)param success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

@end
