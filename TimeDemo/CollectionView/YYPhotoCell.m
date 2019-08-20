//
//  YYPhotoCell.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "YYPhotoCell.h"

@interface YYPhotoCell ()
{
    UIImageView     *_imageView;
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
    _imageView.image = image;
}
@end
