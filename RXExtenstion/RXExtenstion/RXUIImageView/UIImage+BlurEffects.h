//
//  UIImage+BlurEffects.h
//
//  Copyright (c) 2015 luckytianyiyan (http://tianyiyan.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

@interface UIImage (BlurEffects)

+ (nullable UIImage*)ty_imageByApplyingLightEffectToImage:(nonnull UIImage*)inputImage;
+ (nullable UIImage*)ty_imageByApplyingExtraLightEffectToImage:(nonnull UIImage*)inputImage;
+ (nullable UIImage*)ty_imageByApplyingDarkEffectToImage:(nonnull UIImage*)inputImage;
+ (nullable UIImage*)ty_imageByApplyingTintEffectWithColor:(nullable UIColor *)tintColor toImage:(nonnull UIImage*)inputImage;

/**
 *  @brief  Applies a blur, tint color, and saturation adjustment to @a inputImage,
 *  optionally within the area specified by @a maskImage.
 *
 *  @param inputImage
 *         The source image.  A modified copy of this image will be returned.
 *  @param blurRadius            blurRadius
 *         The radius of the blur in points.
 *  @param tintColor             tintColor
 *         An optional UIColor object that is uniformly blended with the
 *         result of the blur and saturation operations.  The alpha channel
 *         of this color determines how strong the tint is.
 *  @param saturationDeltaFactor saturationDeltaFactor
 *         A value of 1.0 produces no change in the resulting image.  Values
 *         less than 1.0 will desaturation the resulting image while values
 *         greater than 1.0 will have the opposite effect.
 *  @param maskImage             maskImage
 *         If specified, @a inputImage is only modified in the area(s) defined
 *         by this mask.  This must be an image mask or it must meet the
 *         requirements of the mask parameter of CGContextClipToMask.
 *
 */
+ (nullable UIImage*)ty_imageByApplyingBlurToImage:(nonnull UIImage*)inputImage
                                        withRadius:(CGFloat)blurRadius
                                         tintColor:(nullable UIColor *)tintColor
                             saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                                         maskImage:(nullable UIImage *)maskImage;

@end
