//
//  AZStatus.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/30.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZStatus.h"
#import "AZUser.h"
#import "AZPhoto.h"
#import "NSDate+Extension.h"

@implementation AZStatus

-(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[AZPhoto class]};
}

//Tue Sep 13 21:49:10 +0800 2016
//Thu Dec 16 17:06:25 +0800 2013

-(NSString *)created_at
{
//    MYLog(@"%@",_created_at);
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat=@"EEE MMM dd HH:mm:ss Z yyyy";
    
    NSDate *creatDate=[fmt dateFromString:_created_at];
    NSDate *now=[NSDate date];
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSCalendarUnit unit=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *cmps=[calendar components:unit fromDate:creatDate toDate:now options:0];
    
    if ([creatDate isThisYear]) {
        if ([creatDate isYesterday]) {
            fmt.dateFormat=@"昨天 HH:mm:ss";
            return [fmt stringFromDate:creatDate];
        }else if([creatDate isToday])//今天
        {
            if (cmps.hour>1) {//几小时前
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            }else//一个小时内
            {
                if (cmps.minute>1) {
                    return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
                }else//刚刚
                {
                    return @"刚刚";
                }
            }
        }else//今年的其它日子
        {
            fmt.dateFormat=@"MM-dd HH:mm";
            return [fmt stringFromDate:creatDate];
        }
    }else//不是今年
    {
        fmt.dateFormat=@"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:creatDate];
    }    
}
// <a href="http://app.weibo.com/t/feed/3528B3" rel="nofollow">星座达人推荐</a>
-(void)setSource:(NSString *)source
{
    NSRange range;
    range.location=[source rangeOfString:@">"].location+1;
    range.length=[source rangeOfString:@"</"].location-range.location;
    _source=[NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
  
}



//+(AZStatus *)statusWithDict:(NSDictionary *)dict
//{
//    AZStatus *status=[[self alloc]init];
//    status.text=dict[@"text"];
//    status.id_str=dict[@"id_str"];
//    status.user=[AZUser userWithDict:dict[@"user"]];
//    
//    return status;
//}
@end
