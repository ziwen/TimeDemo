//
//  HeaderItem.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/23.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *subName;
@property (nonatomic, strong)NSArray<NSString *> *cities;

@property (nonatomic, assign)NSInteger selectedIndex;

@end

NS_ASSUME_NONNULL_END
