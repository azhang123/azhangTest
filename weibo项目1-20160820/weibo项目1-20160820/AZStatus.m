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

@implementation AZStatus

-(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[AZPhoto class]};
}

//Tue Sep 13 21:49:10 +0800 2016

-(NSString *)created_at
{
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat=@"EEE MMM dd HH:mm:ss Z yyyy";
    
    NSDate *creatDate=[fmt dateFromString:_created_at];
    NSDate *now=[NSDate date];
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSCalendarUnit unit=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *cmps=[calendar components:unit fromDate:creatDate toDate:now options:0];
    MYLog(@"%@,%@,%@",cmps,creatDate,now);
    
    return _created_at;
    
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
