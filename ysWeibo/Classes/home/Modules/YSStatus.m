
#import "YSStatus.h"
#import "NSDate+YS.h"
#import "MJExtension.h"
#import "YSPhoto.h"

@implementation YSStatus

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : [YSPhoto class]};
}

-(NSString *)created_at
{
//    NSLog(@"%@",_created_at);
//    return _created_at;
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    if (createdDate.isToday) {//今天
        //时间差一分钟内:刚刚
        //时间差一小时内:xx分钟前
        //今天 x点x分
        if (createdDate.deltaWhthNow.hour>=1) {
            fmt.dateFormat = @"今天 HH:mm";
            return [fmt stringFromDate:createdDate];
        } else if(createdDate.deltaWhthNow.minute>=1){
            NSString *minuteTime = [NSString stringWithFormat:@"%d分钟前",createdDate.deltaWhthNow.minute];
            return minuteTime;
        }else{
            return @"刚刚";
        }
    } else if(createdDate.isYesterday){//昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    }else if(createdDate.isThisYear){//今年
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }else{//N年前
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}

-(void)setSource:(NSString *)source
{
    NSUInteger loc = [source rangeOfString:@">"].location + 1;
    NSUInteger len = [source rangeOfString:@"</"].location - loc;
    NSString *source1 = [source substringWithRange:NSMakeRange(loc, len)];
    NSString *newSource = [NSString stringWithFormat:@"来自: %@",source1];
    _source = newSource;
}
@end
