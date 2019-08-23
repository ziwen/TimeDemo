//
//  NSString+Height.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/23.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "NSString+Height.h"

@implementation NSString (Height)

- (CGFloat)heightForSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    CGSize textSize = [self boundingRectWithSize:size
                                     options:options
                                  attributes:attributes
                                     context:nil].size;
    return textSize.height;
}
@end
