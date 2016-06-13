# RXExtenstion
# iOS 项目基本框架
### `字符处理 、数组、 字典 -> 空处理`
```objc
    #import "RXCharacter.h"
    @implementation RXCaCheController
    - (void)viewDidLoad {
    [super viewDidLoad];

    NSString * string = @"https://github.com/srxboys";

    if([string strBOOL]) {
    //是否为字符串
    }

    if([string urlBOOL]) {
    //是否为 网址
    }

    if([string arrBOOL]) {
    //是否为 数组
    }

    //参数 空处理
    string = @"0"; // or --> string = @"<null>"
    NSString * dictionaryValue = [string strNotEmptyValue];
    RXLog(@"dictValue=%@", dictionaryValue);
    }
    @end
```