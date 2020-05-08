//
//  DetailWebVC.m
//  DataWalletDemo
//
//  Created by 彭西西 on 2020/5/8.
//  Copyright © 2020 彭西西. All rights reserved.
//

#import "DetailWebVC.h"
#import "GetDataVC.h"
#import "AFNetworking.h"

/** 导航栏高 */
#define kNavHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)
/** 屏幕宽度 */
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface DetailWebVC ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, copy) NSString *cookie;
@property (nonatomic, copy) NSString *userId;
@end

@implementation DetailWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatWeb];
}

- (void)creatWeb {
    self.webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, kNavHeight, kScreenWidth, kScreenHeight)];
    self.webview.backgroundColor = [UIColor clearColor];
    self.webview.navigationDelegate = self;
    self.webview.UIDelegate = self;
    [self.view addSubview:self.webview];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://h5.ele.me/order/"]];
    [self.webview loadRequest:request];
}
- (void)getCookie:(NSString *)cookieStr {
    NSArray *cookieArr = [cookieStr componentsSeparatedByString:@";"];
    for (int i = 0 ; i < cookieArr.count; i ++) {
        NSString * str = cookieArr[i];
        NSArray *dicArr = [str componentsSeparatedByString:@"="];
        if(dicArr.count == 2) {
            NSString *key = dicArr[0];
            if([key isEqualToString:@"UTUSER"]){
                self.userId = dicArr[1];
            }
        }
    }
    if(self.userId) {

        NSDictionary *dict = @{
                                   @"userId":self.userId,
                                   @"method":@"GET",
                                   @"cookie":self.cookie,
        };
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:@"https://h5.ele.me/restapi/bos/v2/users/13610016/orders?limit=8&offset=8" parameters:dict progress:nil success:
        ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"请求成功---%@",responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"请求失败--%@",error);
            }];
    }
}
    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    NSLog(@"发送跳转请求：%@",urlStr);
    [self.webview evaluateJavaScript:@"document.cookie" completionHandler:^(id _Nullable value, NSError* _Nullable error) {
        self.cookie = value;
        NSLog(@"======js====document.cookie====从网页中拿到的cookie=======%@",value);
        [self getCookie:value];
    }];
    decisionHandler(WKNavigationActionPolicyAllow);
}
    // 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}
    // 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
}
    // 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
    // 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    [self getCookie];
}
    //加载发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
}
   // 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}

-(void)getCookies{
    //获取Cookie管理单例
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //获取Cookie内的字段数组
    NSMutableArray *cookies = (NSMutableArray *)[sharedHTTPCookieStorage cookiesForURL:[NSURL URLWithString:@"https://h5.ele.me/order/"]];
    //获取原Cookie内的字段

    NSString *cookieStr = @"";

    for (NSHTTPCookie *cookie in cookies) {

    NSString *cookieString = [NSString stringWithFormat:@"%@=%@", [cookie name], [cookie value]];

    cookieStr = [cookieStr stringByAppendingString:cookieString];

    cookieStr = [cookieStr stringByAppendingString:@";"];

    }
    NSLog(@"当前页面的cookie%@",cookieStr);
}
@end
