//
//  BnbHeaderView.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/25.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BnbHeaderView.h"
#import "HeaderItem.h"
@interface  BnbHeaderView()<UIScrollViewDelegate>
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *subtitleLabel;
@property (nonatomic, strong)NSMutableArray *array;
@property (nonatomic, strong)UIScrollView *citiesScrollView;
@property (nonatomic, weak)HeaderItem *headerItem;
@end

@implementation BnbHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
         _array = [NSMutableArray array];
        [self addSubview:self.titleLabel];
        [self addSubview:self.subtitleLabel];
        [self addSubview:self.citiesScrollView];
        self.citiesScrollView.hidden = YES;
       
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 23);
//        _titleLabel.backgroundColor = [UIColor orangeColor];
        _titleLabel.text = @"秋季特惠房源";
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont systemFontOfSize:14];
        _subtitleLabel.frame = CGRectMake(0, 23, [UIScreen mainScreen].bounds.size.width, 17);
//        _subtitleLabel.backgroundColor = [UIColor yellowColor];
        _subtitleLabel.text = @"低至8折，可叠加使用礼券";
    }
    return _subtitleLabel;
}

- (UIScrollView *)citiesScrollView
{
    if (!_citiesScrollView) {
        _citiesScrollView = [[UIScrollView alloc] init];
        _citiesScrollView.frame = CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 44);
        _citiesScrollView.scrollEnabled = YES;
        _citiesScrollView.bounces = NO;
        _citiesScrollView.delegate = self;
        _citiesScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _citiesScrollView;
}

- (void)setHeaderData:(HeaderItem *)headerItem
{
    _headerItem = headerItem;
    _titleLabel.text = headerItem.name;
    _subtitleLabel.text = headerItem.subName;
    
    _subtitleLabel.hidden = headerItem.subName.length > 0 ? NO: YES;
    
    self.citiesScrollView.hidden = headerItem.cities.count > 0 ? NO: YES;
    for (UIView *view in self.citiesScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.array removeAllObjects];
    for (int i = 0; i < headerItem.cities.count; i++) {
        NSString *city = headerItem.cities[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:city forState:UIControlStateNormal];
        
        if (headerItem.selectedIndex == i) {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor greenColor].CGColor;
            btn.backgroundColor = [UIColor greenColor];
        }
        else
        {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor blackColor].CGColor;
            btn.backgroundColor = [UIColor clearColor];
        }
        
        btn.layer.cornerRadius = 4;
        btn.layer.borderWidth = 1;
        btn.tag = 3000 + i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.array addObject:btn];
    }
    
    CGFloat leftMargin = 20;
    for (UIButton *btn in self.array) {
        btn.frame = CGRectMake(leftMargin, 0, 80, 40);
        [self.citiesScrollView addSubview:btn];
        leftMargin += btn.frame.size.width;
        leftMargin += 10;
    }
    
    leftMargin -= 10;
    self.citiesScrollView.contentSize = CGSizeMake(leftMargin + 20, 44);
}

- (void)btnClicked:(UIButton *)sender
{
    UIButton *btn = [self viewWithTag:_headerItem.selectedIndex + 3000];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.backgroundColor = [UIColor clearColor];
    
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.layer.borderColor = [UIColor greenColor].CGColor;
    sender.backgroundColor = [UIColor greenColor];
    _headerItem.selectedIndex = sender.tag - 3000;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickHeader:)]) {
        [self.delegate didClickHeader:self.headerItem];
    }
}

+ (CGFloat)heightForHeaderWithData:(HeaderItem *)headerItem
{
    CGFloat headerHeight = 0;
    if (headerItem.name.length > 0) {
        headerHeight += 23;
    }
    if (headerItem.subName.length > 0) {
        headerHeight += 17;
    }
    if (headerItem.cities.count > 0) {
        headerHeight += 40;
    }
    return headerHeight;
}
@end

