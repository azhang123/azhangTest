//
//  AZOAuthViewController.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/25.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZOAuthViewController.h"
#import "AFNetworking.h"

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
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=1258946049&redirect_uri=http://"]];
            
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
}

#pragma mark-UIWebView的代理方法

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    MYLog(@"webViewDidStartLoad");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    MYLog(@"webViewDidFinishLoad");
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //1.获得URL
    NSString *url=request.URL.absoluteString;
    
    //2.判断是否为回调地址
    NSRange range=[url rangeOfString:@"code="];
    if (range.length!=0) {//是回调地址
        //截取code＝后面的参数
        int fromIndex=range.location+range.length;
        NSString *code=[url substringFromIndex:fromIndex];
        
        //利用code换取一个accessToken
        [self accessTokenWithCode:code];
    }
    
    return YES;
}

-(void)accessTokenWithCode:(NSString *)code
{
    
    /*
     URL：https://api.weibo.com/oauth2/access_token
     
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    
    //2.拼接请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"client_id"]=@"1258946049";
    params[@"client_secret"]=@"52e43c91e56897f761c7e044873c340a";
    params[@"grant_type"]=@"authorization_code";
    params[@"redirect_uri"]=@"http://";
    params[@"code"]=code;
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MYLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MYLog(@"%@",error);
    }];
    
    
}


@end
