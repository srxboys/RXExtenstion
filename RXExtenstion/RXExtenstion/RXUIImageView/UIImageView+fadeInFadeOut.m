//
//  UIImageView+fadeInFadeOut.m
//  GHS
//
//  Created by srx on 16/5/5.
//  Copyright © 2016年 GHS. All rights reserved.
//

#import "UIImageView+fadeInFadeOut.h"

@implementation UIImageView (fadeInFadeOut)

- (void)sd_setImageFIFOWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholde {
    [self sd_setImageFIFOWithURL:url placeholderImage:placeholde  animateWithDuration:0.35f];
}

- (void)sd_setImageFIFOWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder animateWithDuration:(CGFloat)duration {
    
    [self sd_setImageFIFOWithURL:url placeholderImage:placeholder options:SDWebImageRefreshCached | SDWebImageCacheMemoryOnly | SDWebImageRetryFailed | SDWebImageLowPriority animateWithDuration:duration];
}

- (void)sd_setImageFIFOWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options animateWithDuration:(CGFloat)duration {
    
    if(self == nil) return;
    if(![self isKindOfClass:[UIImageView class]]) return;
    /*
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image && cacheType == SDImageCacheTypeNone)  {
            CATransition *fadeIn = [CATransition animation];
            fadeIn.duration = duration;
            fadeIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            fadeIn.subtype = kCATransitionFade;
            [self.layer addAnimation:fadeIn forKey:@"fadeIn"];
        }
        else if(image == nil && cacheType == SDImageCacheTypeNone && error) {
            self.image = placeholder;
        }
    }];
    */
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options completed:^(UIImage * image, NSError * error, SDImageCacheType cacheType, NSURL * imageURL) {
         if (image && cacheType == SDImageCacheTypeNone)  {
             CATransition *fadeIn = [CATransition animation];
             fadeIn.duration = duration;
             fadeIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
             fadeIn.subtype = kCATransitionFade;
             [self.layer addAnimation:fadeIn forKey:@"fadeIn"];
         }
         else if(image == nil && cacheType == SDImageCacheTypeNone && error) {
             self.image = placeholder;
         }
        
     }];
     
}

@end
