//
//  MineItemView.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "MineItemView.h"

@implementation MineItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    [self addSubview:self.iconImgView];
    
    [self addSubview:self.rightLineView];
    
    [self addSubview:self.bottomLineView];
    
    [self addSubview:self.lbTitle];
    
    [self addSubview:self.switchView];

    
}

-(UISwitch *)switchView{
    
    if (!_switchView) {
        
        _switchView = [[UISwitch alloc] init];
        _switchView.hidden = YES;
    }
    return _switchView;
}

-(UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] init];
        
    }
    
    return _iconImgView;
}

-(UILabel *)lbTitle{
    
    if (!_lbTitle) {
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.font = [UIFont systemFontOfSize:13];
        
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        
        _lbTitle.textColor = [UIColor blackColor];
        
    }
    
    return _lbTitle;
}


- (UIView *)rightLineView{

    if (!_rightLineView) {

        _rightLineView = [[UIView alloc] init];
        _rightLineView.backgroundColor = kLineColor;
    }

    return _rightLineView;
}

- (UIView *)bottomLineView{
    
    if (!_bottomLineView) {
        
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = kLineColor;
    }
    
    return _bottomLineView;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    WeakSelf;
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.left.right.equalTo(weakSelf);
        make.height.mas_equalTo(1);

    }];
    
    [_rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.right.equalTo(weakSelf);
        make.width.mas_equalTo(1);
    }];
    
    [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(weakSelf).offset(-20);
        make.centerX.mas_equalTo(weakSelf);
    }];
    
    if (_isHaveSwitch) {
        
        [_switchView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(weakSelf.lbTitle.mas_top).offset(-8);
            make.centerX.mas_equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(32, 19));
        }];
        
    }else{
        
        [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(weakSelf.lbTitle.mas_top).offset(-8);
            make.centerX.mas_equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(35, 35));

        }];
    }

}
    
@end
