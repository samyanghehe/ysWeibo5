//
//  YSaccountTool.h
//  ysWeibo
//
//  Created by ys on 15/12/3.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSaccount.h"
@interface YSaccountTool : NSObject
+(void)saveAccount:(YSaccount *)account;
+(YSaccount *)account;
@end
