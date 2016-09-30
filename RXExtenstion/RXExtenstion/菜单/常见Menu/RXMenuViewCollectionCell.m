//
//  RXMenuViewCollectionCell.m
//  RXExtenstion
//
//  Created by srx on 16/9/5.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMenuViewCollectionCell.h"
#import "RXMenuModel.h"
#import "NSDateUtilities.h"

#define TIMEOVER      @"已开抢"
#define TIMENOW       @"抢购中"
#define TIMENOARRIVED @"即将开抢"

#define animalDuration 0.5
#define startFontSize 14
#define endFontSize   16

@interface RXMenuViewCollectionCell ()
{
    UILabel * _timeLabel;
    UILabel * _statusLabel;
}
@end



@implementation RXMenuViewCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.contentView.backgroundColor = [UIColor blueColor];
        [self isAlloc];
        [self isCreateView];
    }
    return self;
}

- (void)isAlloc {
    [self removeView:_timeLabel];
    [self removeView:_statusLabel];
}

- (void)removeView:(id)view {
    if(view) {
        [view removeFromSuperview];
        view = nil;
    }
}

- (void)isCreateView {
    
    CGFloat width = self.bounds.size.width;
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, width, 14)];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = UIColorRGB(51 , 51 , 51 );
    _timeLabel.text = @"";
    [self.contentView addSubview:_timeLabel];
    
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, width, 14)];
    _statusLabel.font = [UIFont systemFontOfSize:14];
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    _statusLabel.textColor = UIColorRGB(51 , 51 , 51 );
    _statusLabel.text = @"";
    [self.contentView addSubview:_statusLabel];
    
}

- (void)setSeckillMenuCellData:(RXSeckillMenuMode *)model isShowAnimal:(BOOL)animal{
    
    NSDate * nowDate = [NSDate date];
    long long nowTime = [nowDate timeIntervalSince1970];
    
    NSDate * startDate = [NSDate dateWithTimeIntervalSince1970:model.starttime];
    NSDate * endDate = [NSDate dateWithTimeIntervalSince1970:model.endtime];
    NSString * timeStr = [NSString stringWithFormat:@"%02zd:%02zd", startDate.hour, startDate.minute];
    
#if DEBUG
    NSString * nowStr = [NSString stringWithFormat:@"nowStr=%zd-%zd-%zd %02zd:%02zd", nowDate.year, nowDate.month, nowDate.day , nowDate.hour, nowDate.minute];
    NSString * startStr = [NSString stringWithFormat:@"startDate=%zd-%zd-%zd %02zd:%02zd", startDate.year, startDate.month, startDate.day , startDate.hour, startDate.minute];
    NSString * endStr = [NSString stringWithFormat:@"endDate=%zd-%zd-%zd %02zd:%02zd", endDate.year, endDate.month, endDate.day , endDate.hour, endDate.minute];
    RXLog(@"\n\n%@\n%@\n%@\n\n", nowStr, startStr, endStr);
    
#endif
    _timeLabel.text = timeStr;
    
    _timeLabel.textColor = UIColorRGB(51 , 51 , 51 );
    _statusLabel.textColor = UIColorRGB(51 , 51 , 51 );
    
    
    if(model.endtime < nowTime) {
        _statusLabel.text = TIMEOVER;
    }
    else if(model.starttime > nowTime) {
        _statusLabel.text = TIMENOARRIVED;
    }
    else {
        _statusLabel.text = TIMENOW;
    }
    
    self.contentView.backgroundColor = UIColorRGB(238, 238, 238);
    if(animal) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self selectedCellAnimal];
    }
}

- (void)selectedCellAnimal {
    //改变颜色
    _timeLabel.textColor = UIColorRGB(125, 15, 131);
    _statusLabel.textColor = UIColorRGB(125, 15, 131);
    
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = animalDuration;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.values = values;
    [_timeLabel.layer addAnimation:animation forKey:nil];
    [_statusLabel.layer addAnimation:animation forKey:nil];
}
@end
