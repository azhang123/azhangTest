//
//  AppDelegate.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/20.
//  Copyright © 2016年 azhang. All rights reserved.

#import "AppDelegate.h"
#import "AZHomeViewController.h"
#import "AZDiscoverViewController.h"
#import "AZTabBarController.h"
#import "AZOAuthViewController.h"
#import "AZAccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //获得帐户的登录信息
    AZAccount *account=[AZAccountTool account];
    if (account) {//之前登录过
        [self.window switchRootController];
        
    }else
    {
        self.window.rootViewController=[[AZOAuthViewController alloc]init];
    }
    
    //显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //向操作系统申请后台运行资格，能维持多久是不确定的
    UIBackgroundTaskIdentifier task=[application beginBackgroundTaskWithExpirationHandler:^{
        // 当申请的后台运行时间已经结束（过期），就会调用这个block
        
        //结束任务
        [application endBackgroundTask:task];
    }];
    
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

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr=[SDWebImageManager sharedManager];
    
    //1.取消下载
    [mgr cancelAll];
    //2.清除内存中的所有图片
    [mgr.imageCache clearMemory];
}



@end

@implementation NSURLRequest(DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
@end
