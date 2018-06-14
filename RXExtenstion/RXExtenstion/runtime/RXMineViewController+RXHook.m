//
//  RXMineViewController+RXHook.m
//  RXExtenstion
//
//  Created by srxboys on 2018/1/15.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//
//获取 某类中，私有变量、方法等(常用于 hook 第三方的 静态库/动态库)


//我们当 ` RXMineViewController ` .m看不到


#import "RXMineViewController+RXHook.h"

//1
#import <objc/runtime.h>

//2
#import "RXDataModel.h"

//3
#import "RXWebKitViewController.h"





// 因category不能添加属性，只能通过关联对象的方式。
static const char * HACK_MIME_USER_KEY = "hook_user_KEY";

@interface RXBaseViewController()
//或者数据模型，只要提供.h 就行
@property (nonatomic, copy) NSArray * hook_dataSouceArr;
@end


@implementation RXMineViewController (RXHook)
+ (void)load {
    /*
     
     //分析下面的东西都是干什么的，一般不知道的，会每个都要试一下 😅。
     
     unsigned int count;
     //获取属性列表
     objc_property_t *propertyList = class_copyPropertyList([self class], &count);
     for (unsigned int i = 0; i<count; i++) {
     const char *propertyName = property_getName(propertyList[i]);
     NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
     }
     
     //获取方法列表
     Method *methodList = class_copyMethodList([self class], &count);
     for (unsigned int i = 0; i<count; i++) {
     Method method = methodList[i];
     NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
     }
     
     //jumpByProductURL
     //productInfo-
     
     //- (void)jumpToWebViewByFullMediaString:(NSString *)fullMediaString
     
     //loadWebPageWithString:(NSString*)urlString
     
     //pageURLString //setPageURLString:
     
     
     //获取成员变量列表
     Ivar *ivarList = class_copyIvarList([self class], &count);
     for (unsigned int i = 0; i<count; i++) {
     Ivar myIvar = ivarList[i];
     const char *ivarName = ivar_getName(myIvar);
     NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
     }
     
     //获取协议列表
     __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
     for (unsigned int i = 0; i<count; i++) {
     Protocol *myProtocal = protocolList[i];
     const char *protocolName = protocol_getName(myProtocal);
     NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
     }
     
     */
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //点击头像 跳转
        SEL oldSel = NSSelectorFromString(@"mineHeaderClick");
        SEL newSel = @selector(hook_Mine_jumpByProductURL);
        [self swizzleMethod:oldSel withMethod:newSel insertSel:newSel];
        
        
    });
}

+ (void)swizzleMethod:(SEL)origSel withMethod:(SEL)aftSel insertSel:(SEL)insetSel{
    Class aClass = [self class];
    Method originMethod = class_getInstanceMethod(aClass, origSel);
    BOOL didAddMethod = class_addMethod(aClass, origSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    if(didAddMethod) {
        //添加后替换
        Method createSelMethod = class_getInstanceMethod(aClass, insetSel);
        class_replaceMethod(aClass,
                            origSel,
                            method_getImplementation(createSelMethod),
                            method_getTypeEncoding(originMethod));
    }
    else {
        // 交换实现
        Method afterMethod = class_getInstanceMethod(aClass, aftSel);
        method_exchangeImplementations(originMethod, afterMethod);
    }
}


- (void)viewWillAppear:(BOOL)animated {
    //如果你不需要私有属性的，可以直接写分类
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)hook_Mine_jumpByProductURL {
    Class aClass = [self class];
    //从类中获取成员变量Ivar （也可以在load 中，注释掉 获取ivarList中给 我们的变量赋值）
    Ivar old_productInfo_ivar = class_getInstanceVariable(aClass, "_dataSouceArr");
    if(!old_productInfo_ivar) {
        old_productInfo_ivar = class_getInstanceVariable(aClass, "dataSouceArr");
    }
    
    if(old_productInfo_ivar) {
        //这个ivar是不存在的
        id old_productInfo_object = object_getIvar(self, old_productInfo_ivar);
        self.hook_dataSouceArr = old_productInfo_object;
    }
    
    if(self.hook_dataSouceArr) {
        NSLog(@"%@\n", self.hook_dataSouceArr);
    }
    
    //自定义 跳转
//    RXWebKitViewController *webController = [RXWebKitViewController new];
//    [self.navigationController pushViewController:webController animated:YES];
//    return;
    
    //还想使用以前的跳转，上面只想获取变量的操作而已 ?
    [self hook_Mine_jumpByProductURL];
}


- (RXUser *)hook_dataSouceArr {
    return objc_getAssociatedObject(self, HACK_MIME_USER_KEY);
}

- (void)setHook_dataSouceArr:(RXUser *)hook_dataSouceArr
{
    // 第一个参数：给哪个对象添加关联
    // 第二个参数：关联的key，通过这个key获取
    // 第三个参数：关联的value
    // 第四个参数:关联的策略
    objc_setAssociatedObject(self, HACK_MIME_USER_KEY, hook_dataSouceArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
