//
//  NSString+Path.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/21.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

- (NSString *)appendDocument {
    NSString *root = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [root stringByAppendingPathComponent:[self lastPathComponent]];
}

- (NSString *)appendCache {
    NSString *root = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    return [root stringByAppendingPathComponent:[self lastPathComponent]];
}

- (NSString *)appendTmp {
    NSString *root = NSTemporaryDirectory();
    return [root stringByAppendingPathComponent:[self lastPathComponent]];
}

@end
