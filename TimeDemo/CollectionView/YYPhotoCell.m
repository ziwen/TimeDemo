//
//  YYPhotoCell.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "YYPhotoCell.h"
#import "DataItem.h"
#import "UIImageView+SDWebImage.h"
@interface YYPhotoCell ()
{
    UIImageView    *_imageView;
}

@end
@implementation YYPhotoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _imageView.layer.borderWidth = 5.0f;
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_imageView];
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
   // _imageView.image = image;
    [_imageView sd_imageWithURL:@"https://2e.zol-img.com.cn/product/138/560/ce3jiswVHj2vo.jpg"];
//    DataItem *item = [[DataItem alloc] init];
//    NSMutableArray *array = [NSMutableArray array];
//
//    [item downLoadImageFromString:@"https://img.25pp.com/uploadfile/soft/images/2014/0731/20140731100212732.jpg" image:^(UIImage * _Nonnull image1) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self->_imageView.image = image1;
//        });
//    }];
}
@end
