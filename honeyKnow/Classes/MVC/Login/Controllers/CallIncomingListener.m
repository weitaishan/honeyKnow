//
//  CallIncomingListener.m
//  TCILiveSDKDemo
//
//  Created by kennethmiao on 16/11/3.
//  Copyright © 2016年 kennethmiao. All rights reserved.
//

#import "CallIncomingListener.h"
#import "CallRecvViewController.h"
#import "AppDelegate.h"

@implementation CallIncomingListener
- (void)onC2CCallInvitation:(TILCallInvitation *)invitation
{
    CallRecvViewController *call = [MAIN_SB instantiateViewControllerWithIdentifier:@"callRecvViewController"];
    call.invite = invitation;
    [APP_DELEGATE().getCurrentVC presentViewController:call animated:YES completion:nil];
}



@end
