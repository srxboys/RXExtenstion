//
//  RXLocationController.m
//  RXExtenstion
//
//  Created by srx on 16/6/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
// GPS定位

#import "RXLocationController.h"

#import <CoreLocation/CoreLocation.h>

@interface RXLocationController ()<CLLocationManagerDelegate>
{
    CLLocationManager * _locationManager;
}
@end

@implementation RXLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建位置管理器
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate=self;
    //desiredAccuracy为设置定位的精度，可以设为最优，装置会自动用最精确的方式去定位。
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序，它的单位是米，这里设置为至少移动1000再通知委托处理更新。
    _locationManager.distanceFilter = 1000.0f;
    
//    _locationManager.allowsBackgroundLocationUpdates = YES;
    
    //启动位置更新
    //就是启动定位管理了，一般来说，在不需要更新定位时最好关闭它，用stopUpdatingLocation，可以节省电量。
    [_locationManager startUpdatingLocation];
    
    if(iOS8OrLater) {
        [_locationManager requestAlwaysAuthorization];
    }
}

//这个方法即定位改变时委托会执行的方法。
//可以得到新位置，旧位置，CLLocation里面有经度纬度的坐标值，
//同时CLLocation还有个属性horizontalAccuracy，用来得到水平上的精确度，它的大小就是定位精度的半径，单位为米。 如果值为－1，则说明此定位不可信。
//这个不走
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    //  iOS6
    
    
    //    当前的经度
    NSString *currentLatitude = [[NSString alloc] initWithFormat:@"%g", newLocation.coordinate.latitude];
    RXLog(@"经度currentLatitude=%@", currentLatitude);
    
    //    当前的纬度
    NSString *currentLongitude = [[NSString alloc] initWithFormat:@"%g", newLocation.coordinate.longitude];
    RXLog(@"纬度currentLongitude=%@", currentLongitude);
    
    //    当前的水平距离
    NSString *currentHorizontalAccuracy = [[NSString alloc]  initWithFormat:@"%g", newLocation.horizontalAccuracy];
    RXLog(@"水平距离currentHorizontalAccuracy=%@", currentHorizontalAccuracy);
    
    

    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
            RXLog(@"placemark=%@", placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            RXLog(@"city = %@", city);
        }
        else if (error == nil && [array count] == 0)
        {
            RXLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            RXLog(@"An error occurred = %@", error);
        }
    }];
    
//系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //locations数组里边存放的是CLLocation对象，一个CLLocation对象就代表着一个位置
    CLLocation *loc = [locations firstObject];
    //维度：loc.coordinate.latitude
    //经度：loc.coordinate.longitude
    RXLog(@"纬度=%f，经度=%f",loc.coordinate.latitude,loc.coordinate.longitude);
    RXLog(@"数据个数%zd===数组元素=%@", locations.count, locations);
    
    //    当前的水平距离
    NSString *currentHorizontalAccuracy = [[NSString alloc]  initWithFormat:@"%g", loc.horizontalAccuracy];
    //verticalAccuracy
    NSString *currentVerticalAccuracy = [[NSString alloc]  initWithFormat:@"%g", loc.verticalAccuracy];
    RXLog(@"水平距离currentHorizontalAccuracy=%@==垂直距离currentVerticalAccuracy=%@", currentHorizontalAccuracy, currentVerticalAccuracy);
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
            //            self.location.text = placemark.name;
            RXLog(@"placemark=%@", placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            RXLog(@"city = %@", city);
            //            _cityLable.text = city;
            //            [_cityButton setTitle:city forState:UIControlStateNormal];
        }
        else if (error == nil && [array count] == 0)
        {
            RXLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            RXLog(@"An error occurred = %@", error);
        }
    }];
    
    //停止更新位置（如果定位服务不需要实时更新的话，那么应该停止位置的更新）
//    [manager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
