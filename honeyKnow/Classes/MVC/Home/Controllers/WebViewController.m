//
//  WebViewController.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/28.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()<WKNavigationDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) WKWebView * webView;

@property (nonatomic, assign) BOOL allowZoom;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.navigationController.navigationBarHidden = NO;
    [self setBaseInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    //    [self getUserInfoData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBaseInfo{
    
    if ([self.urlStr isEqualToString:URL_H5_HELP]) {
        
        self.title = @"帮助中心";
    }else if ([self.urlStr isEqualToString:URL_H5_BALANCE_HCOIN]) {
        
        self.title = @"H币记录";
    }else if ([self.urlStr isEqualToString:URL_H5_VIDEO_DETAILS]) {
        
        self.title = @"通话记录";
    }else if ([self.urlStr isEqualToString:URL_H5_ORDER_RANK]) {
        
        self.title = @"亲密榜";
    }else if ([self.urlStr isEqualToString:URL_H5_INCOME_DETAILS]) {
        
        self.title = @"收入明细";
    }else if ([self.urlStr isEqualToString:URL_H5_FUNDOUT_DETAILS]) {
        
        self.title = @"提现明细";
    }else if ([self.urlStr isEqualToString:URL_H5_SPREAD]) {
        
        self.title = @"我要推广";
    }
    
    
    _webView = [[WKWebView alloc]init];
    _webView.opaque = NO; //不设置这个值 页面背景始终是白色

    _webView.multipleTouchEnabled = NO;
    _webView.backgroundColor = [UIColor colorFromHexString:@"#eeeeee"];

    [self.view addSubview:_webView];

    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];

    
    
    if (self.urlStr.length == 0) {
        
        [self addToast:@"url为空"];
    }
    
    
    NSString* token = [NSUSERDEFAULTS objectForKey:USER_TOKEN];
    if ([self.urlStr containsString:@"?token"] && [self.urlStr containsString:@"="]) {
        
        self.urlStr = [NSString stringWithFormat:@"%@%@",self.urlStr,token];
        
    }
    
    NSURL * url = [NSURL URLWithString:self.urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    self.webView.navigationDelegate = self;
    self.webView.scrollView.delegate = self;
    self.webView.scrollView.showsVerticalScrollIndicator =NO;
    self.webView.scrollView.showsHorizontalScrollIndicator =NO;
    
    self.allowZoom = YES;

}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面开始加载时");
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"内容开始返回时");

}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载完成之后");
    self.allowZoom = NO;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载失败时");

}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@" 接收到服务器跳转请求之后");

}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    completionHandler();
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if(self.allowZoom){
        return nil;
    }else{
        return self.webView.scrollView.subviews.firstObject;
    }
}

@end
