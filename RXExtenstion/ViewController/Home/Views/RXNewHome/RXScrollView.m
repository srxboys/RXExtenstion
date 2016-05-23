//
//  RXScrollView.m
//  RXExtenstion
//
//  Created by srx on 16/5/23.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXScrollView.h"

#import "RXDataModel.h"
#import "RXCharacter.h"

#import "GBInfiniteScrollView.h" //滚动视图
#import "SMPageControl.h" //分页控制器
#import "UIImageView+fadeInFadeOut.h"

@interface RXScrollView ()<GBInfiniteScrollViewDelegate, GBInfiniteScrollViewDataSource>
{
    GBInfiniteScrollView * _scrollView;
    SMPageControl        * _pageControll;
    
    NSArray              * _dataSourceArr;
}
@end


@implementation RXScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        _scrollView = [[GBInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _scrollView.infiniteScrollViewDelegate = self;
        _scrollView.infiniteScrollViewDataSource = self;
        //滚动速度
        _scrollView.interval = 0.5;
        [self addSubview:_scrollView];
        
        _pageControll = [[SMPageControl alloc] initWithFrame:CGRectMake(0, height - 40, width, 30)];
        _pageControll.alignment = SMPageControlAlignmentCenter;
        _pageControll.verticalAlignment = SMPageControlVerticalAlignmentMiddle;
        //下面 2选1 -- 分页样式
        //大小图片的 分页
        //        _pageControll.pageIndicatorImage = [UIImage imageNamed:@""];
        //        _pageControll.currentPageIndicatorImage = [UIImage imageNamed:@""];
        //统一大小的 颜色 分页
        _pageControll.pageIndicatorTintColor = [UIColor redColor];
        _pageControll.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        [self addSubview:_pageControll];
    }
    return self;
}

- (void)setScrollViewDataArr:(NSArray *)array {
    
    if(_dataSourceArr == array || ![array arrBOOL]) {
        return;
    }
    
    _pageControll.numberOfPages = array.count;
    _pageControll.currentPage = 0;
    _dataSourceArr = array;
    
    //刷新数据
    [_scrollView updateData];
    //开始滚动
    [_scrollView startAutoScroll];
}



-(void)infiniteScrollViewDidBegin:(GBInfiniteScrollView *)infiniteScrollView {
    //scrollView 触摸滚动
}

-(void)infiniteScrollViewEndScroll:(GBInfiniteScrollView *)infiniteScrollView {
    //scrollView 离开触摸
}

#pragma mark - ~~~~~~~~~~~ 轮番图 控制分页 页数 ~~~~~~~~~~~~~~~

//- (UIView *)currentPage {
//    //设置默认值、自定义当前的样式
//}

- (void)infiniteScrollViewDidScrollNextPage:(GBInfiniteScrollView *)infiniteScrollView {
    if(_pageControll.currentPage + 1 < _dataSourceArr.count) {
        _pageControll.currentPage ++;
    }
    else {
        _pageControll.currentPage = 0;
    }
}
- (void)infiniteScrollViewDidScrollPreviousPage:(GBInfiniteScrollView *)infiniteScrollView {
    if(_pageControll.currentPage - 1 >= 0) {
        _pageControll.currentPage --;
    }
    else {
        _pageControll.currentPage = _dataSourceArr.count -1;
    }
}

#pragma mark - ~~~~~~~~~~~ 轮播图Delegate DataSource ~~~~~~~~~~~~~~~
- (NSInteger)numberOfPagesInInfiniteScrollView:(GBInfiniteScrollView *)infiniteScrollView {
    return _dataSourceArr.count;
}

- (UIView *)infiniteScrollView:(GBInfiniteScrollView *)infiniteScrollView pageAtIndex:(NSUInteger)index; {
    UIImageView * imageView = (UIImageView *)[infiniteScrollView dequeueReusablePage];
    if(imageView == nil) {
        imageView = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
        
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openFocus:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [imageView addGestureRecognizer:tap];
        
    }
    if(index < _dataSourceArr.count) {
        RXFouceModel *focus = [_dataSourceArr objectAtIndex:index];
        //        TTLog(@"imageView.height = %.2f  ----  scroll.contextOffset=%.2f", imageView.frame.size.height, _scroll.contentOffset.x);
        if(focus == nil) {
            return imageView;
        }

        //srxboys 自己封装 渐变加载
        [imageView sd_setImageFIFOWithURL:[NSURL URLWithString:focus.image] placeholderImage:[UIImage imageNamed:@"loadfault"]];
        imageView.tag = index;
    }
    return imageView;
}

- (void)openFocus:(UITapGestureRecognizer *)tap {
    
    UIImageView * imgView = (UIImageView *)tap.view;
    RXLog(@"图片被点击的tag=%ld", (long)imgView.tag);
    
    if([self.delegate respondsToSelector:@selector(rxScrollViewClickIngeter:)]) {
        [self.delegate rxScrollViewClickIngeter:imgView.tag];
    }
    
}


@end
