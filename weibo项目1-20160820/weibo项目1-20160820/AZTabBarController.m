//
//  AZTabBarController.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/20.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZTabBarController.h"
#import "AZHomeViewController.h"
#import "AZMessageViewController.h"
#import "AZDiscoverViewController.h"
#import "AZProfileViewController.h"
#import "AZNavigationController.h"
#import "AZTabBar.h"

@interface AZTabBarController ()<AZTabBarDelegate>

@end

@implementation AZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    AZHomeViewController *home=[[AZHomeViewController alloc]init];
    [self addchildvc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    AZMessageViewController *message=[[AZMessageViewController alloc]init];
    [self addchildvc:message title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    AZDiscoverViewController *discover=[[AZDiscoverViewController alloc]init];
    [self addchildvc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    AZProfileViewController *profile=[[AZProfileViewController alloc]init];
    [self addchildvc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    //添加自定义tabBar
    AZTabBar *tabBar=[[AZTabBar alloc]init];
    tabBar.delegate=self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    

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
    vc.title=title;
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
    vc.view.backgroundColor=AZColor(211, 211, 211);
    
    //添加导航控制器
    AZNavigationController *navi=[[AZNavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:navi];
    
}

#pragma mark-实现AZTabBar的代理方法
-(void)AZTabBarDidClickPlusBtn:(AZTabBar *)tabBar
{

    UIViewController *vc=[[UIViewController alloc]init];
    vc.view.backgroundColor=[UIColor redColor];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
