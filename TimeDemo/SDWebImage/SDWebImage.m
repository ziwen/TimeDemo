//
//  SDWebImage.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/21.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "SDWebImage.h"
#import "BnbDownLoadOperation.h"
@interface SDWebImage ()
@property (nonatomic, strong)NSMutableDictionary *operationCache;

@property (nonatomic, strong)NSOperationQueue *queue;

@property (strong, nonatomic, nonnull) NSCache *memCache;
@end

@implementation SDWebImage

+ (SDWebImage *)defaultManager
{
    static SDWebImage *webimage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webimage = [[self alloc] init];
    });
    return webimage;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAllObjects) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)removeAllObjects {
    [_memCache removeAllObjects];
}

- (void)dealloc
{
    [_operationCache removeAllObjects];
    [_memCache removeAllObjects];
    [_queue cancelAllOperations];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (NSMutableDictionary *)operationCache
{
    if (!_operationCache) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    return _operationCache;
}

- (NSCache *)memCache
{
    if (!_memCache) {
        _memCache = [[NSCache alloc] init];
    }
    return _memCache;
}

- (NSOperationQueue *)queue
{
    if (_queue == nil)
    {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

-(void)cancel
{
    [self.queue cancelAllOperations];
}

- (void)getImageWithURL:(NSString *)url finish:(void(^)(UIImage *))finish
{
    if ([self.memCache objectForKey:url])
    {
        UIImage *image = [self.memCache objectForKey:url];
        if ([[NSThread currentThread] isMainThread])
        {
            finish(image);
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                finish(image);
            });
        }
    }
    else
    {
        BnbDownLoadOperation *op = [BnbDownLoadOperation downloadOperationWithURLString:url finish:^(UIImage * _Nonnull image) {
            finish(image);
            // 下载完成之后也要移除操作
            [self.operationCache removeObjectForKey:url];
            if (image) {
                [self.memCache setObject:image forKey:url];
            }
        }];
        // 把操作添加到队列
        [self.queue addOperation:op];
        
        // 缓存操作
        [self.operationCache setObject:op forKey:url];
    }
}

@end
