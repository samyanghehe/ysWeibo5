//
//  YSOAuthViewController.m
//  ysWeibo
//
//  Created by ys on 15/12/2.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSOAuthViewController.h"
#import "AFNetworking.h"
#import "YSaccount.h"
#import "YSaccountTool.h"
#import "YSweiboTool.h"
#import "MBProgressHUD+MJ.h"
@interface YSOAuthViewController ()<UIWebViewDelegate>

@end

@implementation YSOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    webView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=383938312&redirect_uri=http://www.yangshun.date"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [webView loadRequest:request];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"?code="];
    if (range.location != NSNotFound) {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        NSLog(@"%@",code);
        [self accessTokenWithCode:code];
    }
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在联网"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
//client_id 	true 	string 	申请应用时分配的AppKey。
//client_secret 	true 	string 	申请应用时分配的AppSecret。
//grant_type 	true 	string 	请求的类型，填写authorization_code
//code 	true 	string 	调用authorize获得的code值。
//redirect_uri 	true 	string 	回调地址，需需与注册应用里的回调地址一致。
-(void)accessTokenWithCode:(NSString *)code
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = @"383938312";
    parameters[@"client_secret"] = @"3246c67b415bf2613e25581bc0f278a6";
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = @"http://www.yangshun.date";
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideHUD];
        //归档
        YSaccount *account = [YSaccount accountWithDict:responseObject];
        [YSaccountTool saveAccount:account];
        [YSweiboTool chooseRootController];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
