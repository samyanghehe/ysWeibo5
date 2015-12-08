//
//  NSDate+YS.m
//  ysWeibo
//
//  Created by ys on 15/12/5.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "NSDate+YS.h"

@implementation NSDate (YS)

-(BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *nowComps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComps = [calendar components:unit fromDate:self];
    
    return (
    (nowComps.year == selfComps.year) && (nowComps.month == selfComps.month) && (nowComps.day == selfComps.day)
    );
}

-(BOOL)isYesterday
{
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    NSDate *selfDate = [self dateWithYMD];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return comps.day;
}

-(BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDateComponents *nowComps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComps = [calendar components:unit fromDate:self];
    
    return (
            (nowComps.year == selfComps.year)
            );

}

-(NSDateComponents *)deltaWhthNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

-(NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *str = [fmt stringFromDate:self];
    return [fmt dateFromString:str];
}
@end
