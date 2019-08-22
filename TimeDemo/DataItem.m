//
//  DataItem.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import "DataItem.h"

@implementation DataItem

- (void)getImage:(void(^)(UIImage *))image
{
    //if cache has the image, using the cache
    
    //is SD has,then using the SD
    
    //last down from server
}

- (void)downLoadImageFromString:(NSString *)imageUrl image:(void(^)(UIImage *))imageBlock {
    //访问百度首页
    //1. 创建一个网络请求 http://img.25pp.com/uploadfile/soft/images/2014/0731/20140731100212732.jpg
    NSURL *url = [NSURL URLWithString:imageUrl];
    
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.获得会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image;
        if(nil == error)
        {
          image = [UIImage imageWithData:data scale:2.0];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (imageBlock) {
                imageBlock(image);
            }
        });
    }];
    
    //5.执行任务
    [dataTask resume];
}
@end
