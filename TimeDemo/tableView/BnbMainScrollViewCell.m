//
//  BnbMainScrollViewCell.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/25.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BnbMainScrollViewCell.h"
#import "DataItem.h"
#import "BnbViewItem.h"
@interface BnbMainScrollViewCell ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *viewContains;
@end

@implementation BnbMainScrollViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.scrollView];
        _viewContains = [NSMutableArray array];
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)setDataItems:(NSArray<DataItem *> *)items
{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    if (items.count < _viewContains.count)
    {
        //delete
        for (NSInteger i=items.count; i< _viewContains.count; i++) {
            [_viewContains removeObjectAtIndex:i];
        }
    }
    else if (items.count >_viewContains.count)
    {
        //add
        for (NSInteger i = _viewContains.count; i < items.count; i++) {
            BnbViewItem *view = [[BnbViewItem alloc] initWithFrame:CGRectMake(0,
                                                                              0,
                                                                              [UIScreen mainScreen].bounds.size.width/2.0 - 30,
                                                                              130)];
//            view.backgroundColor = [UIColor yellowColor];
            view.userInteractionEnabled = YES;
            [_viewContains addObject:view];
        }
    }
    NSInteger leftMargin = 20;
    for (int i = 0; i < items.count; i++) {
        BnbViewItem *view = (BnbViewItem *)self.viewContains[i];
        view.frame = CGRectMake(leftMargin, 0, [UIScreen mainScreen].bounds.size.width/2.0 - 30, 130);
        leftMargin += view.frame.size.width;
        leftMargin += 10;
        DataItem *item = items[i];
        [view setDataItem:item];
        [_scrollView addSubview:view];
    }
    
    leftMargin -= 10;
    self.scrollView.contentSize = CGSizeMake(leftMargin + 20, 130);
}

+ (CGFloat)heightForItems:(NSArray<DataItem *> *)items
{
    return 150;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

@end

