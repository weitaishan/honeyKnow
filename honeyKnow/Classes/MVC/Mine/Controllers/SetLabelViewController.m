//
//  SetLabelViewController.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/24.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "SetLabelViewController.h"
#import "SetLabelCell.h"
#import "SetLabelModel.h"
@interface SetLabelViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) MainButton* submitBtn;

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) NSMutableArray<SetLabelItem *>* listArray;

@property (nonatomic, strong) NSArray* bgColorArr;

@property (nonatomic, strong) NSMutableArray* selectArray;


@end

static NSString * const setLabelCellId = @"setLabelCellId";

@implementation SetLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBaseInfo];
    
    [self getLabelData];
    self.navigationController.navigationBarHidden = NO;
}


-(MainButton *)submitBtn{
    
    if (!_submitBtn) {
        
        _submitBtn = [[MainButton alloc] init];
        [_submitBtn setTitle:@"保存" forState:UIControlStateNormal];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 20;
        _submitBtn.backgroundColor = [UIColor colorFromHexString:@"#f3f3f3"];
        
        _submitBtn.userInteractionEnabled = self.oldArray.count ? YES : NO;
        
    }
    return _submitBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    
}

- (void)getLabelData{
    
    [WTSHttpTool requestWihtMethod:RequestMethodTypeGet url:URL_GET_MARKET_LIST params:@{}.mutableCopy success:^(id response) {
        
        
        if ([response[@"success"] integerValue]){
            
            SetLabelModel* model = [SetLabelModel yy_modelWithJSON:response];

            [self.listArray removeAllObjects];
            [self.listArray addObjectsFromArray:model.data];

            for (SetLabelItem* labelModel in self.listArray) {
                
                for (SetLabelItem* selModel in self.oldArray) {
                    
                    if (selModel.Id == labelModel.Id && selModel.isSel) {
                        
                        labelModel.isSel = YES;
                        [[self mutableArrayValueForKey:@"selectArray"] addObject:labelModel];
                        
                    }
                }
            }
            
            [self.collectionView reloadData];
            
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}
- (void)setBaseInfo{
    
    self.navigationItem.title = @"编辑认证资料";
    
    
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.submitBtn];
    
    WeakSelf;
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-75);
        make.size.mas_equalTo(CGSizeMake(221, 40));
    
    }];
    
    
    
    RAC(_submitBtn, userInteractionEnabled) = [[RACObserve(self, self.selectArray) merge:self.self.selectArray.rac_sequence.signal] map:^id(id value) {
        
        if (self.selectArray.count > 0) {
            
            self.submitBtn.isBgImage = YES;
        }else{
            
            self.submitBtn.isBgImage = NO;
            
        }
        
        return @(self.selectArray.count > 0);
    }];
    
    
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        
        NSMutableArray* markerIdArr = @[].mutableCopy;
        
        for (SetLabelItem* model in weakSelf.selectArray) {
            
            [markerIdArr addObject:IntStr(model.Id)];
        }
        
        [WTSHttpTool requestWihtMethod:RequestMethodTypePost url:URL_MARKET_UPDATE params:@{@"markerIds" : [markerIdArr componentsJoinedByString:@","]}.mutableCopy success:^(id response) {
            
            
            if ([response[@"success"] integerValue]){
                
                [weakSelf addToast:@"保存成功"];
                
                if (self.marketBlock) {
                    
                    self.marketBlock(self.selectArray);
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }
            
        } failure:^(NSError *error) {
            
            [self addToast:@"标签保存失败"];
            
        }];
        
    }];
    
        
}
-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.minimumInteritemSpacing = 0;//列距
        flowLayout.minimumLineSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 150) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SetLabelCell class]) bundle:nil] forCellWithReuseIdentifier:setLabelCellId];
        
    }
    
    return _collectionView;
    
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
    
    CGFloat width = (SCREEN_WIDTH - 60) / 3.f;
    
    return CGSizeMake( width,44);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(15, 15, 15, 15);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SetLabelCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:setLabelCellId forIndexPath:indexPath];
    
  
    
    cell.model = self.listArray[indexPath.row];
    
    if (cell.model.isSel) {
        
        cell.button.backgroundColor = [UIColor colorFromHexString: self.bgColorArr[indexPath.row % self.bgColorArr.count]];

    }else{
        
        cell.button.backgroundColor = [UIColor colorFromHexString:@"#d7d7d7"];

        
    }

    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    if (self.selectArray.count > 3) {
//
//        [self addToast:@"只能选择3个标签哦"];
//        return;
//    }
    SetLabelItem* model = self.listArray[indexPath.row];
    
    model.isSel = !model.isSel;
    
    
    if (model.isSel) {
        
        [[self mutableArrayValueForKey:@"selectArray"] addObject:model];
        
    }else{
        
        [[self mutableArrayValueForKey:@"selectArray"] removeObject:model];

    }
    
    if (self.selectArray.count > 3) {
        
        NSInteger index = [self.listArray indexOfObject:self.selectArray.firstObject];
        self.listArray[index].isSel = NO;
        [[self mutableArrayValueForKey:@"selectArray"] removeObjectAtIndex:0];
        
    }
    
    [self.collectionView reloadData];
    
}


#pragma mark - 懒加载

-(NSMutableArray<SetLabelItem *> *)listArray{
    
    if (!_listArray) {
        
        _listArray = @[].mutableCopy;
        
    }
    
    return _listArray;
}

-(NSMutableArray *)selectArray{
    
    if (!_selectArray) {
        
        _selectArray = @[].mutableCopy;
    }
    
    return _selectArray;
}

-(NSArray *)bgColorArr{
    
    if (!_bgColorArr) {
        
        _bgColorArr = @[@"#FE0000",
                        @"#FE4D00",
                        @"#FF6704",
                        @"#FFA600",
                        @"#FFE61B",
                        @"#74FE00",
                        @"#02FE02",
                        @"#04FE7F",
                        @"#0264FE",
                        @"#1407FC",
                        @"#AA24CF",
                        @"#8C07F1"];
        
    }
    
    return _bgColorArr;
    
}
@end
