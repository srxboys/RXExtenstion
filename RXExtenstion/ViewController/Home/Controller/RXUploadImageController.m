//
//  RXUploadImageController.m
//  RXExtenstion
//
//  Created by srx on 16/5/4.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXUploadImageController.h"

#import "RXAFNS.h"
#import "RXRandom.h"
#import "IBActionSheet.h"

@interface RXUploadImageController ()
{
    NSMutableArray * selectedImgArr;
}
@end

@implementation RXUploadImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configUI {
    
}

- (void)uploadImage {
    
    NSDictionary * dict = @{@"请求参数李彪": @""};
    weak(weakSelf);//弱引用
    [RXAFNS UploadDIYRequestWithParams:dict uploadParamsDIY:^(id<AFMultipartFormData> formData) {
        int i = 1;
        for (UIImage *image in selectedImgArr) {
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.2) name:[NSString stringWithFormat:@"file%d",i] fileName:[NSString stringWithFormat:@"file%d",i] mimeType:@"image/png"];
            i++;
        }

    } successBlock:^(Response *responseObject) {
        RXLog(@"请求成功");
    } failureBlock:^(NSError *error) {
        RXLog(@"请求失败");
    } showHUD:YES loadingInView:self.view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
