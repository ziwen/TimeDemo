//
//  BnbDownLoadOperation.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/21.
//  Copyright © 2019年 larlark.com. All rights reserved.
//
#import "NSString+Path.h"
#import "BnbDownLoadOperation.h"
@interface BnbDownLoadOperation ()

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) void(^finish)(UIImage *image);

@end

@implementation BnbDownLoadOperation

- (void)main
{
    @autoreleasepool {
        NSAssert(self.finish != nil, @"finish is not nil");
        NSURL *url = [NSURL URLWithString:self.urlString];
        
        NSString *path = [self.urlString appendCache];
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                UIImage *image = [UIImage imageWithData:data];
                self.finish(image);
            }];
            return;
        }
        //get data
        data = [NSData dataWithContentsOfURL:url];
        if (data) {
            //cache
            [data writeToFile:[self.urlString appendCache] atomically:YES];
        }
        
        //cancel all operation
        if (self.isCancelled) {
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        //callback
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.finish(image);
        }];
    }
}

+ (instancetype)downloadOperationWithURLString:(NSString *)URLString finish:(void (^)(UIImage * _Nonnull))finish
{
    BnbDownLoadOperation *op = [[self alloc] init];
    op.urlString = URLString;
    op.finish = finish;
    return op;
}


@end
