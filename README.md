# GreedTimer

[![CI Status](http://img.shields.io/travis/greedlab/GreedTimer.svg?style=flat)](https://travis-ci.org/greedlab/GreedTimer)
[![Version](https://img.shields.io/cocoapods/v/GreedTimer.svg?style=flat)](http://cocoapods.org/pods/GreedTimer)
[![License](https://img.shields.io/cocoapods/l/GreedTimer.svg?style=flat)](http://cocoapods.org/pods/GreedTimer)
[![Platform](https://img.shields.io/cocoapods/p/GreedTimer.svg?style=flat)](http://cocoapods.org/pods/GreedTimer)

GCD Timer for iOS

## Usage

```objc
        GRTimer *timer = [[GRTimer alloc] init];
        __weak __typeof(GRTimer *)weakTimer = timer;
        timer.action = ^{
            [weakSelf timer1Changed:weakTimer];
        };
        self.key1 = timer.key;
        [[GRTimerManager sharedInstance] addAndRunTimer:timer];
```

## develop

```shell
$ pod lib create GreedTimer --template-url=git@github.com:GreedBell/pod-template.git
$ cd GreedTimer
$ pod update --no-repo-update --project-directory=Example/
$ pod lib lint GreedTimer.podspec --verbose
$ pod trunk push GreedTimer.podspec
```

## Installation

GreedTimer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GreedTimer"
```

## Thanks

* [选择 GCD 还是 NSTimer ？](http://www.jianshu.com/p/0c050af6c5ee)

## License

GreedTimer is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
