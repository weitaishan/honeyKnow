//
//  MainButton.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/17.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "MainButton.h"

@implementation MainButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initView];

    }
    return self;
}
- (void)initView{
    

}
-(void)setIsBgImage:(BOOL)isBgImage{
    
    _isBgImage = isBgImage;
    if (isBgImage) {
        
        UIImage* image = [UIImage imageNamed:@"btn_no_radius_bg"];
        //    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 40) resizingMode:UIImageResizingModeStretch];

        [self setBackgroundImage:image forState:UIControlStateNormal];
    }else{
        
        [self setBackgroundImage:nil forState:UIControlStateNormal];

    }
}
@end
