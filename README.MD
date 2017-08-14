![Release](https://img.shields.io/github/release/DingSoung/Model-Cache.svg)
![Status](https://travis-ci.org/DingSoung/Model-Cache.svg?branch=master)
![CocoaPods](https://img.shields.io/cocoapods/v/ModelCache.svg)
![Carthage](https://img.shields.io/badge/Carthage-compatible-yellow.svg?style=flat)
![Language](https://img.shields.io/badge/Swift-3.1-FFAC45.svg?style=flat)
![Platform](http://img.shields.io/badge/Platform-iOS-E9C2BD.svg?style=flat)
[![Donate](https://img.shields.io/badge/Donate-PayPal-9EA59D.svg)](https://paypal.me/DingSongwen)

### 安装
#### Carthage

add code below to your Cartfile and command `carthage update`

```
github "DingSoung/Model-Cache"
```

#### Cocoa Pod

add pod file below and command `pod update`

```
platform :ios, ‘8.0’
use_frameworks!
target 'AppStore' do
	pod	'ModelCache'
end
```

### 缓存设计

* 线程安全
* 支持读写
* 写入自动创建文件夹
* 支持删除单个文件或目录
* 支持内存加速
* 支持读取失败回调(延迟)
* 支持返回写、删失败详情信息

### 用法

```objective-c
UserModel *user = [UserModel cacheForKeyPath:@"/users/uid03879658" fail:^(NSError * _Nonnull error) {
    NSLog(@"%@", error);
}];
NSError *err1 = [UserModel removeCacheForKeyPath:@"/users/uid03879658"];
NSError *err2 = [UserModel removeCacheForPath:@"/users"];
```

高级用法参考[这里](https://github.com/DingSoung/Example)
