//
//  MineListCell.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "MineListCell.h"
#import "MineListModel.h"
#import "MineItemView.h"
@interface MineListCell()


@end



@implementation MineListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)setListArray:(NSMutableArray<MineListModel *> *)listArray{
    
    _listArray = listArray;
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < listArray.count; i++) {
        
        MineItemView* itemView = [[MineItemView alloc] init];
        itemView.iconImgView.image = [UIImage imageNamed:listArray[i].imgName];
        itemView.lbTitle.text = listArray[i].title;
        
        [self.contentView addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView).offset(i % 3 * (SCREEN_WIDTH / 3.f));
            make.top.equalTo(self.contentView).offset((i / 3 ) * 105);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH / 3.f), 105));
            
        }];
    }
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
