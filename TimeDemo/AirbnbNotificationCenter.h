//
//  AirbnbNotificationCenter.h
//  TimeDemo
//
//  Created by ziwen on 2019/8/19.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

/*
 * Different observers can observe same notification name
 * Implement first stage APIs.
 * Notification center doesn't affect lifecycle of observer.
 * Make it thread safety.
 */

#import <Foundation/Foundation.h>

// AirbnbNotificationCenter.h
NS_ASSUME_NONNULL_BEGIN

@interface AirbnbNotificationCenter : NSObject

// TODO: complete this property in .m file
@property (class, readonly, strong) AirbnbNotificationCenter *defaultCenter;




- (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(NSString *)aName;

- (void)postNotificationName:(NSString *)aName
                    userInfo:(nullable NSDictionary *)userInfo;

- (void)removeObserver:(id)observer;

@end

NS_ASSUME_NONNULL_END
