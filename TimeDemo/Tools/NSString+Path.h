//
//  NSString+Path.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/21.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Path)

- (NSString *)appendDocument;
- (NSString *)appendCache;
- (NSString *)appendTmp;



@end

NS_ASSUME_NONNULL_END
