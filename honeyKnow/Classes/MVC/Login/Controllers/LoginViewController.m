//
//  LoginViewController.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/17.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginModel.h"
#import "BaseTabBarController.h"
#import "EditProfileViewController.h"
#import "IMALoginViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet LoginTextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *vCodeTF;

@property (weak, nonatomic) IBOutlet UIButton *cCodeBtn;
@property (weak, nonatomic) IBOutlet MainButton *loginBtn;
@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.title = @"登录";

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
    
    //输入用户名
    UIImageView* userView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,21, 21)];
    userView.image = [UIImage imageNamed:@"icon_phone"];
    self.phoneTF.leftView = userView;
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    [self.phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self.vCodeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    self.loginBtn.userInteractionEnabled = NO;
}

-(void)textFieldDidChange :(UITextField *)textField{

    if (self.phoneTF == textField){
        
        [self textField:textField maxLimitNumbs:11];
        if ([self validateMobile:self.phoneTF.text]){
            
            [self normalVcode:self.cCodeBtn];
        }else{
            
            [self selectVcode:self.cCodeBtn];

        }

    }else if (self.vCodeTF == textField){
        
        [self textField:textField maxLimitNumbs:6];

    }
    
    if ([self validateMobile:self.phoneTF.text] && [self validateVerificationCode:self.vCodeTF.text]){
        
        self.loginBtn.isBgImage = YES;
        self.loginBtn.userInteractionEnabled = YES;

        [self.loginBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        
        
    }else{
        
        self.loginBtn.isBgImage = NO;
        [self.loginBtn setTitleColor:[UIColor colorFromHexString:@"#BFBEB3"] forState:UIControlStateNormal];
        self.loginBtn.userInteractionEnabled = NO;

    }

}


/**
 *  现在textFile输入
 *
 *  @param textField
 *  @param numbs
 */
-(void)textField:(UITextField *)textField maxLimitNumbs:(NSInteger)numbs{
    
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textField positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textField.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > numbs)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:numbs];
        
        [textField setText:s];
    }
}


/**
 获取验证码
 */
- (void)getVcode{
    
    [WTSHttpTool requestWihtMethod:RequestMethodTypeGet url:[NSString stringWithFormat:@"%@?telphone=%@",URL_SEND_CODE,self.phoneTF.text] params:nil success:^(id response) {
       
        if (response[@"success"]){
            [self addToast:@"获取验证码成功"];

            [self vtfCountDown:self.cCodeBtn];
        }else{
            
            [self addToast:@"获取验证码失败"];

        }
        
    } failure:^(NSError *error) {
        
        [self addToast:@"获取验证码失败"];
        
    }];
}

- (IBAction)getCodeAction:(UIButton *)sender {
    
    
    if ([self validateMobile:self.phoneTF.text]){
        
        [self getVcode];

    }
    
}

- (IBAction)loginAction:(MainButton *)sender {
    
    
    if ([self validateMobile:self.phoneTF.text] && [self validateVerificationCode:self.vCodeTF.text]){

        [MBProgressHUD showHUDAddedTo:GET_WINDOW animated:YES];
        [WTSHttpTool requestWihtMethod:RequestMethodTypePost url:URL_VERIFY_CODE params:@{@"telphone" : self.phoneTF.text,
                    @"verifyCode" : self.vCodeTF.text}.mutableCopy success:^(id response) {
                        [MBProgressHUD hideHUDForView:GET_WINDOW animated:YES];

            if ([response[@"success"] integerValue]){

                LoginModel* loginModel = [LoginModel yy_modelWithJSON:response[@"data"]];

                [NSUSERDEFAULTS setValue:loginModel.identifier forKey:USER_IDENTIFIER];
                [NSUSERDEFAULTS setValue:loginModel.token forKey:USER_TOKEN];
                [NSUSERDEFAULTS setValue:loginModel.userSig forKey:USER_USERSIG];
                [NSUSERDEFAULTS synchronize];
                
                [[[IMALoginViewController alloc] init] loging];
                
                if (loginModel.isNew){
//
    
                    EditProfileViewController* vc = [MAIN_SB instantiateViewControllerWithIdentifier:@"editProfileViewController"];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else{

                    [[SystemService shareInstance] ILiveLogin];

                    //创建标签栏控制器
                    BaseTabBarController* tabBarController=[[BaseTabBarController alloc]init];

                    self.view.window.rootViewController = tabBarController;
                    
                }

            }else{

                [self addToast:response[@"msg"]];

            }

        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:GET_WINDOW animated:YES];

            [self addToast:@"登录失败"];

        }];
    }
}

//手机号码验证
-(BOOL) validateMobile:(NSString *)str{
    //手机号1开头,11位
    NSString *phoneRegex = @"^1\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:str];
}


//验证552码验证
-(BOOL) validateVerificationCode:(NSString *)str{
    //验证码验证4位
    NSString *codeRegex = @"^\\d{6}";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    return [codeTest evaluateWithObject:str];
}

/**
 验证码倒计时
 */
- (void)vtfCountDown:(UIButton *)btn{
    
    //倒计时时间
    __block NSInteger timeout = 60;
    //获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (timeout <= 0) {//倒计时结束,关闭
            
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示,根据自己需求设置
                [btn setTitle:@"获取验证码" forState:UIControlStateNormal];

                [self normalVcode:btn];
                
            });
            
        }else{
            
            NSString* strTime = [NSString stringWithFormat:@"%.2ld",timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [self selectVcode:btn];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [btn setTitle:[NSString stringWithFormat:@"已发送(%@s)",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                
            });
            
            timeout --;
        }
        
    });
    
    dispatch_resume(timer);
}

- (void)normalVcode:(UIButton *)btn{
    
    [btn setBackgroundColor:kWhiteColor];
    [btn setTitleColor:kMainColor forState:UIControlStateNormal];
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = kMainColor.CGColor;
    btn.userInteractionEnabled = YES;
}

- (void)selectVcode:(UIButton *)btn{
    btn.layer.borderWidth = 0;
    [btn setBackgroundColor:[UIColor colorFromHexString:@"#E7E7E7"]];
    [btn setTitleColor:[UIColor colorFromHexString:@"#CBCBCB"] forState:UIControlStateNormal];
    btn.userInteractionEnabled = NO;

}
@end
