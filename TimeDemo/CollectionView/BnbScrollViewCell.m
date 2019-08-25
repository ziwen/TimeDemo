//
//  BnbScrollViewCell.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/23.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BnbScrollViewCell.h"
#import "DataItem.h"
#import "UIImageView+SDWebImage.h"
#import "BnbViewItem.h"
//@interface BnbViewItem: UIView
//@property (nonatomic, strong)UIImageView *imgView;
//@property (nonatomic, strong)UILabel *positionLbl;
//@property (nonatomic, strong)UILabel *nameLbl;
//@property (nonatomic, weak)DataItem *item;
//
//- (void)setDataItem:(DataItem *)item;
//
//@end
//@implementation BnbViewItem
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        [self addSubview:self.imgView];
//        [self addSubview:self.positionLbl];
//        [self addSubview:self.nameLbl];
//
//        __weak typeof(self)  weakSelf = self;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clickedCell:)];
//        [self addGestureRecognizer:tap];
//    }
//    return self;
//}
//
//- (UIImageView *)imgView
//{
//    if (!_imgView) {
//        _imgView = [[UIImageView alloc] init];
//        _imgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2.0 - 30, 100);
//        _imgView.contentMode = UIViewContentModeScaleToFill;
//    }
//    return _imgView;
//}
//
//- (UILabel *)positionLbl
//{
//    if (!_positionLbl) {
//        _positionLbl = [[UILabel alloc] init];
//        _positionLbl.font = [UIFont systemFontOfSize:10];
//        _positionLbl.frame = CGRectMake(0, 100,self.bounds.size.width, 12);
//        _positionLbl.backgroundColor = [UIColor redColor];
//        _positionLbl.text = @"酒店房间-北京";
//    }
//    return _positionLbl;
//}
//- (UILabel *)nameLbl
//{
//    if (!_nameLbl) {
//        _nameLbl = [[UILabel alloc] init];
//        _nameLbl.font = [UIFont systemFontOfSize:15];
//        _nameLbl.frame = CGRectMake(0, 112, self.bounds.size.width, 18);
//        _nameLbl.text = @"日式榻榻米";
//    }
//    return _nameLbl;
//}
//
//- (void)setDataItem:(DataItem *)item
//{
//    _item = item;
//    [_imgView sd_imageWithURL:item.imageUrl];
//    _nameLbl.text = item.name;
//    _positionLbl.text = item.position;
//}
//
//- (void)clickedCell:(UITapGestureRecognizer *)gesture
//{
//    NSLog(@"%@", _item.name);
//}
//
//@end


@interface BnbScrollViewCell ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *viewContains;
@end

@implementation BnbScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        _viewContains = [NSMutableArray array];

    }
    return self;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 200)];
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)setDataItem:(NSArray<DataItem *> *)items
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
            BnbViewItem *view = [[BnbViewItem alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2.0 - 30, 130)];
            view.backgroundColor = [UIColor yellowColor];
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



+ (CGFloat)heightForItem:(NSArray<DataItem *> *)items
{
    return 150;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

@end
