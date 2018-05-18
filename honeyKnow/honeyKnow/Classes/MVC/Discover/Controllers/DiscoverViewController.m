//
//  DiscoverViewController.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/17.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverListViewController.h"
@interface DiscoverViewController ()<ZJScrollPageViewDelegate,ZJScrollPageViewChildVcDelegate>

@property (nonatomic, strong) NSMutableArray* titles;

@property (nonatomic, strong)  ZJScrollSegmentView *segmentView;

@property (nonatomic, strong) ZJContentView *contentView;


@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationController.navigationBarHidden = YES;
    
    [self initBaseInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initBaseInfo{
    
    WeakSelf;

    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 初始化
    [self setupSegmentView];
    [self setupContentView];
    
}

- (void)setupSegmentView{
    
    
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    
    //显示遮盖
    //    style.showCover = YES;
    //    style.segmentViewBounces = NO;
    //    // 颜色渐变
    //    style.gradualChangeTitleColor = YES;
    //    // 显示附加的按钮
    //    style.showExtraButton = NO;
    
    style.titleFont = [UIFont systemFontOfSize:15];
    style.titleMargin = 23;
    style.normalTitleColor = [UIColor colorFromHexString:@"#878787"];
    style.selectedTitleColor = [UIColor colorFromHexString:@"#ff776e"];
    style.scrollLineColor = [UIColor colorFromHexString:@"#ff776e"];
    style.showLine = YES;
    style.scrollLineHeight = 5;
    
    self.titles = @[@"热门",
                    @"最新",
                    @"关注"
                    ].mutableCopy;
    
    
    
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(56, NewStatusBarHeight, SCREEN_WIDTH - 56 - 18, 44) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
        
    }];
    
    // 自定义标题的样式
    //    segment.layer.cornerRadius = 14.0;
    segment.backgroundColor = [UIColor whiteColor];
    // 当然推荐直接设置背景图片的方式
    //    segment.backgroundImage = [UIImage imageNamed:@"extraBtnBackgroundImage"];
    
    self.segmentView = segment;
    
    [self.view addSubview:self.segmentView];
    
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(148, 44));
        make.top.equalTo(weakSelf.view).offset(NewStatusBarHeight);
        make.centerX.equalTo(weakSelf.view).offset(-22);
    }];
    
}

- (void)setupContentView{
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, NewStatusBarHeight + 44, SCREEN_WIDTH, SCREEN_HEIGHT - (NewStatusBarHeight + 44)) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:self.contentView];
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;// 传入页面的总数, 推荐使用titles.count
}

- (DiscoverListViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(DiscoverListViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    DiscoverListViewController *childVc = reuseViewController;
    // 这里一定要判断传过来的是否是nil, 如果为nil直接使用并返回
    // 如果不为nil 就创建
    childVc = [[DiscoverListViewController alloc] init];

        
    childVc.type = index;
        
    
    return childVc;
}
@end
