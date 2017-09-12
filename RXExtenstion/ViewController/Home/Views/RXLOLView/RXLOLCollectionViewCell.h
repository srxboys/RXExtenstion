//
//  RXLOLCollectionViewCell.h
//  RXExtenstion
//
//  Created by srx on 2017/7/18.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const RXLOLCellIdentifier;


typedef NS_ENUM(NSInteger, CellType) {
    CellTypeRecord = 0,
    CellTypeAbility = 1,
    CellTypeAssets = 2
};

typedef NS_ENUM(NSInteger, CellGround) {
    Cellbackground = 0, //背景
    CellForeground = 1  //前景
};

@protocol RXLOLCollectionDelegate <NSObject>

- (void)RXLOLScrollY:(CGFloat)y;
- (void)RXLOLScrollReload;

@end

@interface RXLOLCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id<RXLOLCollectionDelegate>delegate;

@property (nonatomic, assign) CGFloat contentOffsetY;

//用于扩展
@property (nonatomic, assign) CellType cellType;
@property (nonatomic, assign) CellGround cellGround;
@end
