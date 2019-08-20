//
//  HittestView.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "HittestView.h"

@implementation HittestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return YES;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint btnPoint = [self convertPoint:point toView:self.superview];
    if ([self.superview pointInside:btnPoint withEvent:event]) {
        return self.superview;
    }
    else if([self pointInside:point withEvent:event])
    {
        return self;
    }
    else {
         return [super hitTest:point withEvent:event];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __FUNCTION__);
}

@end
