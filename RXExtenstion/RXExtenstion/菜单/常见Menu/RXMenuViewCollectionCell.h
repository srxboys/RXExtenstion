//
//  RXMenuViewCollectionCell.h
//  RXExtenstion
//
//  Created by srx on 16/9/5.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RXSeckillMenuMode;
@interface RXMenuViewCollectionCell : UICollectionViewCell
- (void)setSeckillMenuCellData:(RXSeckillMenuMode *)model isShowAnimal:(BOOL)animal;
@end
