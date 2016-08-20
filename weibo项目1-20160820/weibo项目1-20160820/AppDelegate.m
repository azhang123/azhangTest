//
//  AppDelegate.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/20.
//  Copyright © 2016年 azhang. All rights reserved.
////
//#define AZColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//#define AZRandomColor AZColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

#import "AppDelegate.h"
#import "AZHomeViewController.h"
#import "AZMessageViewController.h"
#import "AZDiscoverViewController.h"
#import "AZProfileViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //设置根控制器
    UITabBarController *tabvc=[[UITabBarController alloc]init];
    self.window.rootViewController=tabvc;
    
    //添加子控制器
    AZHomeViewController *home=[[AZHomeViewController alloc]init];
    [self addchildvc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    AZMessageViewController *message=[[AZMessageViewController alloc]init];
    [self addchildvc:message title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    AZDiscoverViewController *discover=[[AZDiscoverViewController alloc]init];
    [self addchildvc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    AZProfileViewController *profile=[[AZProfileViewController alloc]init];
    [self addchildvc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];

    tabvc.viewControllers=@[home,message,discover,profile];

    //显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}
/**
 *  设置子控制器
 *
 *  @param vc            需要设置的子控制器
 *  @param title         设置tabbarItem的文字
 *  @param image         设置tabbarItem的图片
 *  @param selectedImage 设置tabbarItem的选中图片
 */
-(void)addchildvc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置tabbarItem的内容
    vc.tabBarItem.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:image];
    vc.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置文字显示属性
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=AZColor(146, 146, 146);
    NSMutableDictionary *selectTextAttrs=[NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName]=[UIColor orangeColor];
    [vc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    //设置子控制器的背景颜色
    vc.view.backgroundColor=AZRandomColor;

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
