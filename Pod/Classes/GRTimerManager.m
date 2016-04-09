//
//  GRTimerManager.m
//  Pods
//
//  Created by Bell on 16/4/9.
//  Copyright © 2016年 greedlab. All rights reserved.
//

#import "GRTimerManager.h"

@interface GRTimerManager ()

@property (nonatomic, strong) NSMutableArray *timersArray;

@end

@implementation GRTimerManager

#pragma mark - public

+ (GRTimerManager *)sharedInstance {
    static GRTimerManager *_timerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _timerManager = [[GRTimerManager alloc] init];
    });
    return _timerManager;
}

- (GRTimer*)timerWithKey:(NSString *)key {
    __block GRTimer *theTimer = nil;
    [_timersArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        GRTimer *timer = obj;
        if (timer.key && [timer.key isEqualToString:key]) {
            theTimer = timer;
        }
    }];
    return theTimer;
}

- (void)addTimer:(GRTimer *)timer {
    if (![self.timersArray containsObject:timer]) {
        [self.timersArray addObject:timer];
    }
}

- (void)addAndRunTimer:(GRTimer *)timer {
    [self addTimer:timer];
    [timer run];
}

- (void)runTimerWithKey:(NSString *)key {
    if (!key) {
        return;
    }
    GRTimer *timer = [self timerWithKey:key];
    if (timer) {
        [timer run];
    }
}

- (void)runAllTimers {
    [_timersArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        GRTimer *timer = obj;
        [timer run];
    }];
}

- (void)stopTimerWithKey:(NSString *)key {
    if (!key) {
        return;
    }
    GRTimer *timer = [self timerWithKey:key];
    if (timer) {
        [timer stop];
    }
}

- (void)stopAllTimers {
    [_timersArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        GRTimer *timer = obj;
        [timer stop];
    }];
}

- (void)removeTimerWithKey:(NSString *)key {
    if (!key) {
        return;
    }
    GRTimer *timer = [self timerWithKey:key];
    if (timer) {
        [timer stop];
        [_timersArray removeObject:timer];
    }
}

- (void)removeAllTimers {
    [_timersArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        GRTimer *timer = obj;
        [timer stop];
    }];
    [_timersArray removeAllObjects];
}

#pragma mark - getter

- (NSMutableArray *)timersArray {
    if (!_timersArray) {
        _timersArray = [[NSMutableArray alloc] init];
    }
    return _timersArray;
}

@end
