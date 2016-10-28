//
//  ZZDragCollectionView.m
//  ZZPersonalDemo
//
//  Created by zhouzheng on 16/7/18.
//  Copyright © 2016年 zhouzheng. All rights reserved.
//

#import "ZZDragCollectionView.h"
#define angelToRandian(x)  ((x)/180.0*M_PI)
//拖拽方向
typedef NS_ENUM(NSInteger, ZZDragDirection) {
    ZZDragDirectionNone = 0,
    ZZDragDirectionUp,
    ZZDragDirectionDown,
    ZZDragDirectionLeft,
    ZZDragDirectionRight
};

@interface ZZDragCollectionView()
{
    NSIndexPath *_originalIndexPath;//移动原始indexPath
    NSIndexPath *_newIndexPath;//新的indexPath
    UILongPressGestureRecognizer *_longPressGesture;//长按手势
    UIView *_tempMoveCell;
    CGFloat _oldMinimumPressDuration;//长按时间
    ZZDragDirection _dragDirection;//拖拽方向
    CGPoint _lastPoint;
    CADisplayLink *_edgeTimer;//涉及到画面更新，动画过程演变，实现不停的重绘
}
@end

@implementation ZZDragCollectionView

@dynamic delegate;
@dynamic dataSource;

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self initAttribute];
        [self addLongPressGesture];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initAttribute];
        [self addLongPressGesture];
    }
    return self;
}

//初始化一些属性值
- (void)initAttribute {
    _minimumPressDuration = 0.5;
    _shakeLevel = 0.0;
    _scaling = 1.3;
    _shakeWhenMoveing = YES;
    _edgeScrollEable = YES;
}

#pragma mark - 长按手势
//添加一个长按手势
- (void)addLongPressGesture {
    _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    _longPressGesture.minimumPressDuration = _minimumPressDuration;
    [self addGestureRecognizer:_longPressGesture];
}

//监听手势的改变
- (void)longPress:(UILongPressGestureRecognizer *)longPressGesture {
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        [self gestureBegan:longPressGesture];
    }
    if (longPressGesture.state == UIGestureRecognizerStateChanged) {
        [self gestureChanged:longPressGesture];

#warning 下面这行代码是关闭左右拖拽效果的，如果想支持上下左右拖拽，把下行代码注释掉并且把edgeScroll方法里注释掉的放开即可
        _tempMoveCell.center = CGPointMake(ScreenWidth/2, _tempMoveCell.center.y);
        
    }
    if (longPressGesture.state == UIGestureRecognizerStateCancelled || longPressGesture.state == UIGestureRecognizerStateEnded) {
        [self gestureCancelOrEnd:longPressGesture];
    }
}

//手势开始
- (void)gestureBegan:(UILongPressGestureRecognizer *)longPressGesture {
    //获取手指所在的cell
    _originalIndexPath = [self indexPathForItemAtPoint:[longPressGesture locationOfTouch:0 inView:longPressGesture.view]];
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:_originalIndexPath];
    //截图，得到cell的截图视图
    _tempMoveCell = [cell snapshotViewAfterScreenUpdates:NO];
    //_tempMoveCell.frame = cell.frame;
    _tempMoveCell.center = cell.center;
    _tempMoveCell.bounds = CGRectMake(0, 0, cell.frame.size.width * _scaling, cell.frame.size.height * _scaling);
//    _tempMoveCell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.0];
    _tempMoveCell.alpha = 0.8;
    _tempMoveCell.layer.shadowColor = [UIColor blackColor].CGColor;
    _tempMoveCell.layer.shadowOffset = CGSizeMake(4, 4);
    _tempMoveCell.layer.shadowRadius = 4.0;
    _tempMoveCell.layer.shadowOpacity = 0.8;
    [self addSubview:_tempMoveCell];
    //隐藏cell
    cell.hidden = YES;
    //记录当前手指位置
    _lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
    
    //开启边缘滚动定时器
    [self edgeTimer];
    //开始抖动
    if (_shakeWhenMoveing) {
        [self shakeCell];
        //[self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    //通知代理
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:cellWillBeginMoveAtIndexPath:)]) {
        [self.delegate dragCellCollectionView:self cellWillBeginMoveAtIndexPath:_originalIndexPath];
    }
}

//手势改变（拖拽）
- (void)gestureChanged:(UILongPressGestureRecognizer *)longPressGesture {
    //通知代理
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionViewCellisMoving:)]) {
        [self.delegate dragCellCollectionViewCellisMoving:self];
    }
    //计算移动的距离
    CGFloat tranX = [longPressGesture locationOfTouch:0 inView:longPressGesture.view].x - _lastPoint.x;
    CGFloat tranY = [longPressGesture locationOfTouch:0 inView:longPressGesture.view].y - _lastPoint.y;
    //设置截图视图的位置
    _tempMoveCell.center = CGPointApplyAffineTransform(_tempMoveCell.center, CGAffineTransformMakeTranslation(tranX, tranY));
    _lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
    
    [self moveCell];
}

//手势取消或结束
- (void)gestureCancelOrEnd:(UILongPressGestureRecognizer *)longPressGesture {
    
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:_originalIndexPath];
    //结束动画过程中停止交互，防止出问题
    self.userInteractionEnabled = NO;
    [self stopEdgeTimer];
    
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionViewCellEndMoving:)]) {
        [self.delegate dragCellCollectionViewCellEndMoving:self];
    }
    //给截图视图一个动画移动到隐藏cell的新位置
    [UIView animateWithDuration:0.25 animations:^{
        _tempMoveCell.center = cell.center;
    } completion:^(BOOL finished) {
        //移除截图视图、显示隐藏cell并开启交互
        [self stopShakeCell];
        [_tempMoveCell removeFromSuperview];
        cell.hidden = NO;
        self.userInteractionEnabled = YES;
    }];
}

#pragma mark - timer
- (void)edgeTimer {
    if (!_edgeTimer && _edgeScrollEable) {
        _edgeTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(edgeScroll)];
        [_edgeTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stopEdgeTimer {
    if (_edgeTimer) {
        [_edgeTimer invalidate];
        _edgeTimer = nil;
    }
}

#pragma mark - cell的抖动和停止抖动
- (void)shakeCell {
    CAKeyframeAnimation* anim=[CAKeyframeAnimation animation];
    anim.keyPath=@"transform.rotation";
    anim.values=@[@(angelToRandian(-_shakeLevel)),@(angelToRandian(_shakeLevel)),@(angelToRandian(-_shakeLevel))];
    anim.repeatCount=MAXFLOAT;
    anim.duration=0.2;
    NSArray *cells = [self visibleCells];
    for (UICollectionViewCell *cell in cells) {
        /**如果加了shake动画就不用再加了*/
        if (![cell.layer animationForKey:@"shake"]) {
            [cell.layer addAnimation:anim forKey:@"shake"];
        }
    }
    if (![_tempMoveCell.layer animationForKey:@"shake"]) {
        [_tempMoveCell.layer addAnimation:anim forKey:@"shake"];
    }
}

- (void)stopShakeCell {
    if (!_shakeWhenMoveing) {
        return;
    }
    NSArray *cells = [self visibleCells];
    for (UICollectionViewCell *cell in cells) {
        [cell.layer removeAllAnimations];
    }
    [_tempMoveCell.layer removeAllAnimations];
    //[self removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - timer的方法edgeScroll
- (void)edgeScroll {
    [self dragDirection];
    switch (_dragDirection) {
        
        case ZZDragDirectionUp:{
            //这里的动画必须设为NO
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - 4) animated:NO];
            _tempMoveCell.center = CGPointMake(_tempMoveCell.center.x, _tempMoveCell.center.y - 4);
            _lastPoint.y -= 4;
        }
            break;
            
        case ZZDragDirectionDown:{
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + 4) animated:NO];
            _tempMoveCell.center = CGPointMake(_tempMoveCell.center.x, _tempMoveCell.center.y + 4);
            _lastPoint.y += 4;
        }
            break;
            
//        case ZZDragDirectionLeft:{
//            [self setContentOffset:CGPointMake(self.contentOffset.x - 4, self.contentOffset.y) animated:NO];
//            _tempMoveCell.center = CGPointMake(_tempMoveCell.center.x - 4, _tempMoveCell.center.y);
//            _lastPoint.x -= 4;
//        }
//            break;
//            
//        case ZZDragDirectionRight:{
//            [self setContentOffset:CGPointMake(self.contentOffset.x + 4, self.contentOffset.y) animated:NO];
//            _tempMoveCell.center = CGPointMake(_tempMoveCell.center.x + 4, _tempMoveCell.center.y);
//            _lastPoint.x += 4;
//        }
//            break;
            
        default:
            break;
    }
}

//判断拖拽方向
- (void)dragDirection {
    _dragDirection = ZZDragDirectionNone;
    if (_tempMoveCell.center.y - self.contentOffset.y < _tempMoveCell.bounds.size.height/2 && self.contentOffset.y > 0) {
        _dragDirection = ZZDragDirectionUp;
    }
    if (self.bounds.size.height + self.contentOffset.y - _tempMoveCell.center.y < _tempMoveCell.bounds.size.height / 2 && self.bounds.size.height + self.contentOffset.y < self.contentSize.height) {
        _dragDirection = ZZDragDirectionDown;
    }
    if (_tempMoveCell.center.x - self.contentOffset.x < _tempMoveCell.bounds.size.width / 2 && self.contentOffset.x > 0) {
        _dragDirection = ZZDragDirectionLeft;
    }
    if (self.bounds.size.width + self.contentOffset.x - _tempMoveCell.center.x < _tempMoveCell.bounds.size.width / 2 && self.bounds.size.width + self.contentOffset.x < self.contentSize.width) {
        _dragDirection = ZZDragDirectionRight;
    }
}

#pragma mark - moveCell更新数据源
- (void)moveCell {
    //计算截图视图和哪个cell相交
    for (UICollectionViewCell *cell in [self visibleCells]) {
        //剔除隐藏的cell
        if ([self indexPathForCell:cell] == _originalIndexPath) {
            continue;
        }
        //计算中心距
        CGFloat spacingX = fabs(_tempMoveCell.center.x - cell.center.x);
        CGFloat spacingY = fabs(_tempMoveCell.center.y - cell.center.y);
        //如果相交一半就移动
        if (spacingX <= _tempMoveCell.bounds.size.width/2 && spacingY <= _tempMoveCell.bounds.size.height/2) {
            _newIndexPath = [self indexPathForCell:cell];
            //更新数据
            [self updateDataSource];
            //移动
            [self moveItemAtIndexPath:_originalIndexPath toIndexPath:_newIndexPath];
            
            if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:moveCellFromIndexPath:toIndexPath:)]) {
                [self.delegate dragCellCollectionView:self moveCellFromIndexPath:_originalIndexPath toIndexPath:_newIndexPath];
            }
            _originalIndexPath = _newIndexPath;
            break;
        }
    }
}

//更新数据源
- (void)updateDataSource {
    NSMutableArray *temp = @[].mutableCopy;
    //获取数据源,通过代理的方式
    if ([self.dataSource respondsToSelector:@selector(dataSourceArrayOfCollectionView:)]) {
        [temp addObjectsFromArray:[self.dataSource dataSourceArrayOfCollectionView:self]];
    }
    //判断数据源是单个数组还是数组套数组的多section形式，YES表示数组套数组
    BOOL dataTypeCheck = ([self numberOfSections] != 1 || ([self numberOfSections] == 1 && [temp[0] isKindOfClass:[NSArray class]]));
    //先将数据源的数组都变为可变数据方便操作
    if (dataTypeCheck) {
        for (int i = 0; i < temp.count; i ++) {
            [temp replaceObjectAtIndex:i withObject:[temp[i] mutableCopy]];
        }
    }
    if (_newIndexPath.section == _originalIndexPath.section) {
       //在同一个section中移动或者只有一个section的情况（原理就是将原位置和新位置之间的cell向前或者向后平移）
        NSMutableArray *orignalSection = dataTypeCheck ? temp[_originalIndexPath.section] : temp;
        if (_newIndexPath.item > _originalIndexPath.item) {
            for (NSUInteger i = _originalIndexPath.item; i < _newIndexPath.item ; i ++) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
            }
        }else{
            for (NSUInteger i = _originalIndexPath.item; i > _newIndexPath.item ; i --) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
            }
        }
    }else{
        //在不同section之间移动的情况（原理是删除原位置所在section的cell并插入到新位置所在的section中）
        NSMutableArray *orignalSection = temp[_originalIndexPath.section];
        NSMutableArray *currentSection = temp[_newIndexPath.section];
        [currentSection insertObject:orignalSection[_originalIndexPath.item] atIndex:_newIndexPath.item];
        [orignalSection removeObject:orignalSection[_originalIndexPath.item]];
    }
    //将重排好的数据传递给外部，在外部设置新的数据源
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:newDataArrayAfterMove:)]) {
        [self.delegate dragCellCollectionView:self newDataArrayAfterMove:temp.copy];
    }
}


@end
