//
//  AZDropMenuController.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/21.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZDropMenuController.h"

@interface AZDropMenuController()
@property(nonatomic,weak)UIImageView *containView;

@end

@implementation AZDropMenuController
/**
 *  懒加载灰色图框
 */
-(UIImageView *)containView
{
    
    if (!_containView) {
        
        UIImageView *containView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popover_background"]];
        containView.width=217;
        containView.height=217;
        
        containView.userInteractionEnabled=YES;
        [self addSubview:containView];
        self.containView=containView;
    }
    return _containView;
}

/**
 *  设置内容
 */
-(void)setContent:(UIView *)content
{
    _content=content;
    //调整内容的位置
    content.x=10;
    content.y=15;
    
    //调整内容的尺寸
    content.width=self.containView.width-2*content.x;
    self.containView.height=CGRectGetMaxY(content.frame)+10;
    
    //添加内容
    [self.containView addSubview:content];

}
/**
 *  设置内容视图控制器
 */
-(void)setContentController:(UIViewController *)contentController
{
    _contentController=contentController;
    
    self.content=contentController.view;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
/**
 *  下拉菜单动作
 */
-(void)showFrom:(UIView *)from
{
    //获取屏幕最上方的窗口
    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
    //添加自己到窗口,设置尺寸
    [window addSubview:self];
    self.frame=window.bounds;
    //设置灰色图片的位置
    self.containView.x=(self.width-self.containView.width)/2;
    self.containView.y=50;
    //通知外界自己显示了
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidShow:)]) {
        [self.delegate dropDownMenuDidShow:
         self];
    }
    
    
}
/**
 *  下拉菜单退回
 */
-(void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]) {
        NSLog(@"haha");

        [self.delegate dropDownMenuDidDismiss:
         self];
    }
    NSLog(@"haha");
    
    [self removeFromSuperview];
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

+(instancetype)menu
{
    return [[self alloc]init];
}

@end
