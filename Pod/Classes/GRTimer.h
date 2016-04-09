//
//  GRTimer.h
//  Pods
//
//  Created by Bell on 16/4/9.
//  Copyright © 2016年 greedlab. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  timer will run after 'start' and if 'repeats' is YES ,it will repeats every 'interval'.
 */
@interface GRTimer : NSObject

#pragma mark - read and write

/**
 *  whether time in background
 *
 *  default NO
 */
@property (nonatomic, assign) BOOL timeInBackground;

/**
 *  start second
 *
 *  default 0.0
 */
@property (nonatomic, assign) double start;

/**
 *  whether repeats.
 *
 *  if repeats is YES, timer will run after 'start' and repeats every 'interval'.
 *  if repeats is NO, timer will run after 'start'.
 *
 *  default YES
 */
@property (nonatomic, assign) BOOL repeats;

/**
 *  interval second
 *
 *  default 1.0
 */
@property (nonatomic, assign) double interval;

/**
 *  leeway second
 *
 *  default 0.1
 */
@property (nonatomic, assign) double leeway;

/**
 *  timer queue
 *
 *  default dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
 */
@property (nonatomic, assign) dispatch_queue_t queue;

/**
 *  timer action
 *
 *  default nil
 */
@property (nonatomic, copy) dispatch_block_t action;

/**
 *  used for storage userInfo
 *
 *  default nil
 */
@property (nonatomic, strong) NSDictionary *userInfo;

#pragma mark - readonly

/**
 *  whether be running
 *
 *  default NO
 */
@property (nonatomic, assign, readonly, getter=isRunning) BOOL running;

/**
 *  key for the timer,auto generate
 *
 *  value is [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), self]
 */
@property (nonatomic, retain, readonly) NSString *key;

/**
 *  timer duration
 *
 *  default 0.0
 */
@property (nonatomic, assign, readonly) double duration;

/**
 *  create new instance
 *
 *  @return GRTimer
 */
+ (GRTimer *)quickInstance;

- (void)run;

- (void)stop;

@end
