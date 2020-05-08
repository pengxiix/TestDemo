//
//  LognWebVC.m
//  DataWalletDemo
//
//  Created by 彭西西 on 2020/5/8.
//  Copyright © 2020 彭西西. All rights reserved.
//

#import "LognWebVC.h"

/** 导航栏高 */
#define kNavHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)
/** 屏幕宽度 */
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height


@interface LognWebVC ()

@end

@implementation LognWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统导航栏";
    self.zx_showSystemNavBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self creatWeb];
}

- (void)creatWeb {
    
    self.webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavHeight)];
    self.webview.backgroundColor = [UIColor clearColor];    
    [self.view addSubview:self.webview];

    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://h5.ele.me/order/"]];
    [self.webview loadRequest:request];
}
@end
