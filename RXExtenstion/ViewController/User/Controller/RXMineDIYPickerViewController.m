//
//  RXMineDIYPickerViewController.m
//  RXExtenstion
//
//  Created by srxboys on 2018/2/7.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXMineDIYPickerViewController.h"



#import "RXMineDIYItemView.h"
#import "RXPickerView.h"

#import "RXRandom.h"

@interface RXMineDIYPickerViewController ()
{
    RXPickerView * _pickerView;
}
@end

@implementation RXMineDIYPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DIY picker";
    
    self.nomalShowLabel.hidden = NO;
    
    [self configUI];
}

- (void)configUI {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, self.navigationHeight + 20, 300, 40);
    [btn setTitle:@" click there " forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor purpleColor];
    [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)buttonClick {
    NSMutableArray * items = [NSMutableArray new];
    _pickerView = RXPickerView_alloc;
    _pickerView.itemHeight = RXMineDIYItemView_height;
//    _pickerView.numberOfComponents = 2;
    
    for(NSInteger i = 0; i < arc4random()%5+5; i++) {
        RXMineDIYItem * component = [RXMineDIYItem new];
        component.key = IntTranslateStr(i);
        component.value = [RXRandom randomChinasWithinCount:5];
        component.valueColor = UIColorRandom;
        component.subValue = [RXRandom randomChinasWithinCount:10];
        component.subValueColor = UIColorRandom;
        [items addObject:component];
    }
    
    _pickerView.items = items;
    [_pickerView setItemViewBlock:^UIView *(UIView *reusingView, RXMineDIYItem * item, NSArray * selectedComponents) {
        //复用
        RXMineDIYItemView *itemView = (RXMineDIYItemView *)reusingView;
        if (!itemView) {
            itemView = [RXMineDIYItemView new];
        }
        itemView.key = item.key;
        itemView.value = item.value;
        itemView.subValue = item.subValue;
        itemView.valueColor = item.valueColor;
        itemView.subValueColor = item.subValueColor;
        return itemView;
    }];
    
   
    
    
    //点击完成按钮的回调block
    [_pickerView showWithDoneBlock:^(NSInteger index, RXMineDIYItem * item, NSArray * selectedComponents) {
        NSLog(@"click row=%zd, item.key=%@", index, item.key);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
