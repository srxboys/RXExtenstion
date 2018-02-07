//
//  RXMineDIYItemView.h
//  RXExtenstion
//
//  Created by srxboys on 2018/2/7.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RXMineDIYItemView_height 50

@interface RXMineDIYItem : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *subValue;
@property (nonatomic, copy) UIColor  *valueColor;
@property (nonatomic, copy) UIColor  *subValueColor;
@end



@interface RXMineDIYItemView : UIView
/*
    为什么重写上面的属性，直接把上面作为属性不就好了 ❓
 答:
    为了以后着想，下面可能会有别的样式，而属性又不止这些，样式就可以多样化
    我以前的写法都是死的，这次搞个活的view。很考验逻辑的理解性。
 */
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *subValue;
@property (nonatomic, copy) UIColor  *valueColor;
@property (nonatomic, copy) UIColor  *subValueColor;

@property (nonatomic, copy, readonly) UILabel * titleLabel;
@property (nonatomic, copy, readonly) UILabel * valueLabel;
@property (nonatomic, copy, readonly) UILabel * subValueLabel;
@end
