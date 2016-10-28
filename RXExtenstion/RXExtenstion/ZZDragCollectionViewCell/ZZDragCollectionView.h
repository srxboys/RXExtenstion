//
//  ZZDragCollectionView.h
//  ZZPersonalDemo
//
//  Created by zhouzheng on 16/7/18.
//  Copyright © 2016年 zhouzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZDragCollectionView;

@protocol ZZDragCollectionViewDelegate <UICollectionViewDelegate>

@required
//拖动完成后数据源更新，必须实现
- (void)dragCellCollectionView:(ZZDragCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray;

@optional
//某个cell将要开始移动时调用，indexPath是该cell当前的indexPath
- (void)dragCellCollectionView:(ZZDragCollectionView *)collectionView cellWillBeginMoveAtIndexPath:(NSIndexPath *)indexPath;
//某个cell正在移动时调用
- (void)dragCellCollectionViewCellisMoving:(ZZDragCollectionView *)collectionView;
//某个cell结束移动时调用
- (void)dragCellCollectionViewCellEndMoving:(ZZDragCollectionView *)collectionView;
//成功交换位置后调用，fromIndexPath交换cell的起始位置，toIndexPath交换cell的新位置
- (void)dragCellCollectionView:(ZZDragCollectionView *)collectionView moveCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end

@protocol ZZDragCollectionViewDataSource <UICollectionViewDataSource>

@required
//返回整个CollectionView的数据，必须实现，需根据数据进行移动后的数据重排
- (NSArray *)dataSourceArrayOfCollectionView:(ZZDragCollectionView *)collectionView;

@end

@interface ZZDragCollectionView : UICollectionView

@property (nonatomic, assign) id <ZZDragCollectionViewDelegate> delegate;
@property (nonatomic, assign) id <ZZDragCollectionViewDataSource> dataSource;

@property (nonatomic, assign) NSTimeInterval minimumPressDuration;//长按多少秒触发拖动手势，默认1s
@property (nonatomic, assign) BOOL edgeScrollEable;//是否开启拖动到边缘滚动collectionView，默认YES
@property (nonatomic, assign) BOOL shakeWhenMoveing;//是否开启拖动时cell抖动，默认YES
@property (nonatomic, assign) CGFloat shakeLevel;//抖动等级0~4，默认2
@property (nonatomic, assign) CGFloat scaling;//缩放比例

@end
