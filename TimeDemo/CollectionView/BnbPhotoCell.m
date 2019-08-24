//
//  YYPhotoCell.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BnbPhotoCell.h"
#import "DataItem.h"
#import "UIImageView+SDWebImage.h"
@interface BnbPhotoCell ()
{
    UIImageView    *_imageView;
}

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel     *nameLabel;
@property (nonatomic, strong)UILabel     *positionLabel;
@end
@implementation BnbPhotoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.positionLabel];
        [self.contentView addSubview:self.nameLabel];
        //self.backgroundColor = [UIColor blueColor];
   
    }
    return self;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 100)];
        _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _imageView.layer.borderWidth = 5.0f;
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

- (UILabel *)positionLabel
{
    if (!_positionLabel) {
        _positionLabel = [[UILabel alloc] init];
        _positionLabel.font = [UIFont systemFontOfSize:10];
        _positionLabel.frame = CGRectMake(0, 100, self.bounds.size.width, 12);
        _positionLabel.text = @"酒店房间-北京";
    }
    return _positionLabel;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.frame = CGRectMake(0, 112, self.bounds.size.width, 18);
        _nameLabel.text = @"日式榻榻米";
    }
    return _nameLabel;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //scale small
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0]; // [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.9]; //[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1)];
    scaleAnimation.duration = 0.2;
    scaleAnimation.autoreverses = NO;
    //scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 0;
    scaleAnimation.removedOnCompletion= NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.layer addAnimation: scaleAnimation forKey:@"myScale"];
  
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.9]; // [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0]; //[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1)];
    scaleAnimation.duration = 0.2;
    scaleAnimation.autoreverses = NO;
    //scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 0;
    scaleAnimation.removedOnCompletion= NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.layer addAnimation: scaleAnimation forKey:@"myScale1"];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //scale big
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue =  [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.duration = 0.1;
    scaleAnimation.autoreverses = NO;
    //scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 0;
    scaleAnimation.removedOnCompletion= NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.layer addAnimation: scaleAnimation forKey:@"myScale1"];
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

- (void)setDataItem:(DataItem *)item
{
    [_imageView sd_imageWithURL:item.imageUrl];
    _nameLabel.text = item.name;
    _positionLabel.text = item.position;
}


+ (CGFloat)heightForItem:(DataItem *)item
{
    return 130;
}

@end
