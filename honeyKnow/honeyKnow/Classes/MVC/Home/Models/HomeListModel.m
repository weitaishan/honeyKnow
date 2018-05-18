//
//Created by ESJsonFormatForMac on 18/05/17.
//

#import "HomeListModel.h"
@implementation HomeListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [HomeList class],
             @"data" : [HomeList class]
             };
}


@end

@implementation HomeList


@end


