//
//  EditAuthenProfileViewController.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/24.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "EditAuthenProfileViewController.h"
#import "EditAuthenCell.h"
#import "EditAuthenHeaderView.h"
#import "EditAuthenModel.h"
#import "SetLabelViewController.h"
#import "SetLabelModel.h"
#import "WTSPickerHeaders.h"

#define TEXTFIELD_TAG 500

#define HEADER_HEIGHT ((SCREEN_WIDTH - 20) / 4.f)
@interface EditAuthenProfileViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray<EditAuthenModel *>* listArray;

@property (nonatomic, strong) NSMutableDictionary* jsonDic;


@property (nonatomic, strong) NSMutableArray<UIImage *> *imgArr;
@property (nonatomic, strong) NSArray *assets;

@property (nonatomic, strong) MainButton* submitBtn;

@property (nonatomic, assign) BOOL isRac;

@property (nonatomic, strong) NSMutableArray* selectArray;

@property (nonatomic, assign) BOOL isSubmit;

@end

static NSString * const editAuthenCellId = @"editAuthenCellId";

@implementation EditAuthenProfileViewController{
    
    
    CGFloat _leftMarge;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBaseInfo];
    
    self.navigationController.navigationBarHidden = NO;
    _isRac = YES;
}


-(MainButton *)submitBtn{
    
    if (!_submitBtn) {
        
        _submitBtn = [[MainButton alloc] init];
        [_submitBtn setTitle:@"提交认证申请" forState:UIControlStateNormal];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 25;
        _submitBtn.backgroundColor = [UIColor colorFromHexString:@"#f3f3f3"];
        _submitBtn.userInteractionEnabled = NO;
        
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

    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 120.;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 44.;
    
}

- (void)setBaseInfo{
    
    
    
    self.navigationItem.title = @"编辑认证资料";
    [self addTableViewWithGroupFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarAndNavigationBarHeight)];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([EditAuthenCell class]) bundle:nil]  forCellReuseIdentifier:editAuthenCellId];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    WeakSelf;
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        NSLog(@"jsonDic = %@",weakSelf.jsonDic);
        [self submitAction];
        
    }];
    
    
}

-(void)dealloc{
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)textValueChange:(NSNotification *)notif{
//
//    NSLog(@"submit json = %@",self.jsonDic);
//
//    UITextField* textField = notif.object;
//
//    if (@available(iOS 11.0, *)){
//
//        if (![textField.superview.superview.superview.superview isEqual:self.view]) {
//            return;
//        }
//
//    }else{
//
//        if (![textField.superview.superview.superview.superview.superview isEqual:self.view]) {
//            return;
//        }
//    }
//
//    NSLog(@"textField text = %@, tag = %ld",textField.text,textField.tag);
//
//
//    EditAuthenModel* model = self.listArray[textField.tag - TEXTFIELD_TAG];
//
//
//    model.data = textField.text;
//
//
//    [self.jsonDic setObject:model.data ? model.data : @"" forKey:model.field ? model.field : @""];
//
//
//
//    [self textChangeTextField:textField];
//
//
//
//
//}

- (void)textChangeTextField:(UITextField* )textField{

    if (_isRac) {

        _isRac = NO;
        NSMutableArray<RACSignal *>* rac = @[].mutableCopy;
        for (UIView* subViews in textField.superview.superview.superview.subviews) {

            NSLog(@"textField subViews = %@",subViews);

            if ([subViews isKindOfClass:[EditAuthenCell class]]) {

                NSLog(@"textField EditAuthenCell = %@",subViews.subviews);

                for (UIView* subTwo in subViews.subviews) {


                    if ([subTwo isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {

                        NSLog(@"textField UITableViewCellContentView = %@",subTwo.subviews);

                        for (UIView* subThree in subTwo.subviews) {

                            if ([subThree isKindOfClass:NSClassFromString(@"UITextField")]) {

                                UITextField* myTextField = (UITextField *)subThree;
                                [myTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];

                                [rac addObject:[ myTextField rac_signalForControlEvents:UIControlEventEditingChanged]];

                            }

                        }

                    }

                }

            }

        }
    
        
        
//        RAC(_submitBtn, userInteractionEnabled) = [RACSignal combineLatest:rac reduce:^id _Nullable(NSString * nickName,NSString * telphone,NSString * tall,NSString * weight,NSString * constellation,NSString * location,NSString * introduce,NSString * marker,NSString * signName){
//
//            NSNumber* num =  @(nickName.length && telphone.length && tall.length && weight.length && constellation.length && location.length && introduce.length && marker.length && signName.length);
//
//            if ([num isEqual: @1]) {
//
//                self.submitBtn.isBgImage = YES;
//            }else{
//
//                self.submitBtn.isBgImage = NO;
//
//            }
//            return num;
//        }];
    }
}
- (void)textFieldChanged:(UITextField *)textField{
    
    EditAuthenModel* model = self.listArray[textField.tag - TEXTFIELD_TAG];
    
    
    model.data = textField.text;
    
    
    if (model.data.length) {
        [self.jsonDic setObject:model.data ? model.data : @"" forKey:model.field ? model.field : @""];

        
    }else{
        
        [self.jsonDic removeObjectForKey:model.field ? model.field : @""];

    }
    
    
    
//    [self textChangeTextField:textField];
    
    [self submitBtnIsClick];
}

- (void)submitBtnIsClick{
    
    NSLog(@"submit json = %@",self.jsonDic);
    
    
    if (self.jsonDic.count == self.listArray.count && self.imgArr.count) {
        
        self.submitBtn.isBgImage = YES;
        self.submitBtn.userInteractionEnabled = YES;
    }else{
        
        self.submitBtn.isBgImage = NO;
        self.submitBtn.userInteractionEnabled = NO;
        
    }
}
#pragma mark - 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.listArray.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    EditAuthenModel* model = self.listArray[indexPath.row];
    EditAuthenCell* cell = [tableView dequeueReusableCellWithIdentifier:editAuthenCellId forIndexPath:indexPath];
    
    
    cell.textFiled.delegate = self;

    cell.textFiled.tag = indexPath.row + TEXTFIELD_TAG;

    cell.model = model;
    
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 76;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 76)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    
    
    [view addSubview:self.submitBtn];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(260, 50));
    }];
    
    
    return  view;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor whiteColor];
    
    EditAuthenHeaderView* headerView = [[EditAuthenHeaderView alloc] initWithImgArr:self.imgArr assets:self.assets];
    
    [view addSubview:headerView];
    
    headerView.reloadBlock = ^(NSMutableArray *imgArr, NSArray *assets) {
      
        self.imgArr = imgArr;
        self.assets = assets;
        [self submitBtnIsClick];

        [self.tableView reloadData];
        
    };
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.equalTo(view);
        
    }];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.imgArr.count > 4) {
        return HEADER_HEIGHT + 9 * 3;

    }
    return HEADER_HEIGHT + 9 * 2;
}


#pragma mark - 懒加载
-(NSMutableArray<EditAuthenModel *> *)listArray{
    
    if (!_listArray) {
        
        _listArray = @[].mutableCopy;
        
        //JSON文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EditAuthenInfo" ofType:@"json"];
        
        //加载JSON文件
        NSData *data = [NSData dataWithContentsOfFile:path];

        //将JSON数据转为NSArray或NSDictionary
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"编辑资料json = %@",path);
        
        for (NSDictionary* dic in array) {
            
            EditAuthenModel* model = [EditAuthenModel yy_modelWithDictionary:dic];
            
            if ([model.field isEqualToString:@"telphone"]) {
                
                model.data = [NSUSERDEFAULTS objectForKey:USER_TELPHONE];
                [self.jsonDic setObject:model.data ? model.data : @"" forKey:model.field];
            }
            [_listArray addObject:model];

        }
        
        
        
        
    }
    
    return _listArray;
}

-(NSMutableDictionary *)jsonDic{
    
    if (!_jsonDic) {
        
        _jsonDic = @{}.mutableCopy;
        
    }
    
    return _jsonDic;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    [self textChangeTextField:textField];
    
    EditAuthenCell* cell = (EditAuthenCell *)textField.superview.superview;
    
    EditAuthenModel* cellModel = cell.model;
    
    
    if ([cellModel.dataType isEqualToString:@"input"] && cellModel.isEdit) {
        
        return YES;
    }else if ([cellModel.dataType isEqualToString:@"marker"]){
        
        [self.view endEditing:YES];
        SetLabelViewController* vc = [[SetLabelViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.marketBlock = ^(NSMutableArray *marketArr) {
          
            self.selectArray = marketArr;
            NSMutableArray* markerNameArr = @[].mutableCopy;
            
            for (SetLabelItem* labelModel in marketArr) {
                
                [markerNameArr addObject:labelModel.name ? labelModel.name : @""];
            }
            textField.text = [markerNameArr componentsJoinedByString:@","];
            cellModel.data = textField.text;
            [self.jsonDic setObject:cellModel.data forKey:cellModel.field];
            [self submitBtnIsClick];
        };
        vc.oldArray = self.selectArray;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([cellModel.dataType isEqualToString:@"tall"]){
        
        [self.view endEditing:YES];

        WTSHeightPickerView *heightPickerView = [[WTSHeightPickerView alloc] initWithInitialHeight:textField.text];
        
        heightPickerView.confirmBlock = ^(NSString *selectedHeight) {
            
            textField.text = selectedHeight;
            cellModel.data = textField.text;
            [self.jsonDic setObject:cellModel.data forKey:cellModel.field];
            [self submitBtnIsClick];

        };
        [self.tableView addSubview:heightPickerView];


    }else if ([cellModel.dataType isEqualToString:@"weight"]){
        
        [self.view endEditing:YES];

        WTSWeightPickerView *weightPickerView = [[WTSWeightPickerView alloc] initWithInitialWeight:textField.text];
        
        weightPickerView.confirmBlock = ^(NSString *selectedWeight) {
            
            textField.text = selectedWeight;
            cellModel.data = textField.text;
            [self.jsonDic setObject:cellModel.data forKey:cellModel.field];
            [self submitBtnIsClick];

        };
        [self.tableView addSubview:weightPickerView];
        
        
    }else if ([cellModel.dataType isEqualToString:@"constellation"]){
        
        [self.view endEditing:YES];

        WTSConstellationPickerView *constellationPickerView = [[WTSConstellationPickerView alloc] initWithInitialConstellation:textField.text];
        
        constellationPickerView.confirmBlock = ^(NSString *selectedConstellation) {
            
            textField.text = selectedConstellation;
            cellModel.data = textField.text;
            [self.jsonDic setObject:cellModel.data forKey:cellModel.field];
            [self submitBtnIsClick];

        };
        [self.tableView addSubview:constellationPickerView];
        
        
    }else if ([cellModel.dataType isEqualToString:@"location"]){
        
        [self.view endEditing:YES];

        WTSCityPickerView *cityPickerView = [[WTSCityPickerView alloc] initWithInitialCity:textField.text];
        
        cityPickerView.confirmBlock = ^(NSString *selectedCity) {
            
            textField.text = selectedCity;
            cellModel.data = textField.text;
             NSArray *addressCodeArr = [selectedCity componentsSeparatedByString:@"-"];
            NSString* address = @"";
            if (addressCodeArr.count == 2) {
                
                address = addressCodeArr.lastObject;
            }
            [self.jsonDic setObject:address.length ? address : @"杭州" forKey:cellModel.field];
            [self submitBtnIsClick];

        };
        [self.tableView addSubview:cityPickerView];
        
        
    }
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)submitAction{
    
    
    self.submitBtn.userInteractionEnabled = NO;
    
    [MBProgressHUD showHUDAddedTo:GET_WINDOW animated:YES];
    [WTSHttpTool uploadImagesWithType:UploadTypeAvatar picFileName:@"编辑资料图片" images:self.imgArr success:^(NSString * imageUrls) {
        [MBProgressHUD hideHUDForView:GET_WINDOW animated:YES];

        [self.jsonDic setObject:imageUrls ? imageUrls : @"" forKey:@"imgs"];
        [WTSHttpTool requestWihtMethod:RequestMethodTypePost url:URL_USER_UPDATE params:self.jsonDic success:^(id response) {
            
            if ([response[@"success"] integerValue]){
                [self addToast:@"提交认证成功"];

                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }
            
        } failure:^(NSError *error) {
            
            [self addToast:@"提交认证失败"];
        }];
        
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:GET_WINDOW animated:YES];

    }];
    

    
}
- (void)saveAddCustomerInfo{
    
    
//    BOOL isRequired = NO;
//
//    for (NewAddCustomerElements* eleModel in self.listArray) {
//
//
//        NSString* value = [self.jsonDic objectForKey:eleModel.field];
//
//        if (eleModel.isRequired) {
//
//            if (value == nil || [value isEqualToString:@""]) {
//
//                [self addToast:[NSString stringWithFormat:@"您还有 %@ 未填写哦~",eleModel.title]];
//                isRequired = YES;
//                break;
//
//            }
//
//
//
//        }
//
//
//        if (value != nil || value.length != 0) {
//
//            if ([eleModel.field isEqualToString:@"telephone"]) {
//
//                if (![self validateMobileTwo:value]) {
//
//                    [self addToast:@"您输入的手机号位数不对哦"];
//                    isRequired = YES;
//                    return;
//                }
//
//            }
//
//
//            if ([eleModel.fieldType isEqualToString:@"decimal"]) {
//
//                if (![self validateDecimal:value]) {
//
//                    [self addToast:[NSString stringWithFormat:@"您 %@ 输入的格式不对哦~",eleModel.title]];
//                    return;
//                }
//            }
//
//        }
//
//    }
//
//    if (isRequired) {
//
//        return;
//    }
//
//    [self.view endEditing:YES];
//    NSString* str = [[Utils shareInstance] DataTOjsonString:self.jsonDic];
//    self.btnView.submitBtn.userInteractionEnabled = NO;
//    [SJHHTTPTOOL saveAddCustomerInfoWithJsonData:str completion:^(GetCompanyProcessGroupData* model, NSString *msg) {
//
//
//        self.btnView.submitBtn.userInteractionEnabled = YES;
//
//        if (model) {
//
//            self.groupModel = model;
//            self.submitSuccessView.centerHeight = 348;
//
//            [self.view.window addSubview:self.submitSuccessView];
//
//        }else{
//
//            [self addToast:msg];
//
//        }
//
//    }];
//
    
}


@end
