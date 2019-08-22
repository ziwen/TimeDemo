//
//  SDWebImage.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/21.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SDWebImage : NSObject

@property (class, strong, readonly)SDWebImage *defaultManager;

- (void)getImageWithURL:(NSString *)url finish:(void(^)(UIImage *image))finish;

@end

NS_ASSUME_NONNULL_END
