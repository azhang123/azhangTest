//
//  UIBarButtonItem+Extension.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/20.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

+(UIBarButtonItem *)ItemWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightImage:(NSString *)highlightImage
{
    //创建按钮并监听按钮的点击
    UIButton *Button=[UIButton buttonWithType:UIButtonTypeCustom];
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置按钮的背景图片
    [Button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Button setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    //设置按钮的尺寸
    Button.size=Button.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc]initWithCustomView:Button];

}

@end
