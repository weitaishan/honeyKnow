//
//  WTSBaseViewController.h
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTSBaseViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    
    UITapGestureRecognizer *resetBottomTapGesture;
}
@property (nonatomic, strong) UITableView* tableView;

/** 添加tableView*/
-(void)addTableViewWithFrame:(CGRect)frame;
-(void)addTableViewWithGroupFrame:(CGRect)frame;
/** 设置导航栏右侧文字*/
-(void)addRightTitle:(NSString *)rightStr;
/** 设置导航栏右侧图片*/
-(void)addRightItemWithImage:(UIImage *)image;
/** 跳转控制器*/
-(void)nextStepController:(NSString *)ConStr stroyBoard:(NSString*)stroyBoard;
/** 设置textField文本限制*/
-(void)textField:(UITextField *)textField maxLimitNumbs:(NSInteger)numbs;
/** 添加提示*/
-(void)addToast:(NSString *)toastStr;
/**
 加载webView
 
 @param url url
 */
- (void)loadingWebViewWithUrl:(NSString *)url;
@end
