//
//  BaseCell.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BaseCell.h"
#import "DataItem.h"
@implementation BaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

+ (NSString *)identifierForDataItem:(DataItem *)dataItem
{
    return @"";
}

+ (instancetype)cellForDataItem:(DataItem *)dataItem
{
    return nil;
}


- (void)initView
{
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
