//
//  YSHomeStatusResult.m
//  ysWeibo
//
//  Created by ys on 15/12/9.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSHomeStatusResult.h"
#import "YSStatus.h"
#import "MJExtension.h"
@implementation YSHomeStatusResult

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"statuses":[YSStatus class]};
}

@end
