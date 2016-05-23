//
//  UIImageView+fadeInFadeOut.h
//  GHS
//
//  Created by srx on 16/5/5.
//  Copyright © 2016年 GHS. All rights reserved.
//

//srxboys 淡入淡入效果

#import "UIImageView+WebCache.h"

@interface UIImageView (fadeInFadeOut)

- (void)sd_setImageFIFOWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholde;

- (void)sd_setImageFIFOWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder animateWithDuration:(CGFloat)duration;

- (void)sd_setImageFIFOWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options animateWithDuration:(CGFloat)duration;

@end
