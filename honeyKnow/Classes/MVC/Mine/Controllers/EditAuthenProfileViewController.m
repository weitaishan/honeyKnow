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

#define TEXTFIELD_TAG 500
#define myDotNumbers     @"0123456789.\n"
#define myNumbers        @"0123456789\n"

@interface EditAuthenProfileViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray<EditAuthenModel *>* listArray;

@property (nonatomic, strong) NSMutableDictionary* jsonDic;


@property (nonatomic, strong) NSMutableArray<UIImage *> *imgArr;
@property (nonatomic, strong) NSArray *assets;

@property (nonatomic, strong) MainButton* submitBtn;

@property (nonatomic, assign) BOOL isRac;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    WeakSelf;
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        NSLog(@"jsonDic = %@",weakSelf.jsonDic);
//        [WTSHttpTool requestWihtMethod:RequestMethodTypePost url:URL_USER_UPDATE params:weakSelf.jsonDic success:^(id response) {
//
//
//            if ([response[@"success"] integerValue]){
//
//                [self.navigationController popViewControllerAnimated:YES];
//
//            }
//
//        } failure:^(NSError *error) {
//
//
//        }];
        
    }];
    
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textValueChange:(NSNotification *)notif{
    
    UITextField* textField = notif.object;
    
    if (@available(iOS 11.0, *)){
        
        if (![textField.superview.superview.superview.superview isEqual:self.view]) {
            return;
        }
        
    }else{
        
        if (![textField.superview.superview.superview.superview.superview isEqual:self.view]) {
            return;
        }
    }
    
    NSLog(@"textField text = %@, tag = %ld",textField.text,textField.tag);
    

    EditAuthenModel* model = self.listArray[textField.tag - TEXTFIELD_TAG];
    
    model.data = textField.text;
    
    [self.jsonDic setObject:model.data ? model.data : @"" forKey:model.field ? model.field : @""];
    
    
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
                                
                                [rac addObject: myTextField.rac_textSignal];
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        
        
        RAC(_submitBtn, userInteractionEnabled) = [RACSignal combineLatest:rac reduce:^id _Nullable(NSString * nickName,NSString * telphone,NSString * tall,NSString * weight,NSString * constellation,NSString * location,NSString * introduce,NSString * marker,NSString * signName){
            
            NSNumber* num =  @(nickName.length && telphone.length && tall.length && weight.length && constellation.length && location.length && introduce.length && marker.length && signName.length);
            
            if ([num isEqual: @1]) {
                
                self.submitBtn.isBgImage = YES;
            }else{
                
                self.submitBtn.isBgImage = NO;

            }
            return num;
        }];
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
        [self.tableView reloadData];
        
    };
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.equalTo(view);
        
    }];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.imgArr.count > 4) {
        return 200;
    }
    return 100;
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
    
    EditAuthenCell* cell = (EditAuthenCell *)textField.superview.superview;
    
//    EditAuthenModel* cellModel = cell.model;
    
    //    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    
//    if ([cellModel.dataType isEqualToString:@"address"]) {
//
//        NSLog(@"选择地区");
//        [self.view endEditing:YES];
//
//        [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:_address numberOfComponents:3 title:@"请选择城市" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *address, NSString *zipcode) {
//            textField.text = [address stringByReplacingOccurrencesOfString:@"-"withString:@" "];
//
//            NewAddCustomerElements* model = self.listArray[textField.tag - TEXTFIELD_TAG];
//
//            model.data = textField.text;
//
//            [self.jsonDic setObject:model.data forKey:@"location"];
//
//            NSArray *addressCodeArr = [zipcode componentsSeparatedByString:@"-"];
//            NSString* province = zipcode.length ? addressCodeArr[0] : @"";
//            NSString* city = zipcode.length ? addressCodeArr[1] : @"";
//            NSString* county = zipcode.length ? addressCodeArr[2] : @"";
//
//            [self.jsonDic setObject:province forKey:@"province"];
//            [self.jsonDic setObject:city forKey:@"city"];
//            [self.jsonDic setObject:county forKey:@"county"];
//
//            //            _addressCode = zipcode;
//            //            NSLog(@"%@",zipcode);
//        } cancelBlock:^{
//
//
//        }];
//        return NO;
//
//    }else if ([cellModel.dataType isEqualToString:@"select"]) {
//        [self.view endEditing:YES];
//
//        NewAddCustomerElements* model = self.listArray[textField.tag - TEXTFIELD_TAG];
//
//        __block NSString* contentTitle;
//        __block NSString* valueStr;
//        AddCustomerHouseTypeView* selectView = [[AddCustomerHouseTypeView alloc] initWithFrame:SCREEN_FRAME dataArr:model.dataList.mutableCopy type:SelectBoxTypeAddCustomer block:^(NSString * title, NSString * value) {
//
//
//        }];
//
//        selectView.lbTitle.text = model.title;
//
//
//
//
//        selectView.contentSelBlock = ^(NSString * title, NSString * value){
//
//            contentTitle = title;
//            valueStr = value;
//
//            textField.text = contentTitle;
//
//            model.data = textField.text;
//
//            if (!valueStr) {
//                return ;
//            }
//
//            [self.jsonDic setObject:valueStr forKey:model.field];
//
//
//        };
//
//
//        [self.view.window addSubview:selectView];
//
//        return NO;
//
//    }else if ([cellModel.dataType isEqualToString:@"houseLayout"]) {
//        [self.view endEditing:YES];
//
//        NewAddCustomerElements* model = self.listArray[textField.tag - TEXTFIELD_TAG];
//
//        __block NSString* contentTitle;
//        __block NSString* valueStr;
//
//        AddCostomerTypeListView* selectView = [[AddCostomerTypeListView alloc] initWithFrame:SCREEN_FRAME dataArr:model.dataList.mutableCopy dic:self.houseLayoutDic lengthLimit:model.fieldLength.integerValue];
//
//        selectView.lbTitle.text = model.title;
//
//        [selectView.affirmBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
//
//            [selectView removeFromSuperview];
//
//            NSLog(@"jsonDic = %@",selectView.jsonDic);
//
//            contentTitle = @"";
//            [self.houseLayoutDic addEntriesFromDictionary:selectView.jsonDic];
//            [self.houseLayoutDic enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSString * obj, BOOL * _Nonnull stop) {
//
//                if (![obj isEqualToString:@"0"]  && ![obj isEqualToString:@""] && obj) {
//
//                    for (NewAddCustomerInfoDataList* listModel in model.dataList) {
//
//                        if ([listModel.field isEqualToString:key]) {
//
//                            contentTitle = [contentTitle stringByAppendingFormat:@"%@%@",obj,listModel.title];
//                            listModel.value = obj;
//                            break;
//
//                        }
//
//                    }
//                }
//
//            }];
//
//            textField.text = contentTitle;
//
//            model.data = textField.text;
//
//            if (!contentTitle) {
//                return ;
//            }
//
//            [self.jsonDic setObject:contentTitle forKey:model.field];
//
//            [self.jsonDic addEntriesFromDictionary:self.houseLayoutDic];
//
//
//        }];
//
//        [self.view.window addSubview:selectView];
//
//        return NO;
//
//    }
//    else if ([cellModel.dataType isEqualToString:@"time"]) {
//        [self.view endEditing:YES];
//
//        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
//
//
//
//            NSString *date = [startDate stringWithFormat:@"yyyy.MM.dd"];
//
//            textField.text = date;
//
//            NSTimeInterval time = [NSDate cTimestampFromDate:startDate];
//
//            NewAddCustomerElements* model = self.listArray[textField.tag - TEXTFIELD_TAG];
//
//            model.data = IntStr(time);
//
//            [self.jsonDic setObject:IntStr(time) forKey:model.field];
//
//        }];
//
//        datepicker.doneButtonColor = kBlueColor;//确定按钮的颜色
//        [datepicker show];
//
//
//
//        return NO;
//
//
//    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
