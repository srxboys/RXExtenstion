//
//  RXCacheC.c
//  RXExtenstion
//
//  Created by srx on 2017/9/13.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#include "RXCacheC.h"

/*
    char * 转化 NSData
         方法一：
             char * a = (char*)malloc(sizeof(byte)*16);
             NSData * data = [NSData dataWithBytes:a length:strlen(a)];
         方法二：
             转换为NSString的 - (id)initWithUTF8String:(const char *)bytes
             然后用NSString的 - (NSData *)dataUsingEncoding:(NSStringEncoding)encoding
 
    NSData 转 char*
         NSData data;
         char* a=[data bytes];
 
  r只读  w只写 a文件尾(追加)
 
 
 //此文件，不可完全相信，我已经把C忘记的差不多了，这里只是回顾一点点。可能内存泄露。线程等等都没有使用。
 
 */

/** 存到本地 [文件名,数据] */
int saveToFileUseC(const char* fileName, const  char* data) {
    
    int dataLen = (int)(strlen(data));
    
    if((int)(strlen(fileName)) == 0) {
        return 0;
    }
    
    if(strlen(data) == 0) {
        return 0;
    }
    
    //"w" 如果原来有内容也会销毁
    FILE * fp = NULL;
    if((fp=fopen(fileName, "w")) == NULL) {
        printf("fileName=%s is open==fail", fileName);
        fclose(fp);
        return 0;
        
    }
    
    /*
       fgetc 读取一个字符
       EOF 是文件结束标志
       fputc()
       stdout 函数在屏幕上显示
     */
    
    fwrite(data, dataLen, dataLen, fp);
    
//    char ch;
//    while((ch=fgetc(fp))!=EOF)
//        fputc(ch,stdout);

    fflush(fp); //清除缓存
    fclose(fp); //关闭文件
    return 1;
}


char* getInFileUseC(const char* fileName) {
    if((int)(strlen(fileName)) == 0) {
        return "";
    }
    FILE * fp = NULL;
    if((fp=fopen(fileName, "r")) == NULL) {
        printf("fileName=%s is open==fail", fileName);
        fclose(fp);
        return "";
        
    }
    
    char buff[255];
    char *resultChars = NULL;
    resultChars = fgets(buff, 255, (FILE*)fp);
    printf("buff=%s---resultChars=%s\n", buff, resultChars);
//    memset(buff, 0x00, sizeof(char));
    fflush(fp); //清除缓存
    fclose(fp); //关闭文件
    return resultChars;
}
