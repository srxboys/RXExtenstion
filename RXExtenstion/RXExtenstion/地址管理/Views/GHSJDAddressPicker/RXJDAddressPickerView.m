//
//  RXJDAddressPickerView.m
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
// 仿照京东5.1.0 收货地址

#import "RXJDAddressPickerView.h"
#import "RXJDTableCell.h"
#import "RXGetArea.h"
#import "AppDelegate.h"
#import "RXJDButton.h"


#define Black_alpha_show 0.4 //背景黑 0.4透明
#define Black_alpha_hidde 0  //背景黑 透明
#define ViewAnimal 0.3   //动画执行时间
#define AddressSpace 30 //选择后的地址 之间间隔
#define SelectLabelHeight 15 //请选择label 高度
#define SelectLabelTop 19 //请选择label y
#define SelectLineWidth 42 //请选择label 下面紫色线 的 宽度

#define tableToTop 8

@interface RXJDAddressPickerView ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    CGRect           _viewHiddenFrame;
    CGRect           _viewShowFrame;
    
    UIControl      * _blackControl;
    UIView         * _showView;
    
    NSInteger        _provinceLine,     _cityLine,    _areaLine; //省/市/区
    NSInteger        _provineceVisible, _cityVisible, _areaVisible; //可见cell的y == tableView.contentOffsey.y
    NSString       * _addressString, * _addressCode;
    NSInteger        _selfSelectCount; //第几级菜单
    
    RXJDButton     * _provinceButton,  * _cityButton, *_areaButton;
    
    UIButton       * _closeButton; //关闭
    
    UIScrollView   * _selectScrollView; //请选择上的横滚动
    CGFloat          _selectScrollViewHeight; //请选择上的横滚动 高度
    UIScrollView   * _addressScrollView; //地址选择的横滚动
    CGFloat          _addressHeight; //地址选择的横滚动 高度
    NSMutableArray * _buttonsArray;
    CGFloat          _buttonsLasterLeft;
    
    UITableView    * _provinceTableView; //省份 Table
    NSArray        * _provinceArray;
    
    UITableView    * _cityTableView; //城市 Table
    NSArray        * _cityArray; //城市 数据源
    
    UITableView    * _areaTableView;//地区 Table
    NSArray        * _areaArray;
    
    UIButton       * _selectButton; //请选择
    UIView         * _selectLineView;//请选择 线
    CGFloat          _selectLineViewLeft;//请选择 线 的  x坐标
    
    CGFloat          _selfHeight; //self 高度
    NSInteger        _selfLevel_isHidden;
    
    
    BOOL             _selfNotFirstShow;
    BOOL             _selfNot3LeveSave;
}
@end

@implementation RXJDAddressPickerView
/** 初始化 self */
#pragma mark - ~~~~~~~~~~~ 初始化 self ~~~~~~~~~~~~~~~
- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
        
//        _selfHeight = 216 + 44;
        _selfHeight = ActureHeight(310);
        
        _viewHiddenFrame = CGRectMake(0, frame.size.height * 2 , frame.size.width, _selfHeight);
        _viewShowFrame = CGRectMake(0, frame.size.height - _selfHeight, frame.size.width, _selfHeight);
        
        _blackControl = [[UIControl alloc] initWithFrame:self.bounds];
        _blackControl.backgroundColor = [UIColor blackColor];
        _blackControl.alpha = Black_alpha_hidde;
        [_blackControl addTarget:self action:@selector(hiddenAddress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_blackControl];
        
        _showView = [[UIView alloc] initWithFrame:_viewHiddenFrame];
        _showView.backgroundColor = [UIColor whiteColor];
        _showView.userInteractionEnabled = YES;
        [self addSubview:_showView];
        
        _selfNotFirstShow = NO;
        _selfNot3LeveSave = NO;
        
        [self configUI];
    }
    return self;
}
/** 初始化 内部控件 */
#pragma mark - ~~~~~~~~~~~ 初始化 内部控件 ~~~~~~~~~~~~~~~
- (void)configUI {
    CGFloat top = 40;
    //标题
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 20)];
    titleLabel.text = @"所在地区";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = UIColorHexStr(@"333333");
    titleLabel.backgroundColor = [UIColor clearColor];
    [_showView addSubview:titleLabel];

    
    CGFloat closebuttonWH = 22;
    //关闭
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.frame = CGRectMake(ScreenWidth - 20 - 20 - closebuttonWH, 0, closebuttonWH + 20 + 20, closebuttonWH + 20);
    _closeButton.contentVerticalAlignment   = UIControlContentVerticalAlignmentBottom;
    _closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_closeButton setImage:[UIImage imageNamed:@"pic_close"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(hiddenAddress) forControlEvents:UIControlEventTouchUpInside];
    _closeButton.backgroundColor = [UIColor clearColor];
    [_showView addSubview:_closeButton];
    
    
    
    _selectScrollViewHeight = 40; //高度
    
    //横线 通宽的
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, top + _selectScrollViewHeight - 0.5, ScreenWidth, 0.5)];
    lineView.backgroundColor = UIColorHexStr(@"EDEDED");
    [_showView addSubview:lineView];
    
    //请选择上的横滚动
    _selectScrollView = [self configScrollDefaultWithTop:top height:_selectScrollViewHeight];
    _selectScrollView.backgroundColor = [UIColor clearColor];
    [_showView addSubview:_selectScrollView];
    
    _buttonsArray = [[NSMutableArray alloc] init];

    
    //请选择
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectButton.frame = CGRectMake(21, SelectLabelTop, 100, SelectLabelHeight);
    [_selectButton setTitle:@"请选择" forState:UIControlStateNormal];
    [_selectButton setTitleColor:UIColorHexStr(@"ef0000") forState:UIControlStateNormal];
    _selectButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _selectButton.backgroundColor = [UIColor whiteColor];
    _selectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_selectButton addTarget:self action:@selector(selectInputButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_selectScrollView addSubview:_selectButton];
    
    
    //选中 线
    _selectLineView = [[UIView alloc] initWithFrame:CGRectMake(19, _selectScrollViewHeight - 2 , SelectLineWidth, 2)];
    _selectLineView.backgroundColor = UIColorHexStr(@"ef0000");
    [_selectScrollView addSubview:_selectLineView];
    
    top += _selectScrollViewHeight;
    
    _addressHeight = _selfHeight - top;
    _addressScrollView = [self configScrollDefaultWithTop:top height:_addressHeight];
    _addressScrollView.pagingEnabled = YES;
    [_showView addSubview:_addressScrollView];
    
    //省份 列表
    _provinceTableView = [self configTableDefaultWithHeight:_addressHeight andIndex:1];
    [_provinceTableView registerClass:[RXJDTableCell class] forCellReuseIdentifier:@"cell_province"];
    [_addressScrollView addSubview:_provinceTableView];
    
    //城市 列表
    _cityTableView = [self configTableDefaultWithHeight:_addressHeight andIndex:2];
    [_cityTableView registerClass:[RXJDTableCell class] forCellReuseIdentifier:@"cell_city"];
    [_addressScrollView addSubview:_cityTableView];
    
    //地区 列表
    _areaTableView = [self configTableDefaultWithHeight:_addressHeight andIndex:3];
    [_areaTableView registerClass:[RXJDTableCell class] forCellReuseIdentifier:@"cell_area"];
    [_addressScrollView addSubview:_areaTableView];
    
    _provinceLine     = 0; _cityLine    = 0;  _areaLine    = 0;
    _provineceVisible = 0; _cityVisible = 0;  _areaVisible = 0;
    _selfSelectCount  = 0;
    
    _buttonsLasterLeft = 21;
    _selectLineViewLeft = 21;
    
    _provinceArray = [RXGetArea getAreaArray];
    
    _selfLevel_isHidden = 3;
    
}
/** 通用初始化 scrollView */
#pragma mark - ~~~~~~~~~~~ 通用初始化 scrollView ~~~~~~~~~~~~~~~
- (UIScrollView *)configScrollDefaultWithTop:(CGFloat)top height:(CGFloat)height {
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, top, ScreenWidth, height)];
    scrollView.contentSize = CGSizeMake(ScreenWidth, height);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    return scrollView;
}
/** 通用初始化 tableView */
#pragma mark - ~~~~~~~~~~~ 通用初始化 tableView ~~~~~~~~~~~~~~~
- (UITableView *)configTableDefaultWithHeight:(CGFloat)height andIndex:(NSInteger)index {
    UITableView * table = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth * (index - 1), 0, ScreenWidth * index, height) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [[UIView alloc] init];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = [UIColor clearColor];
    table.contentInset = UIEdgeInsetsMake(tableToTop, 0, 0, 0);
    return table;
}


/** 恢复默认初始化，重新选择地址 */
#pragma mark - ~~~~~~~~~~~ 恢复默认初始化，重新选择地址 ~~~~~~~~~~~~~~~
- (void)configAddressClear {
    _provinceLine     = 0; _cityLine    = 0;  _areaLine    = 0;
    _provineceVisible = 0; _cityVisible = 0;  _areaVisible = 0;
    _selfSelectCount  = 0; //选择 0级 地址
    
    _buttonsLasterLeft = 21;
    _selectLineViewLeft = 21;
    
    _selfSelectCount = 1;
    _selfNotFirstShow = NO;
    _selectButton.hidden = NO;
    _selectButton.frame = CGRectMake(21, SelectLabelTop, 100, SelectLabelHeight);
    _selectLineView.frame = CGRectMake(21, _selectScrollViewHeight - 2 , SelectLineWidth, 2);
    
    _cityArray = nil;
    _areaArray = nil;


    NSInteger btnsCount = _buttonsArray.count;
    for(NSInteger i = 0; i < btnsCount; i ++) {
        RXJDButton * btn = _buttonsArray[0];
        [btn removeFromSuperview];
        [_buttonsArray removeObjectAtIndex:0];
        btn = nil;
    }
    
    _addressScrollView.contentSize = CGSizeMake(ScreenWidth, _addressHeight);
    [_provinceTableView reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if(scrollView == _selectScrollView) {
        //选择
    }
    else if(scrollView == _addressScrollView) {
        //地区
        
        CGFloat page = offsetX / ScreenWidth * 1.0;
        //floor 取整函数
        CGFloat page_point = (page - floor(page));
//        TTLog(@"offsetX=%f==page=%f==page_point=%f", offsetX, page, page_point);
        //lroundf 四舍五入，取最接近的整数
        if(lroundf(page_point * 1000) == 0) {
            
            CGFloat lineLeft = _selectLineViewLeft;
            CGFloat lineWidth = SelectLineWidth;
            NSInteger pageNum = floor(page);
            if(_buttonsArray.count > pageNum) {
                RXJDButton * btn = (RXJDButton *)_buttonsArray[pageNum];
                lineLeft = btn.left;
                lineWidth = btn.width;
                
                if(pageNum == 0) {
                    _provinceTableView.contentOffset = CGPointMake(0, _provineceVisible);
                }
                else if(pageNum == 1) {
                    _cityTableView.contentOffset = CGPointMake(0, _cityVisible);
                }
                else if(pageNum == 2) {
                    _areaTableView.contentOffset = CGPointMake(0, _areaVisible);
                }
            }
            
            [UIView animateWithDuration:ViewAnimal animations:^{
                _selectLineView.frame = CGRectMake(lineLeft, _selectScrollViewHeight - 2, lineWidth, 2);
            } completion:^(BOOL finished) {
                
            }];
        }
        
    }
}

#pragma mark - ~~~~~~~~~~~ tableView Data Delegate ~~~~~~~~~~~~~~~
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == _provinceTableView) {
        return _provinceArray.count;
    }
    else if(tableView == _cityTableView) {
         return _cityArray.count;
    }
    else if(tableView == _areaTableView) {
         return _areaArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = nil;
    
    NSString * titleString = @"";
    BOOL       isSelectedBOOL = NO;
    NSInteger  row = indexPath.row;
    
    if(tableView == _provinceTableView) {
        cellIdentifier = @"cell_province";
        //判断
        if(_selfSelectCount > 0 && row == _provinceLine) {
            isSelectedBOOL = YES;
        }
        titleString = [[_provinceArray objectAtIndex:row] objectForKey:@"name"];
        
        
    }
    else if(tableView == _cityTableView) {
        cellIdentifier = @"cell_city";
        //判断
        if(_selfSelectCount > 1 && row == _cityLine) {
            isSelectedBOOL = YES;
        }
       
    
        titleString = [[_cityArray objectAtIndex:row] objectForKey:@"name"];
        
    }
    else if(tableView == _areaTableView) {
        cellIdentifier = @"cell_area";
        //判断
        if(_selfSelectCount > 2 && row == _areaLine) {
            isSelectedBOOL = YES;
        }


        titleString = [[_areaArray objectAtIndex:row] objectForKey:@"name"];
    }
    
    RXJDTableCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setCellTitle:titleString isSelected:isSelectedBOOL];
//    cell.contentView.backgroundColor = [GHSRandom randomColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //省名
    NSString * name = @"";
    
    NSInteger row = indexPath.row;
    
    if(tableView == _provinceTableView) {
        _selfSelectCount = 1;
        _provinceLine = row;
        _selfNotFirstShow = NO;
        
       name = [[_provinceArray objectAtIndex:row] objectForKey:@"name"];
        //城市数组
        _cityArray = _provinceArray[_provinceLine][@"children"];
        
        [_provinceTableView reloadData];
        [_cityTableView reloadData];
        
        
        [self changeScrollViewWithCount:2];
        
        RXJDTableCell * cell = tableView.visibleCells[0];
        _provineceVisible = ViewY(cell) - tableToTop;
        
    }
    else if(tableView == _cityTableView) {
        _selfSelectCount = 2;
        _cityLine = row;
        _selfNotFirstShow = NO;
        
        name = [[_cityArray objectAtIndex:row] objectForKey:@"name"];
        
        //区的
        _areaArray = _cityArray[_cityLine][@"children"];
        
        [_cityTableView reloadData];
        [_areaTableView reloadData];
        [self changeScrollViewWithCount:3];
        
        RXJDTableCell * cell = tableView.visibleCells[0];
        _cityVisible = ViewY(cell) - tableToTop;
    }
    else if(tableView == _areaTableView) {
        _selfSelectCount = 3;
        _areaLine = row;
        _selfNotFirstShow = YES;
        _selfNot3LeveSave = YES;
        
        name = [[_areaArray objectAtIndex:row] objectForKey:@"name"];
        [_areaTableView reloadData];
        
        RXJDTableCell * cell = tableView.visibleCells[0];
        _areaVisible = ViewY(cell) - tableToTop;
    }
    
    [self createButtonsWithTitle:name andIndex:_selfSelectCount];
}

#pragma mark - ~~~~~~~~~~~ 切换 scrollView ~~~~~~~~~~~~~~~
/** 点击 请选择 按钮 */
- (void)selectInputButtonClick {
    [self scrollViewChangeAnimal:_buttonsArray.count + 1 andLineWidth:SelectLineWidth andLineLeft:_buttonsLasterLeft];
    
    [_addressScrollView setContentOffset:CGPointMake(_buttonsArray.count * ScreenWidth, 0) animated:YES];
}

/** 改变ScrollView contentSize */
- (void)changeScrollViewWithCount:(NSInteger)count {
    CGFloat width = count * ScreenWidth;
    _addressScrollView.contentSize = CGSizeMake(width, _addressHeight);
}

/** 改变ScrollView 中的地址 button */
- (void)createButtonsWithTitle:(NSString *)title andIndex:(NSInteger)index {
    
    self.userInteractionEnabled = NO;
    
    CGFloat selectCreateLastButtonWidth = SelectLineWidth;
    
    if(_buttonsArray.count > index) {
        for(NSInteger i = index; i <= _buttonsArray.count; i++) {
            RXJDButton * btn = _buttonsArray[index];
            _buttonsLasterLeft = _buttonsLasterLeft -  btn.width - AddressSpace;
            [btn removeFromSuperview];
            [_buttonsArray removeObjectAtIndex:index];
            btn = nil;
        }
        
        RXJDButton * btn = _buttonsArray[index - 1];
        btn.addressName = title;
        _buttonsLasterLeft = btn.width + btn.left + AddressSpace;
        _selectLineViewLeft = btn.width + btn.left + AddressSpace;
    }
    else if (_buttonsArray.count == index) {
        RXJDButton * btn = _buttonsArray[index - 1];
        btn.addressName = title;
        _buttonsLasterLeft = btn.width + btn.left + AddressSpace;
        
        if(index < _selfLevel_isHidden) {
            _selectLineViewLeft = btn.width + btn.left + AddressSpace;
        }
        else {
            _selectLineViewLeft = btn.left;
            [self scrollViewChangeAnimal:index andLineWidth:btn.width andLineLeft:_selectLineViewLeft];
            return;
        }
    }
    else {
        //_buttonsLasterLeft
        RXJDButton * btn = [RXJDButton buttonWithType:UIButtonTypeCustom];
        CGFloat left = _buttonsLasterLeft;
        if(index == 1) {
            left = 21;
            _buttonsLasterLeft = 21;
            _selectLineViewLeft = 21;
        }
        
        btn.frame = CGRectMake(left, 0, 10,_selectScrollViewHeight );
        
        btn.tagJD = index;
        btn.addressName = title;

        [btn addTarget:self action:@selector(addressTitleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_selectScrollView addSubview:btn];
        [_buttonsArray addObject:btn];
        
        
        _buttonsLasterLeft += btn.width + AddressSpace;
        if(index < _selfLevel_isHidden) {
            _selectLineViewLeft += btn.width + AddressSpace;
        }
        else {
            selectCreateLastButtonWidth = btn.width;
        }
        
        [_selectScrollView bringSubviewToFront:_selectButton];
        
    }
    
    
    
    [self scrollViewChangeAnimal:index andLineWidth:selectCreateLastButtonWidth andLineLeft:_selectLineViewLeft];
    
    if(index < _selfLevel_isHidden) {
        [_addressScrollView setContentOffset:CGPointMake(index * ScreenWidth, 0) animated:YES];
    }
   
    [self changeSelectScrollContentSizeWithSelectLeft:_buttonsLasterLeft + SelectLineWidth];
    
    //算scrollView;
    self.userInteractionEnabled = YES;
}

- (void)changeSelectScrollContentSizeWithSelectLeft:(CGFloat)left {
    if(left > ScreenWidth) {
        _selectScrollView.contentSize = CGSizeMake(left, _selectScrollViewHeight);
    }
    else {
        _selectScrollView.contentSize = CGSizeMake(ScreenWidth, _selectScrollViewHeight);
    }
}

/** ScrollView上已选择后的地址 点击 */
- (void)addressTitleButtonClick:(RXJDButton *)button {
    [self scrollViewChangeAnimal:button.tagJD andLineWidth:button.width   andLineLeft:button.left];
    
    [_addressScrollView setContentOffset:CGPointMake((button.tagJD - 1) * ScreenWidth, 0) animated:YES];
}

/** 改变ScrollView 请选择移动动画 */
- (void)scrollViewChangeAnimal:(NSInteger)level andLineWidth:(CGFloat)lineWidth andLineLeft:(CGFloat)lineLeft {
    
    _selectButton.hidden = _buttonsArray.count == _selfLevel_isHidden && _selfSelectCount == _selfLevel_isHidden ? YES : NO;
    
    [UIView animateWithDuration:ViewAnimal animations:^{
        _selectButton.frame = CGRectMake(_buttonsLasterLeft, SelectLabelTop, 100, SelectLabelHeight);
        _selectLineView.frame = CGRectMake(lineLeft, _selectScrollViewHeight - 2, lineWidth, 2);
    } completion:^(BOOL finished) {
        if(level == _selfLevel_isHidden && _selfSelectCount == _selfLevel_isHidden && _selfNotFirstShow) {
            [self completionAddress];
        }
    }];
}

/** self 显示、隐藏、完成操作 */
#pragma mark - ~~~~~~~~~~~ self 显示、隐藏、完成操作 ~~~~~~~~~~~~~~~
- (void)showAddress {
    self.hidden = NO;
    _selfNotFirstShow = NO;
    self.userInteractionEnabled = NO;
    
    if(!_selfNot3LeveSave)
        [self configAddressClear];
    
    [UIView animateWithDuration:ViewAnimal animations:^{
        _blackControl.alpha = Black_alpha_show;
        _showView.frame = _viewShowFrame;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}

- (void)completionAddress {
    //处理结果
    
    
    NSString * provinceName = _provinceArray[_provinceLine][@"name"];
    NSString * cityName = _cityArray[_cityLine][@"name"];
    NSString * areaName = _areaArray[_areaLine][@"name"];
    
//    NSString * provinceCode = _provinceArray[_provinceLine][@"code"];
    NSString * cityCode = _cityArray[_cityLine][@"code"];
    NSString * areaCode = _areaArray[_areaLine][@"code"];
    
    if (areaName == nil) {
        
        _addressString = [NSString stringWithFormat:@"%@ %@",
                          provinceName,
                          cityName];
        
        _addressCode = cityCode;
        
    } else {
        _addressString = [NSString  stringWithFormat:@"%@ %@ %@",
                          provinceName,
                          cityName,
                          areaName];
        
      _addressCode = areaCode;
    }
    
    self.completion(_addressString, _addressCode);
    [self hiddenAddress];
}

- (void)hiddenAddress {
    [UIView animateWithDuration:ViewAnimal animations:^{
        _blackControl.alpha = Black_alpha_hidde;
        _showView.frame  = _viewHiddenFrame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

@end
