//
//  AZAccount.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/28.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZAccount.h"

@implementation AZAccount

+(instancetype)accountWithDictionary:(NSDictionary *)dict
{
    AZAccount *account=[[self alloc]init];
    if (dict) {
        account.access_token=dict[@"access_token"];
        account.expires_in=dict[@"expires_in"];
        account.uid=dict[@"uid"];
    }
    return account;
}
/**
 *  当一个对象要归档入沙盒，就会调用这个方法
 *  目的:在这个方法中说明哪些属性需要归档
 *
 */
-(void)encodeWithCoder:(NSCoder *)Encoder
{
    [Encoder encodeObject:self.access_token forKey:@"access_token"];
    [Encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [Encoder encodeObject:self.uid forKey:@"uid"];
    
}

/**
 *  当从沙盒中解档一个对象时就会调用这个方法
 *  目的:在这个方法中说明沙盒中的属性该如何解析（需要取出哪些属性）
 *
 */
-(instancetype)initWithCoder:(NSCoder *)Decoder
{
    if (self=[super init]) {
        self.access_token=[Decoder decodeObjectForKey:@"access_token"];
        self.expires_in=[Decoder decodeObjectForKey:@"expires_in"];
        self.uid=[Decoder decodeObjectForKey:@"uid"];
    }
    return self;
}


@end
