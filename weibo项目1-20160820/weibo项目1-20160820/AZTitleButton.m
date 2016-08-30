//
//  AZTitleButton.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/30.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZTitleButton.h"

@implementation AZTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
       
        //设置文字属性
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont systemFontOfSize:17];
        
        //设置图片属性
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置文字的x
    self.titleLabel.x=self.imageView.x;
    //设置图片的x
    self.imageView.x=CGRectGetMaxX(self.titleLabel.frame);
    
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
