//
//  BnbDownLoadOperation.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/21.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BnbDownLoadOperation : NSOperation

+ (instancetype)downloadOperationWithURLString:(NSString *)URLString finish:(void(^)(UIImage *image))finish;

@end

NS_ASSUME_NONNULL_END
