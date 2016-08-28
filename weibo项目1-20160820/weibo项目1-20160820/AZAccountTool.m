//
//  AZAccountTool.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/28.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZAccountTool.h"
#import "AZAccount.h"

@implementation AZAccountTool

+(void)saveAccount:(NSDictionary *)dict
{
    //获取沙盒存放帐户信息文件的位置
    NSString *path=AZAccountPath;
    
    //将返回的账户信息从字典类型转为对象,保存时间
    AZAccount *account=[AZAccount accountWithDictionary:dict];
    account.create_time=[NSDate date];
    
    //将对象归档
    [NSKeyedArchiver archiveRootObject:account toFile:path];
}


+(AZAccount *)account
{
    NSString *path=AZAccountPath;
    
    AZAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSDate *create_time=account.create_time;
    //过期的秒数
    long long extired_time=[account.expires_in longLongValue];
    NSDate *extiredTime=[create_time dateByAddingTimeInterval:extired_time];
    NSDate *current_time=[NSDate date];
    NSComparisonResult result=[current_time compare:extiredTime];
    
    if (result==NSOrderedDescending) {//过期
        return nil;
    }
    
    return account;
    
}



@end
