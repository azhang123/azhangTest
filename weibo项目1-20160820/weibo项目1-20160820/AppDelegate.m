//
//  AppDelegate.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/20.
//  Copyright © 2016年 azhang. All rights reserved.


#import "AppDelegate.h"
#import "AZHomeViewController.h"
#import "AZMessageViewController.h"
#import "AZDiscoverViewController.h"
#import "AZProfileViewController.h"
#import "AZNavigationController.h"
#import "AZTabBarController.h"
#import "AZNewfeatureController.h"
#import "AZOAuthViewController.h"
#import "AZAccount.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"account.archive"];
    
    AZAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (account) {
        //获取沙盒信息
        NSString *key=@"CFBundleVersion";
        //上一次使用的版本号
        NSString *lastVersion=[[NSUserDefaults standardUserDefaults]objectForKey:key];
        //当前软件的版本号
        NSString *currentVersion=[NSBundle mainBundle].infoDictionary[key];
        //判断
        if ([lastVersion isEqualToString:currentVersion]) {
            
            AZTabBarController *tabvc=[[AZTabBarController alloc]init];
            self.window.rootViewController=tabvc;
            
        }else
        {
            self.window.rootViewController=[[AZNewfeatureController alloc]init];
            //将当前版本号传给沙盒
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }

    }else
    {
        self.window.rootViewController=[[AZOAuthViewController alloc]init];
    
    }
    MYLog(@"%@",path);
    //显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end

@implementation NSURLRequest(DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
@end
