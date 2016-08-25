//
//  AZNewfeatureController.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/25.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZNewfeatureController.h"
#import "AZTabBarController.h"
#define AZFeatureCount 4
@interface AZNewfeatureController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UIPageControl *pageControl;


@end

@implementation AZNewfeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个scrollView显示所有新特性的图片
    UIScrollView *scrollView=[[UIScrollView alloc]init];
    scrollView.frame=self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView=scrollView;
    
    //添加图片到scrollView
    CGFloat scrollW=scrollView.width;
    CGFloat scrollH=scrollView.height;
    for (int i=0; i<AZFeatureCount; i++) {
        
        UIImageView *featureView=[[UIImageView alloc]init];
        //设置尺寸
        featureView.width=scrollW;
        featureView.height=scrollH;
        featureView.x=i*scrollW;
        featureView.y=0;
        //设置图片
        NSString *imageName=[NSString stringWithFormat:@"new_feature_%d",i+1];
        featureView.image=[UIImage imageNamed:imageName];
        //添加图片
        [scrollView addSubview:featureView];
        
        if (i==AZFeatureCount-1) {
            [self addSharingAndStartingBtn:featureView];
        
        }
    }
    
    //设置scrollView的属性
    scrollView.contentSize=CGSizeMake(AZFeatureCount*scrollW, 0);
    scrollView.bounces = NO; // 去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    //设置pageControl
    UIPageControl *pageControl=[[UIPageControl alloc]init];
    pageControl.numberOfPages=AZFeatureCount;
    pageControl.currentPageIndicatorTintColor=AZColor(253, 98, 42);
    pageControl.backgroundColor = [UIColor redColor];

    pageControl.pageIndicatorTintColor=AZColor(189, 189, 189);
    pageControl.centerX=scrollW * 0.5;
    pageControl.centerY=scrollH-50;
    
    [self.view addSubview:pageControl];
    self.pageControl=pageControl;
    
}


-(void)addSharingAndStartingBtn:(UIImageView *)addingView
{
    //开启交互
    addingView.userInteractionEnabled=YES;
    
    //1.分享给大家（checkbox）
    UIButton *sharingBtn=[[UIButton alloc]init];
    
    //设置图片文字
    [sharingBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [sharingBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [sharingBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [sharingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sharingBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    //设置尺寸
    MYLog(@"%@",addingView);
    sharingBtn.width=200;
    sharingBtn.height=30;
    sharingBtn.centerX=addingView.width*0.5;
    sharingBtn.centerY=addingView.height*0.65;
    
    [sharingBtn addTarget:self action:@selector(sharingClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [addingView addSubview:sharingBtn];
    [sharingBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];

    //2.添加开始按钮
    UIButton *startBtn=[[UIButton alloc]init];
    
    //设置图片
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];

#warning 设置按钮尺寸时必须先设置size,在设置中点位置
    //设置尺寸
    startBtn.size=startBtn.currentBackgroundImage.size;
    startBtn.centerX=sharingBtn.centerX;
    startBtn.centerY=addingView.height*0.75;

    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [addingView addSubview:startBtn];
    
}
/**
 *  从新特性控制器切换到AZTabBarController
 */
-(void)startClick
{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=[[AZTabBarController alloc]init];
}

-(void)dealloc
{
    MYLog(@"AZNewfeatureController已经销毁");
}
/**
 *  设置分享微博的勾选
 */
-(void)sharingClick:(UIButton *)button
{
    button.selected=!button.isSelected;
}

/**
 *  设置pageControl的页码转换
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page=scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage=(int)(page+0.5);
    MYLog(@"pagecontrol");
}


@end
