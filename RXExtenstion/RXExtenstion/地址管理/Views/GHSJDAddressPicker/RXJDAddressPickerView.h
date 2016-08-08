//
//  RXJDAddressPickerView.h
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
// 仿照京东5.1.0 收货地址


#import <UIKit/UIKit.h>


typedef void(^JDPickerShowOrHidden)(NSString *address, NSString * addressCode);

@interface RXJDAddressPickerView : UIView

//block回传
@property (nonatomic, copy) JDPickerShowOrHidden completion;

- (void)showAddress;

@end


/**
    目前 city.json 里的收货地址是3级的
 
    如果想要做出更多级数的地址，就把此.m文件 中的 _addressScrollView变成UICollectionView 里面还是 UITableView。【注意:tableView里面的注册cell信息】
 */



