//
//  GRTimer.m
//  Pods
//
//  Created by Bell on 16/4/9.
//  Copyright © 2016年 greedlab. All rights reserved.
//

#import "GRTimer.h"

@interface GRTimer () {
    /**
     *  timer
     */
    dispatch_source_t _timer;
}

@property (nonatomic, retain) NSString *key;
@property (nonatomic, assign) BOOL willRunWhenBecomeActive;
@property (nonatomic, assign) BOOL running;
@property (nonatomic, assign) double duration;
@property (nonatomic, assign) NSTimeInterval enterBackground;

@end

@implementation GRTimer

- (instancetype)init {
    self = [super init];
    if (self) {
        _timeInBackground = NO;
        _start = 0.0;
        _interval = 1.0;
        _repeats = YES;
        _running = NO;
        _leeway = 0.1;
        _duration = 0.0;
        _willRunWhenBecomeActive = NO;
    }
    return self;
}

- (void)dealloc {
    if (_timeInBackground) {
        [self removeObservers];
    }
}

#pragma mark - notification

- (void)didEnterBackground:(NSNotification *)notification {
    if (!_running) {
        return;
    }
    _willRunWhenBecomeActive = YES;
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    self.enterBackground = time;
    [self stop];
}

- (void)didBecomeActive:(NSNotification *)notification {
    if (_running) {
        return;
    }
    if (!_willRunWhenBecomeActive) {
        return;
    }
    _willRunWhenBecomeActive = NO;
    NSTimeInterval diffTime = [[NSDate date] timeIntervalSince1970] - self.enterBackground;
    diffTime = MAX(0.0, diffTime);
    _duration += diffTime;
    _running = YES;
    int number = (int) (diffTime / _interval);
    [self realRunWithStart:(diffTime - _interval * number)];
}

#pragma mark - public

+ (GRTimer *)quickInstance {
    return [[[self class] alloc] init];
}

- (void)run {
    [self setRunning:YES];
}

- (void)stop {
    [self setRunning:NO];
}

#pragma mark - getter

- (NSString *)key {
    if (!_key) {
        _key = [NSString stringWithFormat:@"%@",self];
    }
    return _key;
}

#pragma mark - setter

- (void)setTimeInBackground:(BOOL)timeInBackground {
    if (_timeInBackground == timeInBackground) {
        return;
    }
    _timeInBackground = timeInBackground;
    if (_timeInBackground) {
        [self addObservers];
    } else {
        [self removeObservers];
    }
}

- (void)setRunning:(BOOL)running {
    if (_running == running) {
        return;
    }
    _running = running;
    if (_running) {
        [self realRunWithStart:_start];
    } else {
        [self realStop];
    }
}

#pragma mark - private

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)realRunWithStart:(double)start {
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    if (!_queue) {
        _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), _interval * NSEC_PER_SEC, _leeway * NSEC_PER_SEC);
    __block BOOL firstHandler = YES;
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        __strong typeof(self) strongSelf = weakSelf;
        if (firstHandler) {
            firstHandler = NO;
            strongSelf.duration += start;
        } else {
            strongSelf.duration += _interval;
        }
        strongSelf.action();
        if (!strongSelf.repeats) {
            [strongSelf stop];
        }
    });
    dispatch_resume(_timer);
}

- (void)realStop {
    if (!_timer) {
        return;
    }
    dispatch_source_cancel(_timer);
}

@end
