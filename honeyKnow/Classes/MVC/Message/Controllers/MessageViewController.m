//
//  MessageViewController.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/17.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageListModel.h"
#import "MessageListCell.h"
@interface MessageViewController ()
@property (nonatomic, strong) NSMutableArray<MessageListModel *>* listArray;

@end

static NSString * const messageListCellId = @"messageListCellId";

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationController.navigationBarHidden = NO;
    [self setBaseInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBaseInfo{
    
    self.navigationItem.title = @"消息";
    [self addTableViewWithFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight)];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor colorFromHexString:@"#eeeeee"];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MessageListCell class]) bundle:nil] forCellReuseIdentifier:messageListCellId];
}


#pragma mark - UITableViewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MessageListCell * cell = [tableView dequeueReusableCellWithIdentifier:messageListCellId forIndexPath:indexPath];
    MessageListModel* model = self.listArray[indexPath.row];
    cell.model = model;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 74;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return CGFLOAT_MIN;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return CGFLOAT_MIN;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 懒加载
-(NSMutableArray<MessageListModel *> *)listArray{
    
    if (!_listArray) {
        
        _listArray = @[].mutableCopy;
        NSArray<NSString *>* titleArr = @[@"通话记录",@"H币记录",@"预约0个"];
        NSArray<UIImage *>* imgArr = @[[UIImage imageNamed:@"icon_callrecords"],
                                       [UIImage imageNamed:@"icon_goldrecord"],
                                       [UIImage imageNamed:@"icon_reservation"]];
        
        for (int i = 0; i < titleArr.count; i++) {
            
            MessageListModel* model = [[MessageListModel alloc] init];
            model.image = imgArr[i];
            model.title = titleArr[i];
            [_listArray addObject:model];
        }
    }
    
    return _listArray;

}
@end
