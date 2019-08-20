//
//  AirbnbNotificationCenter.m
//  TimeDemo
//
//  Created by ziwen on 2019/8/19.
//  Copyright © 2019年 larlark.com. All rights reserved.
//

//airbnb面试题1
#import "AirbnbNotificationCenter.h"

@interface AirbnbNotificationCenter ()

// TODO: complete this property in .m file
@property (nonatomic, strong) NSMutableArray *observers;
@property (nonatomic, strong) NSMutableDictionary *observersDict;

@end

@implementation AirbnbNotificationCenter

-(instancetype)init
{
    if (self = [super init]) {
        _observers = [NSMutableArray array];
        _observersDict = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (instancetype)defaultCenter
{
    static dispatch_once_t onceToken;
    static AirbnbNotificationCenter *center;
    dispatch_once(&onceToken, ^{
        center = [[AirbnbNotificationCenter alloc] init];
    });
    return center;
}

- (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(NSString *)aName {
    // TODO: make this work
    @synchronized (self) {
        
 
    __weak typeof(observer)  weakobserver = observer;
    NSDictionary *dict =
                               @{
                                   @"observer": weakobserver,
                                   @"seletor": NSStringFromSelector(aSelector),
                                   };
    
    if (_observersDict[aName]) {
        NSMutableArray *array = _observersDict[aName];
        [array addObject:dict];
    }else{
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:dict];
        _observersDict[aName] = array;
    }
    
    //[_observers addObject:dict];
    [_observersDict addEntriesFromDictionary:dict];
       }
}

- (void)postNotificationName:(NSString *)aName
                    userInfo:(nullable NSDictionary *)userInfo {
    if (aName.length < 0) {
        return;
    }
    // TODO: make this work
    @synchronized (self) {
        if (_observersDict[aName]) {
        
            NSArray *array = _observersDict[aName];
            for (NSDictionary *dict in array) {
                id cls = dict[@"observer"];
                SEL sel = NSSelectorFromString(dict[@"seletor"]);
                if([cls respondsToSelector:sel])
                {
                    [cls performSelector:sel withObject:userInfo];
                }
            }
        }
    }
}

- (void)removeObserver:(id)observer {
    // TODO: make this work
    if (NULL == observer) {
        return;
    }
    @synchronized (self) {
        for (NSString *key in [_observersDict allKeys]) {
           NSMutableArray *kArray = _observersDict[key];
            for (NSDictionary *dict in [kArray copy]) {
                if ([dict[@"observer"] isEqual:observer]) {
                    [kArray removeObject:dict];
                }
            }
          
        }
    }
}


@end
