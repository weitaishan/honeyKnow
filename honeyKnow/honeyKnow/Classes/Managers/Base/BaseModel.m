//
//  BaseModel.m
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
+(NSDictionary *)modelCustomPropertyMapper{
    
    
    return @{@"Id" : @"id", @"desc" : @"description"};
    
}

-(void)setTelephone:(NSString *)telephone{
    
    
    _showTelephone = telephone;

    NSInteger isShowPhone =  [NSUSERDEFAULTS integerForKey:@"login_isShowPhone"];

    
    if (isShowPhone) {
        
        _telephone = telephone;
        
    }else{
        
        NSMutableString* phoneStr = telephone.mutableCopy;
        
        NSString *string;
        if (phoneStr.length >= 3) {
            
            string = phoneStr;
            
            if (phoneStr.length >= 8) {
                
                string = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
                
            }
            
        }
        
        _telephone = string;
    }
    
    
}


@end
@implementation BaseData
+(NSDictionary *)modelCustomPropertyMapper{


    return @{@"Id" : @"id", @"desc" : @"description"};

}

-(void)setTelephone:(NSString *)telephone{
    
    _showTelephone = telephone;

    NSInteger isShowPhone =  [NSUSERDEFAULTS integerForKey:@"login_isShowPhone"];

    if (isShowPhone) {

        _telephone = telephone;

    }else{
    
        NSMutableString* phoneStr = telephone.mutableCopy;
        
        NSString *string;
        if (phoneStr.length >= 3) {
            
            string = phoneStr;
            
            if (phoneStr.length >= 8) {
                
                string = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
                
            }
            
        }
        
        _telephone = string;
    }
}

@end





