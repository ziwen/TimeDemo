//
//  UIImageView+SDWebImage.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/21.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (SDWebImage)

- (void)sd_imageWithURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
