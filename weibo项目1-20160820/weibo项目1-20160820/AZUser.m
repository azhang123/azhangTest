//
//  AZUser.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/30.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZUser.h"

@implementation AZUser

//判断是否是会员并对其进行设置
-(void)setMbtype:(int)mbtype
{
    _mbtype=mbtype;
    self.isVip=mbtype>2;
}

//+(AZUser *)userWithDict:(NSDictionary *)dict
//{
//    AZUser *user=[[self alloc]init];
//    user.name=dict[@"name"];
//    user.uid=dict[@"uid"];
//    user.profile_image_url=dict[@"profile_image_url"];
//    
//    return user;
//}
@end
