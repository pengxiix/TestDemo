//
//  LognWebVC.h
//  DataWalletDemo
//
//  Created by 彭西西 on 2020/5/8.
//  Copyright © 2020 彭西西. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoBaseViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LognWebVC : DemoBaseViewController
/** webview */
@property (nonatomic, strong) WKWebView *webview;
/**
 传进来的webview的url
 */
@property (nonatomic, copy) NSString *webUrl;

@end

NS_ASSUME_NONNULL_END
