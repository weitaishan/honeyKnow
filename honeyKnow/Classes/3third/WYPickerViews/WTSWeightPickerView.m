//
//  WTSWeightPickerView.m
//  WTSEditInfoDemo
//
//  Created by AlbertWei on 2018/5/25.
//  Copyright © 2018年 意一yiyi. All rights reserved.
//

#import "WTSWeightPickerView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface WTSWeightPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSMutableArray *heightArray;// 所有身高数据

@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *confirmButton;

@property (strong, nonatomic) NSString *initialWeight;// 初始化显示身高
@property (strong, nonatomic) NSString *selectedWeight;// 选中身高

@end

@implementation WTSWeightPickerView

- (instancetype)initWithInitialWeight:(NSString *)initialWeight{
    if ([super init]) {
        
        self.initialWeight = initialWeight;
        self.selectedWeight = initialWeight;
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.618];
        
        [self initialize];
        [self drawView];
        
        self.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 216 + 44);
        [UIView animateWithDuration:0.25 animations:^{
            
            self.bottomView.frame = CGRectMake(0, kScreenHeight - 216 - 44 - 64, kScreenWidth, 216 + 44);
            [self.bottomView layoutIfNeeded];
        }];
    }
    
    return self;
}


#pragma mark - initialize

- (void)initialize {
    
    self.heightArray = [NSMutableArray array];
}


#pragma mark - drawView

- (void)drawView {
    
    [self addSubview:self.bottomView];
}


#pragma mark - action

- (void)cancelButtonAction:(UIButton *)button {
    
    self.bottomView.frame = CGRectMake(0, kScreenHeight - 216 - 44 - 64, kScreenWidth, 216 + 44);
    [UIView animateWithDuration:0.25 animations:^{
        
        self.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 216 + 44);
        [self.bottomView layoutIfNeeded];
        
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (void)confirmButtonAction:(UIButton *)button {
    
    self.confirmBlock(self.selectedWeight);
    
    self.bottomView.frame = CGRectMake(0, kScreenHeight - 216 - 44 - 64, kScreenWidth, 216 + 44);
    [UIView animateWithDuration:0.25 animations:^{
        
        self.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 216 + 44);
        [self.bottomView layoutIfNeeded];
        
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}


#pragma mark - pickerView 代理方法

// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

// 行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.heightArray.count;
}

// 显示什么
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.heightArray[row];
}

// 选中时
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.selectedWeight = self.heightArray[row];
}


#pragma mark - 懒加载

- (UIView *)bottomView {
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        [_bottomView addSubview:self.cancelButton];
        [_bottomView addSubview:self.confirmButton];
        [_bottomView addSubview:self.pickerView];
    }
    
    return _bottomView;
}

- (UIButton *)cancelButton {
    
    if (!_cancelButton) {
        
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 12, 44, 20)];
        _cancelButton.backgroundColor = [UIColor clearColor];
        
        [_cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelButton setTitleColor:[UIColor colorWithRed:195 / 255.0 green:195 / 255.0 blue:195 / 255.0 alpha:1] forState:(UIControlStateNormal)];
        
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return _cancelButton;
}

- (UIButton *)confirmButton {
    
    if (!_confirmButton) {
        
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 44 - 20, 12, 44, 20)];
        _confirmButton.backgroundColor = [UIColor clearColor];
        
        [_confirmButton setTitle:@"完成" forState:(UIControlStateNormal)];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_confirmButton setTitleColor:[UIColor colorWithRed:195 / 255.0 green:195 / 255.0 blue:195 / 255.0 alpha:1] forState:(UIControlStateNormal)];
        
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return _confirmButton;
}

- (UIPickerView *)pickerView {
    
    if (!_pickerView) {
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 216)];
        _pickerView.backgroundColor = [UIColor clearColor];
        
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        
        // 先设置数据源
        for (NSInteger i = 30; i <= 299; i ++) {// 100cm ~ 250cm
            
            [self.heightArray addObject:[NSString stringWithFormat:@"%ldKG", i]];
        }
        
        // _pickerView 初始化显示的身高值
        if (self.initialWeight.length == 0) {// 默认显示 177cm
            
            [_pickerView selectRow:20 inComponent:0 animated:YES];
            self.selectedWeight = self.heightArray[20];
        }else {// 否则获取要显示的身高值下标, 显示相应身高值
            
            [_pickerView selectRow:[self.heightArray indexOfObject:self.initialWeight] inComponent:0 animated:YES];
        }
    }
    
    return _pickerView;
}

@end
