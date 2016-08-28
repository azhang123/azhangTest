//
//  UIWindow+Extension.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/28.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "AZTabBarController.h"
#import "AZNewfeatureController.h"

@implementation UIWindow (Extension)

-(void)switchRootController
{
    //获取沙盒信息
    NSString *key=@"CFBundleVersion";
    //上一次使用的版本号
    NSString *lastVersion=[[NSUserDefaults standardUserDefaults]objectForKey:key];
    //当前软件的版本号
    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[key];
    //判断连个版本是否一致
    if ([lastVersion isEqualToString:currentVersion]) {
        
        AZTabBarController *tabvc=[[AZTabBarController alloc]init];
        self.rootViewController=tabvc;
        
    }else
    {
        self.rootViewController=[[AZNewfeatureController alloc]init];
        //将当前版本号传给沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }

}

@end
