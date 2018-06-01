//
//  StarView.m
//  LimitFree
//
//  Created by 魏太山 on 16/3/30.
//  Copyright © 2016年 魏太山. All rights reserved.
//

#import "StarView.h"

@implementation StarView{
    
    UIImageView* _foregroundImageView;//前景图
    UIImageView* _backgroundImageView;//背景图
}

//创建视图
-(void)createViews{
    
    _backgroundImageView=[[UIImageView alloc]init];
    [self addSubview:_backgroundImageView];
    
    //自动布局
    _backgroundImageView.translatesAutoresizingMaskIntoConstraints=NO;
    
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(78);
        make.height.mas_equalTo(15);
        
        
        
    }];
    
    //设置背景图属性
    _backgroundImageView.image=[UIImage imageNamed:@"icon_level_white"];
    
    //设置图片显示模式
    _backgroundImageView.contentMode=UIViewContentModeLeft;
    
    //前景图
    _foregroundImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_level_yellow"]];
    [self addSubview:_foregroundImageView];
    
    [_foregroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(_backgroundImageView);
        
    }];
    
    //设置图片显示模式
    _foregroundImageView.contentMode=UIViewContentModeLeft;
    
    //裁剪
    _foregroundImageView.clipsToBounds=YES;
}
//重写init方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}

//当在xib或者Storyboard中关联类时,程序从xib或者storyboard创建对象时,会调用该方法
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self createViews];
    }
    return self;
}

-(void)setStarValue:(CGFloat)starValue{
    
    _starValue=starValue;
    if (_starValue>=0&&_starValue<=5) {
        
        //重建约束
        [_foregroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.height.equalTo(_backgroundImageView);
            make.width.equalTo(_backgroundImageView).multipliedBy(_starValue/5.0f);
            
        }];
        
    }
}
@end
