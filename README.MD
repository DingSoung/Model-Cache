![Release](https://img.shields.io/github/release/DingSoung/Cache.svg)
![Status](https://travis-ci.org/DingSoung/Model-Cache.svg?branch=master)

![CocoaPods](https://img.shields.io/cocoapods/v/Cache.svg)
![Carthage](https://img.shields.io/badge/Carthage-compatible-yellow.svg?style=flat)
![SwiftPackage](https://img.shields.io/badge/SwiftPackage-compatible-E66848.svg?style=flat)

![Language](https://img.shields.io/badge/Swift-4.1-FFAC45.svg?style=flat)
![Platform](http://img.shields.io/badge/Platform-iOS|tvOS|macOS|watchOS-E9C2BD.svg?style=flat)

[![Donate](https://img.shields.io/badge/Donate-PayPal-9EA59D.svg)](https://paypal.me/DingSongwen)

### 安装
#### Carthage

add code below to your Cartfile and command `carthage update`

```shell
github "DingSoung/Cache"
```

#### Swift Package Manager

follow the [SPMExample](https://github.com/DingSoung/SPMExample), UIKit excluded

```swift
import PackageDescription
let package = Package(
    name: "SPMExample",
    dependencies: [
        .Package(url: "https://github.com/DingSoung/Cache.git", Version(0,4,0)),
    ]
)
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
