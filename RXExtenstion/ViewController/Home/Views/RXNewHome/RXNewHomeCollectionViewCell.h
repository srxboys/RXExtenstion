//
//  RXNewHomeCollectionView.h
//  RXExtenstion
//
//  Created by srx on 16/5/23.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CollectionViewType) {
    CollectionViewTypeHome,
    CollectionViewTypeShare,
    CollectionViewTypeServer,
    CollectionViewTypeRequirement
};

@interface RXNewHomeCollectionViewCell : UICollectionViewCell
//数据源
@property (nonatomic, strong) NSMutableArray *dataArr;
@end
