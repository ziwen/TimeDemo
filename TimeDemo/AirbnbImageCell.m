//
//  AirbnbImageCell.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "AirbnbImageCell.h"
#import "DataItem.h"
@interface AirbnbImageCell ()

@property (nonatomic, strong)UIImageView *airbnbImageView;

@end

@implementation AirbnbImageCell

-(UIImageView *)airbnbImageView
{
    if (!_airbnbImageView) {
        _airbnbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width -40, 60)];
        _airbnbImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _airbnbImageView;
}

- (void)initView
{
    [self addSubview:self.airbnbImageView];
}
- (void)setDataItem:(DataItem *)dataItem
{
    __weak typeof(self)  weakSelf = self;
    [dataItem getImage:^(UIImage *image){
        //must be the same dataItem
        if (image)
        {
            weakSelf.airbnbImageView.image = image;
        }
    }];

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
