//
//  RXPickerView.m
//  RXExtenstion
//
//  Created by srxboys on 2018/2/6.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#define PICK_CONTENT_HEIGHT 260
#define PICK_TOOLBAR_HEIGHT 44
#define PICK_HEIGHT PICK_CONTENT_HEIGHT-PICK_TOOLBAR_HEIGHT

#import "RXPickerView.h"

@interface RXPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView * _pickerView;
    
    UIButton * _bgButton;
    UIView * _contentView;
    NSMutableArray * _selectedComponents;
    
    BOOL _isSET_itemWidth;
}
@end



@implementation RXPickerView

+ (instancetype)PickerView {
    return [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    self.backgroundColor = [UIColor clearColor];
    _itemWith = [UIScreen mainScreen].bounds.size.width;
    _itemHeight = 40;
    self.numberOfComponents = 1;
    _selectedComponents = [NSMutableArray arrayWithCapacity:1];
    
    self.selectionIndicatorColor = UIColorRandom;
    
    CGSize size = self.bounds.size;
    _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _bgButton.frame = self.bounds;
    _bgButton.exclusiveTouch = YES;
    _bgButton.hidden = YES;
    [_bgButton addTarget:self action:@selector(okItemClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bgButton];
    
    _contentView = [UIView new];
    _contentView.frame = CGRectMake(0, size.height, size.width, size.height-PICK_CONTENT_HEIGHT);
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(_contentView), PICK_TOOLBAR_HEIGHT)];
    UIBarButtonItem *spacerItemFixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacerItemFixed.width = 10;
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemClicked)];
    UIBarButtonItem *spacerItemCenter = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(okItemClicked)];
    toolbar.items = @[spacerItemFixed, cancelItem, spacerItemCenter, okItem, spacerItemFixed];
    [_contentView addSubview:toolbar];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, PICK_TOOLBAR_HEIGHT, ViewWidth(_contentView), PICK_HEIGHT)];
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [_contentView addSubview:_pickerView];
}

- (void)setItemSize:(CGSize)size {
    _itemWith = size.width;
    _itemHeight = size.height;
}

- (void)setItems:(NSArray *)items {
    _items = items;
    [_pickerView reloadAllComponents];
}


- (void)show {
    if(!self.superview) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow ?: [[UIApplication sharedApplication].delegate window];
        [window addSubview:self];
    }
    
    if(self.selectionIndicatorColor) {
        for(UIView * view in _pickerView.subviews) {
            CGFloat height = ViewHeight(view);
            if(height <2) {
                SET_VIEW_HEIGHT(view, 0.2);
                view.backgroundColor = self.selectionIndicatorColor;
            }
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.frame = CGRectMake(0, ViewHeight(self)-PICK_CONTENT_HEIGHT, ViewWidth(self), PICK_CONTENT_HEIGHT);
    } completion:^(BOOL finished) {
        _bgButton.hidden = NO;
    }];
}

- (void)showWithDoneBlock:(void (^)(NSInteger index, id item, NSArray * selectedComponents))doneBlock {
    self.doneBlock = doneBlock;
    [self show];
}

- (void)cancelItemClicked {
    [self dismiss];
}

- (void)okItemClicked {
    [self dismiss];
    
    _selectedIndex = [_pickerView selectedRowInComponent:0];
    if (self.doneBlock) {
        id item = self.items[_selectedIndex];
        self.doneBlock(_selectedIndex, item, _selectedComponents);
    }
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.frame = CGRectMake(0, ViewHeight(self), ViewWidth(self), PICK_CONTENT_HEIGHT);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _bgButton.hidden = YES;
    }];
}


- (void)setSelectedIndex:(NSInteger)index {
    if (index < 0 || index >= [self.items count])
        return;
    
    [_pickerView selectRow:index inComponent:0 animated:NO];
    
    _selectedIndex = index;
}

- (void)selectItem:(id)item {
    if (!item)
        return;
    
    __block NSInteger index = 0;
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqual:item]) {
            index = idx;
            *stop = YES;
        }
    }];
    [_pickerView selectRow:index inComponent:0 animated:NO];
}

#pragma mark - UIPickerView Data Source & Delegate

- (void)setNumberOfComponents:(NSInteger)numberOfComponents {
    _numberOfComponents = numberOfComponents;
    _selectedComponents = [NSMutableArray arrayWithCapacity:numberOfComponents];
    for(NSInteger i = 0; i<numberOfComponents; i++) {
        _selectedComponents[i] = @(0);
    }
    if(!_isSET_itemWidth) {
        _itemWith = ScreenWidth/numberOfComponents*1.0;
    }
}

- (void)setItemWith:(CGFloat)itemWith {
    _itemWith = itemWith;
    _isSET_itemWidth = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return _numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.items.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if (self.itemViewBlock) {
        UIView * reusingView = self.itemViewBlock(view, self.items[row], _selectedComponents);
        return reusingView;
    }
    return nil;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.itemWith;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.itemHeight;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(!_selectedComponents) return;
    if(_selectedComponents.count < component) {
        [_selectedComponents addObject:@(row)];
    }
    else {
        _selectedComponents[component] = @(row);
    }
}


@end
