//
//  WYGenderPickerView.m
//  WYChangeInfoDemo
//
//  Created by 意一yiyi on 2017/3/6.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import "WYGenderPickerView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface WYGenderPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSMutableArray *genderArray;// 所有性别数据

@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *confirmButton;

@property (strong, nonatomic) NSString *initialGender;// 初始化显示性别
@property (strong, nonatomic) NSString *selectedGender;// 选中性别

@end

@implementation WYGenderPickerView

- (instancetype)initWithInitialGender:(NSString *)initialGender {
    
    if ([super init]) {
        
        self.initialGender = initialGender;
        self.selectedGender = initialGender;
        
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
    
    self.genderArray = [NSMutableArray array];
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
    
    self.confirmBlock(self.selectedGender);
    
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
    
    return self.genderArray.count;
}

// 显示什么
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.genderArray[row];
}

// 选中时
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.selectedGender = self.genderArray[row];
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
        [self.genderArray addObjectsFromArray:@[@"女", @"男"]];
        
        // _pickerView 初始化显示的性别
        if (self.initialGender.length == 0) {// 默认显示女
            
            [_pickerView selectRow:0 inComponent:0 animated:YES];
            self.selectedGender = self.genderArray[0];
        }else {// 否则获取要显示的性别下标, 显示相应性别
            
            [_pickerView selectRow:[self.genderArray indexOfObject:self.initialGender] inComponent:0 animated:YES];
        }
    }
    
    return _pickerView;
}

@end
