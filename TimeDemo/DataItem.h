//
//  DataItem.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/20.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DataItem : NSObject

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *position;

- (void)getImage:(void(^)(UIImage *))image;
- (void)downLoadImageFromString:(NSString *)imageUrl image:(void(^)(UIImage *))imageBlock;
@end

NS_ASSUME_NONNULL_END
