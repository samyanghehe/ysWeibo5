//
//  NSDate+YS.h
//  ysWeibo
//
//  Created by ys on 15/12/5.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YS)

-(BOOL)isToday;

-(BOOL)isYesterday;

-(BOOL)isThisYear;
-(NSDateComponents *)deltaWhthNow;
@end
