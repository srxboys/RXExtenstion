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

//经度
@property (weak, nonatomic) IBOutlet UILabel *labelLatitude;
//维度
@property (weak, nonatomic) IBOutlet UILabel *labelLongitude;

//国家
@property (weak, nonatomic) IBOutlet UILabel *labelCountry;
//城市
@property (weak, nonatomic) IBOutlet UILabel *labelCity;
//直辖市
@property (weak, nonatomic) IBOutlet UILabel *labelMunicipality;
//地址
@property (weak, nonatomic) IBOutlet UILabel *labelAddressName;

@end

@implementation RXLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor brownColor];
    
    //创建位置管理器
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    //desiredAccuracy为设置定位的精度，可以设为最优，装置会自动用最精确的方式去定位。
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    /*
     定位精度
     desiredAccuracy精度参数可以iOS SDK通过常量实现：
     kCLLocationAccuracyNearestTenMeters，10米
     kCLLocationAccuracyHundredMeters ，100米
     kCLLocationAccuracyKilometer ，1000米
     kCLLocationAccuracyThreeKilometers，3000米
     kCLLocationAccuracyBest ，最好的精度
     kCLLocationAccuracyBestForNavigation，导航情况下最好精度，iOS 4 SDK新增加。一般要有外接电源时候才能使用。
     */
    
    
    
    //distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序，它的单位是米，这里设置为至少移动1000再通知委托处理更新。
    _locationManager.distanceFilter = 1000.0f;
//    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //定位要求的精度越高、属性distanceFilter的值越小，应用程序的耗电量就越大。
    
    
    /*
    位置管理器有一个headingAvailable属性，它指出设备是否装备了磁性指南针。如果该属性为YES，就可以使用Core Location来获取航向(heading)信息。接收航向更新与接收位置更新极其相似，要开始接收航向更新，可指定位置管理器委托，设置属性headingFilter以指定要以什么样的频率(以航向变化的度数度量)接收更新，并对位置管理器调用方法startUpdatingHeading:
     */
    _locationManager.headingFilter = kCLHeadingFilterNone;
    
    //请求用户权限：分为：⓵只在前台开启定位⓶在后台也可定位，
    //注意：建议只请求⓵和⓶中的一个，如果两个权限都需要，只请求⓶即可，
    //⓵⓶这样的顺序，将导致bug：第一次启动程序后，系统将只请求⓵的权限，⓶的权限系统不会请求，只会在下一次启动应用时请求⓶
    if(iOS8OrLater) {
        [_locationManager requestAlwaysAuthorization];
    }
    
    if(iOS9OrLater) {
        //iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。
        _locationManager.allowsBackgroundLocationUpdates = YES;
        
        /*
            这里运行会报错，解决办法，看
            【2.iOS9新特性_更灵活的后台定位（见Demo2）】 点击这个
            https://github.com/ChenYilong/iOS9AdaptationTips
         
            //https://github.com/ChenYilong/iOS9AdaptationTips#2demo2_ios9%E6%96%B0%E7%89%B9%E6%80%A7_%E6%9B%B4%E7%81%B5%E6%B4%BB%E7%9A%84%E5%90%8E%E5%8F%B0%E5%AE%9A%E4%BD%8D
         */
    }
    
    if (@available(iOS 11.0, *)) {
        _locationManager.showsBackgroundLocationIndicator = YES;
    } else {
        // Fallback on earlier versions
    }

    
    //启动位置更新
    //就是启动定位管理了，一般来说，在不需要更新定位时最好关闭它，用stopUpdatingLocation，可以节省电量。
    [_locationManager startUpdatingLocation];
    
    
}

//这个方法即定位改变时委托会执行的方法。
//可以得到新位置，旧位置，CLLocation里面有经度纬度的坐标值，
//同时CLLocation还有个属性horizontalAccuracy，用来得到水平上的精确度，它的大小就是定位精度的半径，单位为米。 如果值为－1，则说明此定位不可信。
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //locations数组里边存放的是CLLocation对象，一个CLLocation对象就代表着一个位置
    CLLocation *loc = [locations firstObject];
    //维度：loc.coordinate.latitude
    //经度：loc.coordinate.longitude
    
    //    当前的纬度
    NSString *currentLatitude = [[NSString alloc] initWithFormat:@"%g", loc.coordinate.latitude];
    //    当前的经度
    NSString *currentLongitude = [[NSString alloc] initWithFormat:@"%g", loc.coordinate.longitude];
    
//    RXLog(@"纬度=%@，经度=%@", currentLatitude, currentLongitude);
//    RXLog(@"数据个数%zd===数组元素=%@", locations.count, locations);
    _labelLongitude.text = currentLongitude;
    _labelLatitude.text  = currentLatitude;
    
    
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
            
            _labelCountry.text      = placemark.country;
            _labelCity.text         = placemark.locality;
            _labelMunicipality.text = placemark.administrativeArea;
            _labelAddressName.text  = placemark.name;
            
            RXLog(@"placemark.postalCode = %@", placemark.postalCode);
            
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
    //如果不需要实时更新地址，就关掉，节约电量
//    [manager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
