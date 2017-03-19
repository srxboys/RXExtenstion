//
//  RXAccumulation.c
//  RXExtenstion
//
//  Created by srx on 2017/2/22.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#include "RXAccumulation.h"

/** 累加器 */

/*
 //要把 oc 变 c
NSString * charWithFloat(float changeValue) {
    CGFloat value = changeValue;
    NSString * string = [NSString stringWithFormat:@"%.2f", value];
    string = [NSString stringWithFormat:@"%5@", string];
    return  string;
}

void printTimer(float startTimer, float endTimer, float mindValue) {
    float minPoint = startTimer; //开始
    float maxPoint = endTimer;//结束
    
    float space = mindValue;//累加数
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    [array addObject:charWithFloat(minPoint)];
    while (YES) {
        minPoint += space;
        //floor 取整函数
        float temp = minPoint - floor(minPoint);
        NSLog(@"minPoint=%f==temp=%f", minPoint, temp);
        if(temp >= 0.60) {
            //lroundf 四舍五入，取最接近的整数
            long addPoint = lroundf(temp * 100) / 60;
            float upPoint  = lroundf(temp * 100) % 60 / 100.0;
            NSLog(@"minpoint=%f == addPoint=%ld  upPoint=%f", minPoint, addPoint, upPoint);
            minPoint = floor(minPoint) + addPoint + upPoint;
            NSLog(@"-minpoint=%f\n\n", minPoint);
        }
        
        if(minPoint > maxPoint) {
            break;
        }
        
        [array addObject:charWithFloat(minPoint)];
        
        
    }
    NSLog(@"%@", array);
    
}

*/