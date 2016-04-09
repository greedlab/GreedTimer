//
//  GRViewController.m
//  GreedTimer
//
//  Created by Bell on 04/09/2016.
//  Copyright (c) 2016 greedlab. All rights reserved.
//

#import "GRViewController.h"
#import <Masonry.h>
#import <GreedTimer/GreedTimer.h>

@interface GRViewController ()

@property (nonatomic, strong) NSString *key1;
@property (nonatomic, strong) NSString *key2;
@property (nonatomic, strong) NSString *key3;

@end

@implementation GRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initView];
    [self setConstraints];
    WeakSelf(weakSelf);
    if (YES) {
        GRTimer *timer = [[GRTimer alloc] init];
        __weak __typeof(GRTimer *)weakTimer = timer;
        timer.action = ^{
            [weakSelf timer1Changed:weakTimer];
        };
        self.key1 = timer.key;
        [[GRTimerManager sharedInstance] addAndRunTimer:timer];
    }
    if (YES) {
        GRTimer *timer = [[GRTimer alloc] init];
        timer.repeats = YES;
        timer.start = 1;
        timer.interval = 2;
        timer.timeInBackground = YES;
        __weak __typeof(GRTimer *)weakTimer = timer;
        timer.action = ^{
            [weakSelf timer2Changed:weakTimer];
        };
        self.key2 = timer.key;
        [[GRTimerManager sharedInstance] addAndRunTimer:timer];
    }
    if (YES) {
        GRTimer *timer = [[GRTimer alloc] init];
        timer.repeats = NO;
        timer.start = 10;
        timer.interval = 40;
        __weak __typeof(GRTimer *)weakTimer = timer;
        timer.action = ^{
            [weakSelf timer3Changed:weakTimer];
        };
        self.key3 = timer.key;
        [[GRTimerManager sharedInstance] addAndRunTimer:timer];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

- (void)timer1Changed:(id)sender {
    WeakSelf(weakSelf);
    dispatch_async(dispatch_get_main_queue(), ^{
        GRTimer *timer = (GRTimer*)sender;
        weakSelf.value1Label.text = [NSString stringWithFormat:@"%@",@(timer.duration)];
    });
}

- (void)timer2Changed:(id)sender {
    WeakSelf(weakSelf);
    dispatch_async(dispatch_get_main_queue(), ^{
        GRTimer *timer = (GRTimer*)sender;
        NSString *text = [NSString stringWithFormat:@"%@",@(timer.duration)];
        NSLog(@"text:%@",text);
        weakSelf.value2Label.text = text;
    });
}

- (void)timer3Changed:(id)sender {
    WeakSelf(weakSelf);
    dispatch_async(dispatch_get_main_queue(), ^{
        GRTimer *timer = (GRTimer*)sender;
        weakSelf.value3Label.text = [NSString stringWithFormat:@"%@",@(timer.duration)];
    });
}

- (void)run1ButtonPressed:(id)sender {
    [[GRTimerManager sharedInstance] runTimerWithKey:self.key1];
}

- (void)stop1ButtonPressed:(id)sender {
    [[GRTimerManager sharedInstance] stopTimerWithKey:self.key1];
}

- (void)stop2ButtonPressed:(id)sender {
    [[GRTimerManager sharedInstance] stopTimerWithKey:self.key2];
}

- (void)stop3ButtonPressed:(id)sender {
    [[GRTimerManager sharedInstance] stopTimerWithKey:self.key3];
}

- (void)stopAllButtonPressed:(id)sender {
    [[GRTimerManager sharedInstance] stopAllTimers];
}

#pragma mark - private

- (void)initView {
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.text = @"1";
        [self.view addSubview:label];
        
        self.key1Label = label;
    }
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.text = @"2";
        [self.view addSubview:label];
        
        self.key2Label = label;
    }
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.text = @"3";
        [self.view addSubview:label];
        
        self.key3Label = label;
    }
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        [self.view addSubview:label];
        
        self.value1Label = label;
    }
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        [self.view addSubview:label];
        
        self.value2Label = label;
    }
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        [self.view addSubview:label];
        
        self.value3Label = label;
    }
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button setTitle:@"Run1" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(run1ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        self.run1Button = button;
    }
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button setTitle:@"Stop1" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(stop1ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        self.stop1Button = button;
    }
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button setTitle:@"Stop2" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(stop2ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        self.stop2Button = button;
    }
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button setTitle:@"Stop3" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(stop3ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        self.stop3Button = button;
    }
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button setTitle:@"Stop" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(stopAllButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        self.stopAllButton = button;
    }
}

- (void)setConstraints {
    WeakSelf(weakSelf);
    [_key1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(20);
        make.height.equalTo(@40);
        make.width.equalTo(@8);
        make.top.equalTo(weakSelf.view).offset(80);
    }];
    [_value1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.key1Label.mas_right).offset(10);
        make.height.equalTo(@40);
        make.width.equalTo(@160);
        make.centerY.equalTo(weakSelf.key1Label);
    }];
    [_run1Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.value1Label.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.key1Label);
        make.height.equalTo(@40);
        make.width.equalTo(@60);
    }];
    [_stop1Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.run1Button.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.key1Label);
        make.height.equalTo(@40);
        make.width.equalTo(@60);
    }];
    
    [_key2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(weakSelf.key1Label);
        make.top.equalTo(weakSelf.key1Label.mas_bottom).offset(10);
    }];
    [_value2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(weakSelf.value1Label);
        make.centerY.equalTo(weakSelf.key2Label);
    }];
    [_stop2Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.key2Label);
        make.left.height.width.equalTo(weakSelf.stop1Button);
    }];
    
    [_key3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(weakSelf.key1Label);
        make.top.equalTo(weakSelf.key2Label.mas_bottom).offset(10);
    }];
    [_value3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(weakSelf.value1Label);
        make.centerY.equalTo(weakSelf.key3Label);
    }];
    [_stop3Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.key3Label);
        make.left.height.width.equalTo(weakSelf.stop1Button);
    }];
    
    [_stopAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.key3Label.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf.view);
        make.height.equalTo(@40);
        make.width.equalTo(@100);
    }];
}

@end
