//
//  RXCaCheController.m
//  RXExtenstion
//
//  Created by srx on 16/5/5.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXCaCheController.h"

//简单的封装 缓存处理【没有考虑 线程安全】
#import "TTCacheUtil.h"

///字符处理 、数组、 字典 -> 空处理
#import "RXCharacter.h"


#include "RXCacheC.h"

@implementation RXCaCheController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nomalShowLabel.hidden = NO;
    
    NSString * string = @"https://github.com/srxboys";
    
    if([string strBOOL]) {
        //是否为字符串
    }
    
    if([string urlBOOL]) {
        //是否为 网址
    }
    
    if([string arrBOOL]) {
        //是否为 数组
    }
    
    string = @"0"; // or --> string = @"<null>"
    NSString * dictValue = [string strNotEmptyValue];
    RXLog(@"dictValue=%@", dictValue);
    
    
    //我很懒，我没有写页面
    // 数据安全(就是多线程问题)
    // 通过下面各种途径，封装个适合自己的【安全缓存】吧！！
    
    [self oc_Use_C_save_Option];
    [self oc_Use_C_get_Option];
}

#pragma mark ---- 用 C 去操作-----
- (void)oc_Use_C_save_Option {
    NSString * filePath = RXCacheFile(@"c.txt");
    
    NSString * dataString = @"srxboys";
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    //NSString转char * /const char *
    const char * filePathChar = [filePath UTF8String];
    BOOL result = saveToFileUseC(filePathChar, [data bytes]);
    RXLog(@"C option result = %@", result?@"成功":@"失败");
}

- (void)oc_Use_C_get_Option {
    NSString * filePath = RXCacheFile(@"c.txt");
    //NSString转char * /const char *
    const char * filePathChar = [filePath UTF8String];
    
    char * resultChar = getInFileUseC(filePathChar);
    //不能直接使用，否则乱码。需要转OC的 NSString才正常
    
    NSString * resultString = [NSString stringWithUTF8String:resultChar];
    RXLog(@"C option result = %@\ndata=%s\nstring=%@", strlen(resultChar)>0?@"成功":@"失败", resultChar,resultString);
}


#pragma mark ------我没有去封装，因为看过YYCache的封装，我服了-----
#pragma mark ------【TTCacheUtil操作】使用第三方(很多啦)------
//存取 *.plist / *.json
- (void)saveToDict {
    NSDictionary * dict = @{@"TTCacheUtil_key":@"TTCacheUtil_value"};
    NSString * filePath = RXCacheFile(@"demo.plist");
    [TTCacheUtil writeObject:dict toFile:filePath];
    
    //如果 只有针对性的 页面做缓存， demo.plist 应为为 有明确页面和缓存特性的去起名字
}

- (void)getOfDict {
    NSDictionary * getDict = [TTCacheUtil objectFromFile:RXCacheFile(@"demo.plist")];
    RXLog(@"getOfDict=%@", getDict);
}


#pragma mark ------【归档 缓存数据模型、NSArray等】------
- (void)saveArchive {
    //归档
    //如果是 【数据模型】要 <NSCoding>
    
    NSArray * array = @[@"Archive_array_0", @"Archive_array_1"];
    
    //下面 array/dictionary/数据模型 只要准守 <NSCoding>
    NSData * newData = [NSKeyedArchiver archivedDataWithRootObject:array];
    [NSKeyedArchiver archiveRootObject:newData toFile:RXCacheFile(@"archiveArray")];
}

- (void)getUNArchive {
    //解档
    NSData * oldData = [NSKeyedUnarchiver unarchiveObjectWithFile:RXCacheFile(@"archiveArray")];
    
    //和 归档类型一致
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:oldData];
    RXLog(@"getUNArchive=%@", array);
}


#pragma mark ------【自己写文件操作】------
- (void)saveTofile {
    @autoreleasepool {
        //和 【TTCacheUtil】类似 【具体 什么内容存储，看你自己了】
        
        //文件管理
        NSFileManager * fileManger = [NSFileManager defaultManager];
        
        // 获取tmp目录 , iphone 能获取正确的 tmp 目录, osx好像不能获取
        NSString *tempPath = NSTemporaryDirectory();
        
        //文件名 拼接到目录尾
        NSString *tempFile = [tempPath stringByAppendingPathComponent:@"file.txt"];
        if (![fileManger fileExistsAtPath:tempFile]) {
            //该目录，没有该文件
            [fileManger createFileAtPath:tempFile contents:nil attributes:nil];
        }
        
        //创建缓冲区【TTCacheUtil把数组、字典 用JSON转的】
        NSMutableData *writer = [[NSMutableData alloc] init];
        [writer appendData:[@"数据内容" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        //写入
        [writer writeToFile:tempFile atomically:YES];
        
        //读取
//        NSData * data = [NSData dataWithContentsOfFile:<#(nonnull NSString *)#>]
        
    }
}


#pragma mark ------【沙盒】------
//简单吧！不写了
- (void)saveUserDefault {
//    [[NSUserDefaults standardUserDefaults] set...];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark ------【数据库】------
// 【core Data】(apple develop)
// 【SQLite】(常用于封装SDK)
// SQLite-【FMDB】(MRC,app开发推荐)
// 【realm】
// 【leveldb】(leveldb是c++，使用也是C++,不推荐)


// 【Memento Database】(只适用Android,google开发的)

// ❓ 我不写了，百度吧！！太多了。

@end
