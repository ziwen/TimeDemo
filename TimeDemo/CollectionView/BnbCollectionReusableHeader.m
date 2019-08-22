//
//  BnbCollectionReusableHeader.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/23.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BnbCollectionReusableHeader.h"
@interface BnbCollectionReusableHeader ()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *subtitleLabel;
@property (nonatomic, strong)NSMutableArray *array;
@end

@implementation BnbCollectionReusableHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.subtitleLabel];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 23);
        _titleLabel.backgroundColor = [UIColor orangeColor];
        _titleLabel.text = @"秋季特惠房源";
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont systemFontOfSize:14];
        _subtitleLabel.frame = CGRectMake(0, 23, self.bounds.size.width, 17);
        _subtitleLabel.backgroundColor = [UIColor yellowColor];
        _subtitleLabel.text = @"低至8折，可叠加使用礼券";
    }
    return _subtitleLabel;
}

@end
