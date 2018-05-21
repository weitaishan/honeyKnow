//
//  VideoViewController.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/19.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoModel.h"
#import "VideoCollectionViewCell.h"
@interface VideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;

@end

static NSString* videoCollectionViewCellId = @"videoCollectionViewCellId";

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setBaseInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    
}

- (void)setBaseInfo{
    
    
    
    self.navigationController.navigationBarHidden = YES;
    
    //    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //    flowLayout.headerReferenceSize = CGSizeMake(0,  10);
    flowLayout.minimumInteritemSpacing = 0;//列距
    flowLayout.minimumLineSpacing = 0;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NewStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NewStatusBarHeight) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = YES;
    _collectionView.pagingEnabled = YES;
    _collectionView.allowsMultipleSelection = YES;
    [self.view addSubview:_collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([VideoCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:videoCollectionViewCellId];
    
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
    
    UIButton* moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [moreBtn setImage:[UIImage imageNamed:@"nav_more"] forState:UIControlStateNormal];
    
    [self.view addSubview:moreBtn];
    
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(backBtn);
        
        make.right.equalTo(self.view).offset(-19);
    }];
    
    
}


#pragma mark - UICollectionViewDelegate/DataSource/FlowLayout
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArray.count;
    
}
//元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake( SCREEN_WIDTH,  SCREEN_HEIGHT);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:videoCollectionViewCellId forIndexPath:indexPath];
    
    cell.listModel = self.listArray[indexPath.row];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


#pragma mark - 懒加载
-(NSMutableArray<DiscoverList *> *)listArray{
    
    if (!_listArray) {
        
        _listArray = @[].mutableCopy;
        
    }
    
    return _listArray;
}
/**
 *  修改状态栏为白色
 */
//- (UIStatusBarStyle)preferredStatusBarStyle {
//
//    return UIStatusBarStyleLightContent;
//}
@end


