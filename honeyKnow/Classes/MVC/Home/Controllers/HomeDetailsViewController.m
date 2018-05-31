//
//  HomeDetailsViewController.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/27.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "HomeDetailsViewController.h"
#import <WebKit/WebKit.h>

@interface HomeDetailsViewController ()<WKNavigationDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) WKWebView * webView;

@property (nonatomic, assign) BOOL allowZoom;

@end

@implementation HomeDetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    [self setBaseInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //    [self getUserInfoData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBaseInfo{
    

    
    self.view.backgroundColor = [UIColor colorFromHexString:@"#eeeeee"];
    _webView = [[WKWebView alloc]init];
    _webView.multipleTouchEnabled = NO;
    [self.view addSubview:_webView];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(NewStatusBarHeight);
        make.bottom.equalTo(self.view).offset(-56);
    }];
    
//    NSString* token = [NSUSERDEFAULTS objectForKey:USER_TOKEN];
//    if ([self.urlStr containsString:@"?token"] && [self.urlStr containsString:@"="]) {
//
//        self.urlStr = [NSString stringWithFormat:@"%@%@",self.urlStr,token];
//
//    }
    
    NSURL * url = [NSURL URLWithString:@"http://127.0.0.1/LiaoKaiFa/html/ta/index.html"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    self.webView.navigationDelegate = self;
    self.webView.scrollView.delegate = self;
    self.webView.scrollView.showsVerticalScrollIndicator =NO;
    self.webView.scrollView.showsHorizontalScrollIndicator =NO;

    
    self.allowZoom = YES;
 
    
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(14 + NewStatusBarHeight);
        
        make.left.equalTo(self.view).offset(19);
    }];
    
    [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside ]subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        
        if (!self.userId) {
            return ;
        }
        //手势触发调用
        [[TIMFriendshipManager sharedInstance] GetUsersProfile:@[IntStr(self.userId)] succ:^(NSArray *data) {
            
            for (TIMUserProfile * userProfile in data) {
                if ([userProfile.identifier isEqualToString:IntStr(self.userId)]) {
                    
                    IMAUser *user = [[IMAUser alloc] initWithUserInfo:userProfile];
                    
#if kTestChatAttachment
                    
                    ChatViewController *vc = [[CustomChatUIViewController alloc] initWith:user];
#else
                    ChatViewController *vc = [[IMAChatViewController alloc] initWith:user];
#endif
                    
                    TIMConversation *imconv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:user.userId];
                    if ([imconv getUnReadMessageNum] > 0)
                    {
                        [vc modifySendInputStatus:SendInputStatus_Send];
                    }
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            
            
            
        } fail:^(int code, NSString *err) {
            
        }];
            
    }];
    [self.messgeView addGestureRecognizer:tap];
    
    
    [[self.callBtn rac_signalForControlEvents:UIControlEventTouchUpInside]  subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        if (!self.userId) {
            return ;
        }
        [[SystemService shareInstance] callVideoTelePhoneWithPeerId:IntStr(self.userId)];
        
    }];
    
    
    
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
