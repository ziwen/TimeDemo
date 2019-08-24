//
//  UIImageView+SDWebImage.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/21.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+SDWebImage.h"
#import "SDWebImage.h"

@implementation UIImageView (SDWebImage)
- (void)sd_imageWithURL:(NSString *)url
{
    [[SDWebImage defaultManager] getImageWithURL:url finish:^(UIImage * _Nonnull image) {
        self.image = image;
    }];
}

@end
