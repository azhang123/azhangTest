//
//  NSDate+Extension.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/9/17.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


/**
 *  判断是否为今年
 */
-(BOOL)isThisYear
{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *dateCmps=[calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowComps=[calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return dateCmps.year==nowComps.year;
}

/**
 *  判断是否为昨天
 */
-(BOOL)isYesterday
{
    NSDate *now=[NSDate date];
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd";
    
    NSString *nowStr=[fmt stringFromDate:now];
    NSString *dateStr=[fmt stringFromDate:self];
    
    now=[fmt dateFromString:nowStr];
    NSDate *date=[fmt dateFromString:dateStr];
    
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSCalendarUnit unit=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *cmps=[calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year==0 && cmps.month==0 && cmps.day==1;
}

/**
 *  判断是否为今天
 */
-(BOOL)isToday
{
    NSDate *now=[NSDate date];
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd";
    
    NSString *nowStr=[fmt stringFromDate:now];
    NSString *dateStr=[fmt stringFromDate:self];
    
    return [nowStr isEqualToString:dateStr];
}

@end
