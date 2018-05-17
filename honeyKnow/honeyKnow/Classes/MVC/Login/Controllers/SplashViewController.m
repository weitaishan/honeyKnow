//
//  SplashViewController.m
//  Designer
//
//  Created by 魏太山 on 17/1/1.
//  Copyright © 2017年 weitaishan. All rights reserved.
//

#import "SplashViewController.h"
@interface SplashViewController ()<UIScrollViewDelegate>

@end

@implementation SplashViewController{
    
    UIPageControl* _pageControl;
    UIScrollView* _scrollView;
    UIButton* _skipBtn;
    NSTimer * _timer;
    NSInteger _currentIndex;
    NSInteger _imgCount;
}
-(void)viewDidLoad{
    
    [super viewDidLoad];
    
//    [self setUI];
}
//-(void)setUI{
//
//    _imgCount = 3;
//
//    _scrollView = [[UIScrollView alloc] initWithFrame:SCREEN_FRAME];
//    _scrollView.pagingEnabled = YES;
//    _scrollView.delegate = self;
//    _scrollView.showsHorizontalScrollIndicator = NO;
//    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT);
//    _scrollView.bounces = NO;
//    [self.view addSubview:_scrollView];
//
//
//
//    for (int i = 0; i < _imgCount; i ++) {
//
//        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//
//        imageView.image = [UIImage imageNamed:@"leftbg"];
//
//        [_scrollView addSubview:imageView];
//    }
//
//
//    _pageControl = [[UIPageControl alloc] init];
//    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.0];
//    _pageControl.numberOfPages = _imgCount;
//    [_pageControl addTarget:self action:@selector(handlePageControl:)forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:_pageControl];
//    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
//        make.centerX.equalTo(self.view);
//
//
//    }];
//
//    _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
//    [_skipBtn addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_skipBtn];
//    [_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.view).offset(30);
//        make.right.equalTo(self.view.mas_right).offset(-30);
//
//
//    }];
//
//    [self startTimer];
//
//
//    //倒计时时间
//    __block NSInteger timeout = 3;
//    //获取全局队列
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    //每秒执行
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(timer, ^{
//
//        if (timeout <= 0) {//倒计时结束,关闭
//
//            dispatch_source_cancel(timer);
//
//
//        }else{
//
//            NSString* strTime = [NSString stringWithFormat:@"%.1ld",timeout];
//            NSLog(@"strTime = %@",strTime);
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//
//                [UIView beginAnimations:nil context:nil];
//                [UIView setAnimationDuration:1];
//                [_skipBtn setTitle:[NSString stringWithFormat:@"跳过%@",strTime] forState:UIControlStateNormal];
//                [UIView commitAnimations];
//
//            });
//
//            timeout --;
//        }
//
//    });
//
//    dispatch_resume(timer);
//
//}
//
//#pragma UIScrollViewDelegate
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//
//    _pageControl.currentPage = scrollView.contentOffset.x / SCREEN_WIDTH;
//
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
//
//{
//    [self stopTime];
//
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
//{
//
//    [self startTimer];
//}
//
//
//-(void)handlePageControl:(UIPageControl *)pageControl{
//
//    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * pageControl.currentPage, 0) animated:YES];
//
//}
//
//-(void)skipAction{
//
//
//    [UIView animateWithDuration:1.f animations:^{
//
//        self.view.alpha = 0;
//
//    } completion:^(BOOL finished) {
//
//        //登陆注册界面
//        RegisterViewController* registerVC = [REGISTER_SB instantiateInitialViewController];
//        self.view.window.rootViewController = registerVC;
//
//    }];
//
//
//
//}
//
//#pragma 定时器
//-(void)startTimer
//{
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(cutomTimer:) userInfo:nil repeats:YES];
//
//    //通知主线程
//    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
//}
///**
// *  结束定时器
// */
//-(void)stopTime
//{
//    [_timer invalidate];//停止定时器
//    _timer = nil;
//}
//-(void)dealloc{
//
//    [self stopTime];
//}
////定时器的回调方法
//- (void) cutomTimer:(NSTimer *) sender {
//
//
//    _currentIndex = _scrollView.contentOffset.x / SCREEN_WIDTH;
//    _pageControl.currentPage = _scrollView.contentOffset.x / SCREEN_WIDTH;
//    _currentIndex ++;
//
//    CGPoint offset = _scrollView.contentOffset;
//    offset.x = _scrollView.frame.size.width * _currentIndex;
//
//    [UIView animateWithDuration:1 animations:^{
//
//        _scrollView.contentOffset = offset;
//
//    }];
//
//    if (_currentIndex >= _imgCount ) {
//
//        [self stopTime];
//        [self skipAction];
//        return;
//    }
//}

@end
