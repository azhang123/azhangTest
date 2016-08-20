//
//  AZNavigationController.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/20.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZNavigationController.h"
#import "AZHomeViewController.h"
#import "AZMessageViewController.h"
#import "AZDiscoverViewController.h"
#import "AZProfileViewController.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"


@interface AZNavigationController ()

@end

@implementation AZNavigationController

+(void)initialize
{
    //设置整个项目所有item的主题样式
    UIBarButtonItem *navItem=[[UIBarButtonItem alloc]init];
    
    //设置普通状态下文字属性
    NSMutableDictionary *textAttr=[NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName]=[UIColor orangeColor];
    textAttr[NSFontAttributeName]=[UIFont systemFontOfSize:14];
    [navItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    
    //设置disable状态下文字属性
    NSMutableDictionary *disableTextAttr=[NSMutableDictionary dictionary];
    disableTextAttr[NSForegroundColorAttributeName]=AZColor(0.6*255, 255*06, 255*0.6);
    disableTextAttr[NSFontAttributeName]=[UIFont systemFontOfSize:14];
    [navItem setTitleTextAttributes:disableTextAttr forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
/**
 *  导航栏的push方法
 *
 *  @param viewController 所要push到的viewController
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count>0) {
        
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed=YES;
        
        //设置导航栏左边返回按钮
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem ItemWithTarget:self action:@selector(back) image:@"navigationbar_back" highlightImage:@"navigationbar_back_highlighted"];
        viewController.navigationItem.rightBarButtonItem=[UIBarButtonItem ItemWithTarget:self action:@selector(more) image:@"navigationbar_more_highlighted" highlightImage:@"navigationbar_more"];
        
    }
    
    [super pushViewController:viewController animated:animated];
    
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}

-(void)more
{
    [self popToRootViewControllerAnimated:YES];
}



@end
