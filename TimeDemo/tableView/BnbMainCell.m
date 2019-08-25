//
//  BnbMainCell.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/25.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BnbMainCell.h"
#import "BnbViewItem.h"

@interface BnbMainCell ()

@property (nonatomic, strong)NSMutableArray *viewContains;
@end

@implementation BnbMainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _viewContains = [NSMutableArray array];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setDataItems:(NSArray<DataItem *> *)items
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if (items.count < _viewContains.count)
    {
        //delete
        for (NSInteger i = items.count; i< _viewContains.count; i++) {
            [_viewContains removeObjectAtIndex:i];
        }
    }
    else if (items.count >_viewContains.count)
    {
        //add
        for (NSInteger i = _viewContains.count; i < items.count; i++) {
            BnbViewItem *view = [[BnbViewItem alloc] initWithFrame:CGRectMake(0,
                                                                             0, ([UIScreen mainScreen].bounds.size.width-50)/2.0,
                                                                              130)];
            view.backgroundColor = [UIColor yellowColor];
            view.userInteractionEnabled = YES;
            [_viewContains addObject:view];
        }
    }

    for (int i = 0; i < items.count; i++) {
        BnbViewItem *view = (BnbViewItem *)self.viewContains[i];
        NSInteger left = i%2 == 0 ? 20 : [UIScreen mainScreen].bounds.size.width/2.0 + 5;
        view.frame = CGRectMake(left,
                                i/2 * 135.0,
                                ([UIScreen mainScreen].bounds.size.width-50)/2.0,
                                130);
        DataItem *item = items[i];
        [view setDataItem:item];
        [self.contentView addSubview:view];
    }
}

+ (CGFloat)heightForItems:(NSArray<DataItem *> *)items
{
    return (items.count + 1)/2 * 140;
}
@end
