//
//  AZOAuthViewController.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/25.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZOAuthViewController.h"

@interface AZOAuthViewController ()<UIWebViewDelegate>

@end

@implementation AZOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个webView
    UIWebView *webView=[[UIWebView alloc]init];
    webView.frame=self.view.bounds;
    webView.delegate=self;
    [self.view addSubview:webView];
    
    //发起请求
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/default.html"]];
            
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
}


@end
