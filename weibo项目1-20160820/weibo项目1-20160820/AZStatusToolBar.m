//
//  AZStatusToolBar.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/9/9.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZStatusToolBar.h"
#import "AZStatus.h"

@interface AZStatusToolBar()

/** 转发按钮 */
@property(nonatomic,weak)UIButton *repostBtn;

/** 评论按钮 */
@property(nonatomic,weak)UIButton *commentBtn;

/** 点赞按钮 */
@property(nonatomic,weak)UIButton *attitudeBtn;

/** 按钮数组 */
@property(nonatomic,strong)NSMutableArray *Btns;

/** 分割线数组 */
@property(nonatomic,strong)NSMutableArray *dividers;


@end
@implementation AZStatusToolBar


-(NSMutableArray *)Btns
{
    if (!_Btns) {
        self.Btns=[NSMutableArray array];
    }
    return _Btns;
    
}

-(NSMutableArray *)dividers
{
    if (!_dividers) {
        self.dividers=[NSMutableArray array];
    }
    return _dividers;
}

+(instancetype)toolBar
{
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        //添加按钮
        self.repostBtn=[self setupBtnWithTitle:@"转发" Image:@"timeline_icon_retweet"];
        self.commentBtn=[self setupBtnWithTitle:@"评论" Image:@"timeline_icon_comment"];
        self.attitudeBtn=[self setupBtnWithTitle:@"赞" Image:@"timeline_icon_unlike"];
        
        //添加添加分割线
        [self setupDividers];
        [self setupDividers];
        
    }
    
    return self;
}

/**
 * 添加分割线
 */
-(void)setupDividers
{
    UIImageView *divider=[[UIImageView alloc]init];
    divider.image=[UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

/**
 *  添加按钮
 */
-(UIButton *)setupBtnWithTitle:(NSString *)title Image:(NSString *)image
{
    //添加按钮
    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_retweet_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:btn];
    
    [self.Btns addObject:btn];
    
    return btn;

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮的frame
    int btnCount=self.Btns.count;
    CGFloat btnW=self.width/btnCount;
    CGFloat btnH=self.height;
    for (int i=0; i<btnCount; i++) {
        UIButton *btn=self.Btns[i];
        btn.x=btnW*i;
        btn.y=0;
        btn.width=btnW;
        btn.height=btnH;
    }
    
    //设置分割线的frame
    int dividerCount=self.dividers.count;
    for (int i=0; i<dividerCount; i++) {
        UIImageView *divider=self.dividers[i];
        divider.x=(i+1)*btnW;
        divider.y=0;
        divider.width=1;
        divider.height=btnH;
    }
}

-(void)setStatus:(AZStatus *)status
{
    _status=status;
    
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];

}

-(void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) {
        if (count <10000) {;
            title=[NSString stringWithFormat:@"%d",count];
        }else
        {
            double wan=count/10000.0;
            title=[NSString stringWithFormat:@"%0.1f万",wan];
            title=[title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    
    [btn setTitle:title forState:UIControlStateNormal];

}

@end
