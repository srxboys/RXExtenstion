# RXExtenstion
# iOS 项目基本框架
### `收货地址 地区 选择样式`
```objc
//导入封装的UIView
#import "RXOneLinkageTreeAddress.h"
#import "RXThreeLinkageAddress.h"
#import "RXJDAddressPickerView.h"

//初始化 并 实现block回调方法
    weak(weakSelf);

    _onePicker = [[RXOneLinkageTreeAddress alloc] init];
    _onePicker.isShow = ^ (BOOL isShow, NSString *address, NSString * addressCode){
    RXLog(@"_onePicker\nisShow=%@, address=%@, addressCode=%@\n\n", isShow ? @"是" : @"否`", address, addressCode);

    weakSelf.addressLabel.text = [NSString stringWithFormat:@"_onePicker isShow=%@, address=%@, addressCode=%@", isShow ? @"是" : @"否`", address, addressCode];
    };



    _twoPicker = [[RXThreeLinkageAddress alloc] init];
    _twoPicker.isShow = ^ (BOOL isShow, NSString *address, NSString * addressCode){
    RXLog(@"_twoPicker\nisShow=%@, address=%@, addressCode=%@\n\n", isShow ? @"是" : @"否", address, addressCode);

    weakSelf.addressLabel.text = [NSString stringWithFormat:@"_twoPicker  isShow=%@, address=%@, addressCode=%@", isShow ? @"是" : @"否", address, addressCode];

    };


    _threePicker = [[RXJDAddressPickerView alloc] init];
    _threePicker.completion = ^(NSString *address, NSString * addressCode){
    RXLog(@"_threePicker\n, address=%@, addressCode=%@\n\n", address, addressCode);

    weakSelf.addressLabel.text = [NSString stringWithFormat:@"_threePicker , address=%@, addressCode=%@", address, addressCode];
    };

    // -- 我的项目 是把 这些 添加 appDelegate.windows --


//调用 收货地址 选择 省/市/区 显示控件
    // 1级 3联动
    [_onePicker showAddressView];

    // 3级联动
    [_twoPicker show];

    //仿照京东v1.5.0
    [_threePicker showAddress];

```
###看看效果
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/address/address.gif)