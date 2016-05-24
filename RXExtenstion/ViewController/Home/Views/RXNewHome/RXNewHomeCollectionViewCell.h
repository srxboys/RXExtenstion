//
//  RXNewHomeCollectionView.h
//  RXExtenstion
//
//  Created by srx on 16/5/23.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//


#import <UIKit/UIKit.h>


@protocol RXNewHomeCollectionViewCellDelegate <NSObject>

@optional
- (void)rxNewHomeCollectionViewCellScrollView:(CGFloat)offsetY;
@end




@interface RXNewHomeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id<RXNewHomeCollectionViewCellDelegate>delegate;
//数据源
@property (nonatomic, strong) NSMutableArray *dataArr;
@end
