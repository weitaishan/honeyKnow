//
//  WithdrawAuthenViewController.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/25.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "WithdrawAuthenViewController.h"

@interface WithdrawAuthenViewController ()<TZImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *idCardFrontImgView;
@property (weak, nonatomic) IBOutlet UIImageView *idCardBackImgView;
@property (weak, nonatomic) IBOutlet LoginTextField *aliAcountTF;
@property (weak, nonatomic) IBOutlet LoginTextField *nameTF;
@property (weak, nonatomic) IBOutlet MainButton *saveBtn;

@end

@implementation WithdrawAuthenViewController{
    
    BOOL _isFrontImg;
    BOOL _isBackImg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.title = @"提现账号认证信息";
    
    [self initBaseInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)initBaseInfo{
    
    UIImageView* aliView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,21, 21)];
    aliView.image = [UIImage imageNamed:@"icon_alipay"];
    self.aliAcountTF.leftView = aliView;
    self.aliAcountTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    //输入用户名
    UIImageView* nameView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,21, 21)];
    nameView.image = [UIImage imageNamed:@"icon_name"];
    self.nameTF.leftView = nameView;
    self.nameTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    [self.aliAcountTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.nameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    self.saveBtn.userInteractionEnabled = NO;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        
        //手势触发调用
        [self addImageWithType:1];
        
    }];
    [self.idCardFrontImgView addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
    
    [[tap2 rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        
        //手势触发调用
        [self addImageWithType:0];

    }];
    [self.idCardBackImgView addGestureRecognizer:tap2];
    
    
    [[self.saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        
        
        
    }];
    
    
    
}

- (void)addImageWithType:(NSInteger)type{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    imagePickerVc.showSelectBtn = NO;
//    imagePickerVc.allowCrop = YES;
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        if(photos.count > 0){
            
            if (type) {
                
                self.idCardFrontImgView.image = photos.firstObject;
                _isFrontImg = YES;
                
            }else{
                
                self.idCardBackImgView.image = photos.firstObject;
                _isBackImg = YES;

            }
            
            [self saveBtnIsClick];
        }
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)textFieldDidChange :(UITextField *)textField{
    
    [self saveBtnIsClick];
    
}

- (void)saveBtnIsClick{
    
    if (_isFrontImg && _isBackImg && self.nameTF.text.length && self.aliAcountTF.text.length) {
        
        self.saveBtn.userInteractionEnabled = YES;
        self.saveBtn.isBgImage = YES;
    }else{
        
        self.saveBtn.userInteractionEnabled = NO;
        self.saveBtn.isBgImage = NO;
    }
}

@end
