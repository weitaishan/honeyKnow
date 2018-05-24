//
//  WYCityPickerView.m
//  WYChangeInfoDemo
//
//  Created by 意一yiyi on 2017/3/6.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import "WYCityPickerView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface WYCityPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSMutableArray *tempArray;
@property (strong, nonatomic) NSMutableArray *provinceArray;// 所有省份数据
@property (strong, nonatomic) NSMutableArray *cityArray;// 所有城市数据

@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *confirmButton;

@property (strong, nonatomic) NSString *initialCity;// 初始化显示城市
@property (strong, nonatomic) NSString *selectedCity;// 选中城市

@end

@implementation WYCityPickerView

- (instancetype)initWithInitialCity:(NSString *)initialCity {
    
    if ([super init]) {
        
        self.initialCity = initialCity;
        self.selectedCity = initialCity;
        
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
    
    self.tempArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CityData" ofType:@"plist"]];
    self.provinceArray = [NSMutableArray array];
    self.cityArray = [NSMutableArray array];
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
    
    self.confirmBlock(self.selectedCity);
    
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
    
    return 2;
}

// 行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return self.provinceArray.count;
    }else {
        
        return self.cityArray.count;
    }
}

// 显示什么
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return self.provinceArray[row];
    }else {
        
        return self.cityArray[row];
    }
}

// 选中时
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.tempArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CityData" ofType:@"plist"]];
    
    NSString *tempProvince = @"";
    NSString *tempCity = @"";
    
    // 选中 province 的时候要实时改变 city 的数据源
    if (component == 0) {
        
        [self.cityArray removeAllObjects];
        [self.cityArray addObjectsFromArray:self.tempArray[row][@"city"]];
        
        [pickerView reloadComponent:1];
        
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        tempProvince = self.provinceArray[row];
        tempCity = self.cityArray[[pickerView selectedRowInComponent:1]];
    }else {
        
        tempProvince = self.provinceArray[[pickerView selectedRowInComponent:0]];
        tempCity = self.cityArray[row];
    }
    
    self.selectedCity = [NSString stringWithFormat:@"%@-%@", tempProvince, tempCity];
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
        
        // 先设置省份数据源
        for (NSDictionary *tempDict in self.tempArray) {
            
            [self.provinceArray addObject:tempDict[@"province"]];
        }
        
        // _pickerView 初始化显示的城市
        if (self.initialCity.length == 0) {// 默认显示北京-通州
            
            [_pickerView selectRow:0 inComponent:0 animated:YES];
            [_pickerView selectRow:0 inComponent:1 animated:YES];
            
            // 城市数据源
            self.cityArray = self.tempArray[0][@"city"];
            
            self.selectedCity = [NSMutableString stringWithFormat:@"%@-%@", self.provinceArray[0], self.cityArray[0]];
        }else {// 否则获取要显示的城市下标, 显示相应城市
            
            NSArray *tempArray = [self.selectedCity componentsSeparatedByString:@"-"];
            NSString *province = tempArray[0];
            NSString *city = tempArray[1];
            
            NSUInteger provinceRow = [self.provinceArray indexOfObject:province];
            
            // 城市数据源
            [self.cityArray removeAllObjects];
            [self.cityArray addObjectsFromArray:self.tempArray[provinceRow][@"city"]];
            
            NSUInteger cityRow = [self.cityArray indexOfObject:city];
            
            [_pickerView selectRow:provinceRow inComponent:0 animated:YES];
            [_pickerView selectRow:cityRow inComponent:1 animated:YES];
        }
    }
    
    return _pickerView;
}

@end
