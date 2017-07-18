//
//  RXLOLCollectionViewCell.h
//  RXExtenstion
//
//  Created by srx on 2017/7/18.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellType) {
    CellTypeRecord = 0,
    CellTypeAbility = 1,
    CellTypeAssets = 2
};

FOUNDATION_EXPORT NSString * const RXLOLCellIdentifier;

@interface RXLOLCollectionViewCell : UICollectionViewCell
@property (nonatomic, assign) CellType cellType;
@end
