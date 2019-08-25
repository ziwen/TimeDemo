//
//  BnbViewItem.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/25.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BnbViewItem.h"
#import "UIImageView+SDWebImage.h"
#import "DataItem.h"
@implementation BnbViewItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imgView];
        [self addSubview:self.positionLbl];
        [self addSubview:self.nameLbl];
        
        __weak typeof(self)  weakSelf = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clickedCell:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2.0 - 30, 100);
        _imgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imgView;
}

- (UILabel *)positionLbl
{
    if (!_positionLbl) {
        _positionLbl = [[UILabel alloc] init];
        _positionLbl.font = [UIFont systemFontOfSize:10];
        _positionLbl.frame = CGRectMake(0, 100,self.bounds.size.width, 12);
        _positionLbl.backgroundColor = [UIColor redColor];
        _positionLbl.text = @"酒店房间-北京";
    }
    return _positionLbl;
}
- (UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] init];
        _nameLbl.font = [UIFont systemFontOfSize:15];
        _nameLbl.frame = CGRectMake(0, 112, self.bounds.size.width, 18);
        _nameLbl.text = @"日式榻榻米";
    }
    return _nameLbl;
}

- (void)setDataItem:(DataItem *)item
{
    _item = item;
    [_imgView sd_imageWithURL:item.imageUrl];
    _nameLbl.text = item.name;
    _positionLbl.text = item.position;
}

- (void)clickedCell:(UITapGestureRecognizer *)gesture
{
    NSLog(@"%@", _item.name);
}

@end
