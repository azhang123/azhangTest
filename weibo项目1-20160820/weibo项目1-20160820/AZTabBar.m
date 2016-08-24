//
//  AZTabBar.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/22.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZTabBar.h"

@interface AZTabBar()

@property(nonatomic,strong)UIButton *plusBtn;

@end

@implementation AZTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self) {
        //创建按钮
        UIButton *plusBtn=[[UIButton alloc]init];
        
        //设置按钮属性
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        plusBtn.size=plusBtn.currentBackgroundImage.size;
        
        [plusBtn addTarget:self action:@selector(AZTabBarDidClickPlusBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //添加按钮到tabBar
        [self addSubview:plusBtn];

        self.plusBtn=plusBtn;
        
    }
    return self;
}

/**
 *  调整按钮的位置
 */
-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    //设置按钮的位置
    self.plusBtn.centerX=self.width*0.5;
    self.plusBtn.centerY=self.height*0.5;
    
    //调整tabBar各控件的尺寸位置
    CGFloat tabBarBtnWidth=self.width/5;
    CGFloat tabBarBtnIndex=0;
    
    for (UIView *child in self.subviews) {
        Class class=NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width=tabBarBtnWidth;
            child.x=tabBarBtnIndex * tabBarBtnWidth;
            
            tabBarBtnIndex++;
            if (tabBarBtnIndex==2) {
                tabBarBtnIndex++;
            }
        }
    }
}

-(void)AZTabBarDidClickPlusBtn:(AZTabBar *)tabBar
{
    if ([self.delegate respondsToSelector:@selector(AZTabBarDidClickPlusBtn:)]) {
        [self.delegate AZTabBarDidClickPlusBtn:tabBar];
    }
}






@end
