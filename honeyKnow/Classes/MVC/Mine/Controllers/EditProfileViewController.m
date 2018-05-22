//
//  EditProfileViewController.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/17.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "EditProfileViewController.h"
#import "BaseTabBarController.h"
@interface EditProfileViewController ()<TZImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet MainButton *submitBtn;

@end

@implementation EditProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;

    if (!_type) {
        self.navigationItem.leftBarButtonItem = nil;

        self.navigationItem.hidesBackButton = YES;
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }else{
        
        self.navigationItem.hidesBackButton = NO;
        //    返回按钮
        UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        self.navigationItem.leftBarButtonItem = leftItem;
        [self.iconBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.icoImgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"pic_avatar"]];
        self.nickNameTF.text = self.nickName ? self.nickName  : @"昵称";
    }
    
    
    
    [self initBaseInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;

    if (!_type) {

        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if (!_type) {

        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        
    }
}
//-(void)viewWillDisappear:(BOOL)animated{
//
//    [super viewWillDisappear:animated];
//
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBaseInfo{
    
    self.title = @"编辑资料";
    self.submitBtn.isBgImage = YES;
    self.nickNameTF.textAlignment = NSTextAlignmentRight;
    

}


- (IBAction)submitAction:(MainButton *)sender {
    
    if (self.nickNameTF.text.length == 0){
        
        [self addToast:@"请填写昵称"];
        return;
    }
    
    if (self.iconBtn.currentBackgroundImage){
        
        [MBProgressHUD showHUDAddedTo:GET_WINDOW animated:YES];
        [WTSHttpTool uploadSingleImageWithType:UploadTypeAvatar image:self.iconBtn.currentBackgroundImage picFileName:@"用户头像.png" success:^(id response) {
            [MBProgressHUD hideHUDForView:GET_WINDOW animated:YES];
            
            NSDictionary *dictory = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",dictory);
          
            
            NSString* url = dictory[@"data"];
            if (url.length > 0) {
                
                [WTSHttpTool requestWihtMethod:RequestMethodTypePost url:URL_USER_UPDATE params:@{@"nickName" : self.nickNameTF.text, @"avatar" : url}.mutableCopy success:^(id response) {
                    
                    if ([response[@"success"] integerValue]){

                        [[IMAPlatform sharedInstance].host asyncSetNickname:self.nickNameTF.text succ:^{
                          
                            NSLog(@"IM设置昵称成功");

                            
                        } fail:nil];
                        
                        [[TIMFriendshipManager sharedInstance] SetFaceURL:url succ:^{
                   
                            NSLog(@"IM设置头像成功");

                        } fail:^(int code, NSString *msg) {
                          
                        }];
                        
                        
                        if (self.type) {
                            
                            [self.navigationController popViewControllerAnimated:YES];
                            
                        }else{
                            
                            [[SystemService shareInstance] ILiveLogin];

                            BaseTabBarController* tabBarController=[[BaseTabBarController alloc]init];
                            self.view.window.rootViewController = tabBarController;                
                                
                            
                        }
                        
                        
                    }else{
                        
                          [self addToast:@"更新用户信息失败"];
                    }
                    
                } failure:^(NSError *error) {
                    [self addToast:@"更新用户信息失败"];

                }];
            }
            
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD hideHUDForView:GET_WINDOW animated:YES];
            [self addToast:@"上传失败"];
            
        }];
    }
    
}
- (IBAction)iconAction:(UIButton *)sender {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = YES;
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        if(photos.count > 0){
           [self.iconBtn setBackgroundImage:photos.firstObject forState:UIControlStateNormal] ;
        }
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)addToast:(NSString *)toastStr{
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [GET_WINDOW makeToast:toastStr duration:1 position:CSToastPositionCenter style:style];
    
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end
