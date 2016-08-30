//
//  AZAccountTool.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/28.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZAccountTool.h"

@implementation AZAccountTool

+(void)saveAccount:(AZAccount *)account
{
    //将对象归档
    [NSKeyedArchiver archiveRootObject:account toFile:AZAccountPath];
}


+(AZAccount *)account
{
    NSString *path=AZAccountPath;
    
    AZAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    //过期的秒数
    long long extired_time=[account.expires_in longLongValue];
    NSDate *extiredTime=[account.create_time dateByAddingTimeInterval:extired_time];
    NSDate *current_time=[NSDate date];
    NSComparisonResult result=[current_time compare:extiredTime];
    
    if (result==NSOrderedDescending) {//过期
        return nil;
    }
    
    return account;
    
}



@end
