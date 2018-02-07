//
//  RXPickerView.h
//  RXExtenstion
//
//  Created by srxboys on 2018/2/6.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//
// 所有view样式，需要外部给，内部不写死了

#import <UIKit/UIKit.h>

#define RXPickerView_alloc [RXPickerView PickerView]

@interface RXPickerView : UIView

/* 只是初始化，不是单例 */
+ (instancetype)PickerView;

/* default UIScreen.bounds.size.width */
@property (nonatomic, assign) CGFloat itemWith;
/* default height 40 */
@property (nonatomic, assign) CGFloat itemHeight;

/* setting  itemWith and itemheight */
- (void)setItemSize:(CGSize)size;

/*  设置选择第几个item */
@property (nonatomic, assign) NSInteger selectedIndex;

/* default numberOfComponentsInPickerView 1 */
@property (nonatomic, assign) NSInteger numberOfComponents;
//----------------------------------------------------------------

/* 所有 picker 的 views 或者 数据模型,设置所有上面的在设置此属性  */
@property (nonatomic, copy)NSArray * items;

/* selected area line color ; default color=UIColorRandom  */
@property (nonatomic, copy) UIColor *selectionIndicatorColor;


/* 数据模型对应的 (可复用的)view  */
@property(nonatomic, copy) UIView *(^itemViewBlock)(UIView *reusingView, id item, NSArray * selectedComponents);

/*  点击完成按钮的回调block */
@property(nonatomic, copy) void (^doneBlock)(NSInteger index, id item, NSArray * selectedComponents);


/* select items in item */
- (void)selectItem:(id)item;

/*  !self.superview : show in [UIApplication sharedApplication].keyWindow. if keyWindow==nil keyWindow=delegate.window */
- (void)show;
- (void)showWithDoneBlock:(void (^)(NSInteger index, id item, NSArray * selectedComponents))doneBlock;

/* self remove from keywindow */
- (void)dismiss;

@end


/*
 
 【 use: 】
 
 NSMutableArray *items = [NSMutableArray array];
 
 RXPickerView * pickerView = RXPickerView_alloc;
 
 //setting items 赋值告诉picker有多少个数据元素 (可以是字符串、数据模型等)
 for(...) {
     ...do some thing...
     [items addObject: NSString/NSObject ];
 }
 
 //刷新 UI
 pickerView.items = items;
 
 
 //复用view 、 UI布局   并赋值
 [pickerView setItemViewBlock:^UIView *(UIView *reusingView, NSString/NSObject *item) {
     PickItemView *itemView = (PickItemView *)reusingView;
     if (itemView == nil) {
     itemView = [[PickItemView alloc] init];
 
     ...do some thing...
     and so   itemView... = item...
 
     return itemView;
 }
 
 //如果需要默认值
 pickerView.selectedIndex = self.selectedIndex;
 
 //显示 并 把结果带回
 [pickerView showWithDoneBlock:^(NSInteger index, CouponItem *item) {
      ...do some thing...
 }];
 
 */



