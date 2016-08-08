//
//  RXThreeLinkageAddress.m
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
// 3 级联动地址

#import "RXThreeLinkageAddress.h"
#import "RXGetArea.h"

#define viewAnimal 0.3

#define ButtonLeft 18

@interface RXThreeLinkageAddress ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIView * _keyBoardView;
    
    UIPickerView * _pickerView;
    
    UIView * _backView;
    
    CGRect _viewHiddenFrame;
    CGRect _viewShowFrame;
    
    //--------结果----------------
    
    BOOL isLoadData;
    
    
    NSInteger provinceLine, cityLine, areaLine;
    NSArray * allCities;
    NSString * addressCode;
    
    BOOL isFist;
    
}

@end

@implementation RXThreeLinkageAddress
- (void)show {
    self.hidden = NO;
    
    [UIView animateWithDuration:viewAnimal animations:^{
        _backView.alpha = 0.4f;
        _keyBoardView.frame = _viewShowFrame;
    } completion:^(BOOL finished) {
        
    }];
}


- (void)hidden {
    [UIView animateWithDuration:viewAnimal animations:^{
        _backView.alpha = 0;
        _keyBoardView.frame  = _viewHiddenFrame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _viewHiddenFrame = CGRectMake(0, frame.size.height * 2 , frame.size.width, 216 + 44);
        _viewShowFrame = CGRectMake(0, frame.size.height - 216 - 44, frame.size.width, 216 + 44);
        
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        
        
        self.layer.masksToBounds = NO;
        
        _backView = [[UIView alloc] initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.0f;
        _backView.userInteractionEnabled = NO;
        [self addSubview:_backView];
        
        [self configPicker];
    }
    return self;
}

- (void)configPicker {
    
    _keyBoardView = [[UIView alloc] initWithFrame:_viewHiddenFrame];
    _keyBoardView.backgroundColor = UIColorHexStr(@"EEEEEE");
    [self addSubview:_keyBoardView];
    
    
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(ButtonLeft, 0, _viewHiddenFrame.size.width / 2.0 - ButtonLeft, 44);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:UIColorHexStr(@"333333") forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    cancelButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_keyBoardView addSubview:cancelButton];
    
    UIButton * trueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    trueButton.frame = CGRectMake(_viewHiddenFrame.size.width/2.0, 0, _viewHiddenFrame.size.width/2.0 - ButtonLeft, 44);
    [trueButton setTitle:@"确定" forState:UIControlStateNormal];
    [trueButton setTitleColor:UIColorHexStr(@"333333") forState:UIControlStateNormal];
    [trueButton addTarget:self action:@selector(trueButtonClick) forControlEvents:UIControlEventTouchUpInside];
    trueButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    trueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    trueButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_keyBoardView addSubview:trueButton];
    
    
    
//        NSString* path =
//        [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
//    
//        if(path.length <= 0) {
//            addressCode = @"0";
//            return;
//        }
//    
//        NSData* data = [NSData dataWithContentsOfFile:path];
//        id JsonObject =
//        [NSJSONSerialization JSONObjectWithData:data
//                                        options:NSJSONReadingAllowFragments
//                                          error:nil];
//        allCities = [[NSArray arrayWithObject:JsonObject] objectAtIndex:0];
    allCities = [RXGetArea getAreaArray];
    provinceLine = 0;
    cityLine = 0;
    areaLine = 0;
    
    isFist = YES;
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 216)];
    _pickerView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator = YES;
    [_keyBoardView addSubview:_pickerView];
    
    
    //    CALayer *viewLayer = _pickerView.layer;
    //    [viewLayer setBounds:CGRectMake(0.0, 0.0, 125.0, 132.0)];
    //    [viewLayer setBackgroundColor:[UIColor whiteColor].CGColor];
    //    [viewLayer setContentsRect:CGRectMake(0.0, 0.0, 115.0, 112.0)];
    //    [viewLayer setBorderWidth:2.0];
    //    [viewLayer setBorderColor:[UIColor redColor].CGColor];
    
    
    [_pickerView reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [allCities count];
    } else if (component == 1) {
        NSArray* array =
        [[allCities objectAtIndex:provinceLine] objectForKey:@"children"];
        return [array count];
    } else {
        NSArray* arr =
        [[allCities objectAtIndex:provinceLine] objectForKey:@"children"];
        NSArray* array = [arr[cityLine] objectForKey:@"children"];
        return [array count];
    }
}
- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row  forComponent:(NSInteger)component {
    if (component == 0) {
        return [[allCities objectAtIndex:row] objectForKey:@"name"];
    } else if (component == 1) {
        NSArray* arr =
        [[allCities objectAtIndex:provinceLine] objectForKey:@"children"];
        return [[arr objectAtIndex:row] objectForKey:@"name"];
    } else {
        NSArray* arr =
        [[allCities objectAtIndex:provinceLine] objectForKey:@"children"];
        NSArray* array = [[arr objectAtIndex:cityLine] objectForKey:@"children"];
        return [[array objectAtIndex:row] objectForKey:@"name"];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return  44;
}

- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row  inComponent:(NSInteger)component {
    if (component == 0) {
        provinceLine = row;
        cityLine = 0;
        areaLine = 0;
        [_pickerView selectRow:0 inComponent:1 animated:YES];
        [_pickerView reloadComponent:1];
        [_pickerView selectRow:0 inComponent:2 animated:YES];
        [_pickerView reloadComponent:2];
        
        isFist = NO;
    } else if (component == 1) {
        cityLine = row;
        areaLine = 0;
        [_pickerView selectRow:0 inComponent:2 animated:YES];
        [_pickerView reloadComponent:2];
    } else {
        areaLine = row;
    }
    
    [self resultAddress];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self trueButtonClick];
}

- (void)cancelButtonClick {
    self.isShow(false, @"", @"");
    [self hidden];
}

- (void)trueButtonClick {
    
    if(isFist) {
        [self resultAddress];
    }
    self.isShow(true,  _addressString, addressCode);
    
    [self hidden];
}

- (void)resultAddress{
    
    NSArray* arr = [[allCities objectAtIndex:provinceLine] objectForKey:@"children"];
    
    
    NSArray* array = [[arr objectAtIndex:cityLine] objectForKey:@"children"];
    
    
    if ([[array objectAtIndex:areaLine] objectForKey:@"name"] == nil) {
        
        _addressString = [NSString stringWithFormat:@"%@ %@",
                          allCities[provinceLine][@"name"],
                          arr[cityLine][@"name"]];
        
        addressCode = arr[cityLine][@"code"];
        
    } else {
        _addressString = [NSString  stringWithFormat:@"%@ %@ %@",
                          allCities[provinceLine][@"name"],
                          arr[cityLine][@"name"],
                          array[areaLine][@"name"]];
        
        addressCode = array[areaLine][@"code"];
    }
    
    
    // 实时 返回数据
    //    self.isShow(true,  _addressString, addressCode);
    
}

@end
