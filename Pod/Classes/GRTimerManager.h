//
//  GRTimerManager.h
//  Pods
//
//  Created by Bell on 16/4/9.
//  Copyright © 2016年 greedlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRTimer.h"

@interface GRTimerManager : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *timersArray;

+ (GRTimerManager *)sharedInstance;

/**
 *  get timer with key
 */
- (GRTimer *)timerWithKey:(NSString *)key;

/**
 *  add timer only
 */
- (void)addTimer:(GRTimer *)timer;

/**
 *  add and run timer
 */
- (void)addAndRunTimer:(GRTimer *)timer;

/**
 *  run timer with key
 */
- (void)runTimerWithKey:(NSString *)key;

/**
 *  run all timers
 */
- (void)runAllTimers;

/**
 *  stop timer with key
 */
- (void)stopTimerWithKey:(NSString *)key;

/**
 *  stop all timers
 */
- (void)stopAllTimers;

/**
 *  stop and remove timer with key
 */
- (void)removeTimerWithKey:(NSString *)key;

/**
 *  stop and remove all timers
 */
- (void)removeAllTimers;

@end
