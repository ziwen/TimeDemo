//
//  BnbMainView.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/25.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "BnbMainView.h"

@implementation BnbMainView

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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
