//
//  BigAreaButton.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BigAreaButton.h"
@interface BigAreaButton ()
@property (nonatomic, assign) CGFloat maxWidth;
@end
@implementation BigAreaButton

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _maxWidth = 44.0;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    super.frame = frame;
    _maxWidth = 44.0;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    CGRect bounds = self.bounds;
//    CGFloat widthDelta = MAX(_maxWidth - bounds.size.width, 0);
//    CGFloat heightDelta = MAX(_maxWidth - bounds.size.height, 0);
//    bounds = CGRectInset(bounds, - 0.5 * widthDelta, - 0.5 * heightDelta);
//    return CGRectContainsPoint(bounds, point);
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
   // return nil;
    CGRect bounds = self.bounds;
    return [super hitTest:point withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject]; //获取当前⼿手指所在的点
    
    CGPoint curP = [touch locationInView:self]; //获取上⼀一个⼿手指所在的点
    
    CGPoint preP = [touch previousLocationInView:self]; //X轴的偏移量
    
    CGFloat offsetX = curP.x - preP.x; //Y轴的偏移量
    CGFloat offsetY = curP.y - preP.y;// 移动
    
    if (curP.x > [UIScreen mainScreen].bounds.size.width - 50 && curP.y > [UIScreen mainScreen].bounds.size.width - 80) {
        [self removeFromSuperview];
    }
    
    self.transform = CGAffineTransformTranslate(self.transform,
                                                offsetX, offsetY);
}

@end
