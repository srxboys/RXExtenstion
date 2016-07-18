//
//  UIImage+BlurEffects.m
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

#import "UIImage+BlurEffects.h"

static const CGFloat kTintColorWhiteLight = 1.f;
static const CGFloat kTintColorAlphaLight = 0.3f;
static const CGFloat kRadiusLight = 60.f;
static const CGFloat kSaturationDeltaLight = 1.8f;

static const CGFloat kTintColorWhiteExtraLight = 0.97f;
static const CGFloat kTintColorAlphaExtraLight = 0.82f;
static const CGFloat kRadiusExtraLight = 40.f;
static const CGFloat kSaturationDeltaExtraLight = 1.8f;

static const CGFloat kTintColorWhiteDark = 0.11f;
static const CGFloat kTintColorAlphaDark = 0.73f;
static const CGFloat kRadiusDark = 40.f;
static const CGFloat kSaturationDeltaDark = 1.8f;

static const CGFloat kTintColorAlphaTintEffect = 0.6f;
static const CGFloat kRadiusTintEffect = 20.f;
static const CGFloat kSaturationDeltaTintEffect = -1.f;

@import Accelerate;

@implementation UIImage (BlurEffects)

#pragma mark - Default Effects

+ (UIImage *)ty_imageByApplyingLightEffectToImage:(UIImage*)inputImage
{
    UIColor *tintColor = [UIColor colorWithWhite:kTintColorWhiteLight alpha:kTintColorAlphaLight];
    return [self ty_imageByApplyingBlurToImage:inputImage withRadius:kRadiusLight tintColor:tintColor saturationDeltaFactor:kSaturationDeltaLight maskImage:nil];
}

+ (UIImage *)ty_imageByApplyingExtraLightEffectToImage:(UIImage*)inputImage
{
    UIColor *tintColor = [UIColor colorWithWhite:kTintColorWhiteExtraLight alpha:kTintColorAlphaExtraLight];
    return [self ty_imageByApplyingBlurToImage:inputImage withRadius:kRadiusExtraLight tintColor:tintColor saturationDeltaFactor:kSaturationDeltaExtraLight maskImage:nil];
}

+ (UIImage *)ty_imageByApplyingDarkEffectToImage:(UIImage*)inputImage
{
    UIColor *tintColor = [UIColor colorWithWhite:kTintColorWhiteDark alpha:kTintColorAlphaDark];
    return [self ty_imageByApplyingBlurToImage:inputImage withRadius:kRadiusDark tintColor:tintColor saturationDeltaFactor:kSaturationDeltaDark maskImage:nil];
}

+ (UIImage *)ty_imageByApplyingTintEffectWithColor:(UIColor *)tintColor
                                           toImage:(UIImage*)inputImage
{
    UIColor *effectColor = tintColor;
    size_t componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:kTintColorAlphaTintEffect];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:kTintColorAlphaTintEffect];
        }
    }
    return [self ty_imageByApplyingBlurToImage:inputImage withRadius:kRadiusTintEffect tintColor:effectColor saturationDeltaFactor:kSaturationDeltaTintEffect maskImage:nil];
}

#pragma mark - Base

+ (UIImage*)ty_imageByApplyingBlurToImage:(UIImage*)inputImage
                               withRadius:(CGFloat)blurRadius
                                tintColor:(UIColor *)tintColor
                    saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                                maskImage:(UIImage *)maskImage
{
    
    // Check pre-conditions.
    if (inputImage.size.width < 1 || inputImage.size.height < 1) {
//        NSLog(@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", inputImage.size.width, inputImage.size.height, inputImage);
        return nil;
    }
    if (!inputImage.CGImage) {
//        NSLog(@"*** error: inputImage must be backed by a CGImage: %@", inputImage);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
//        NSLog(@"*** error: effectMaskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    
    CGImageRef inputCGImage = inputImage.CGImage;
    CGFloat inputImageScale = inputImage.scale;
    
    CGSize outputImageSizeInPoints = inputImage.size;
    CGRect outputImageRectInPoints = { CGPointZero, outputImageSizeInPoints };
    
    // Set up output context.
    BOOL useOpaqueContext = [UIImage p_useOpaqueContext:inputCGImage];

    UIGraphicsBeginImageContextWithOptions(outputImageRectInPoints.size, useOpaqueContext, inputImageScale);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -outputImageRectInPoints.size.height);
    
    if (hasBlur || hasSaturationChange) {
        vImage_Buffer effectInBuffer;
        vImage_Buffer scratchBuffer1;
        
        vImage_Buffer *inputBuffer;
        vImage_Buffer *outputBuffer;
        
        vImage_CGImageFormat format = {
            .bitsPerComponent = 8,
            .bitsPerPixel = 32,
            .colorSpace = NULL,
            // (kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little)
            // requests a BGRA buffer.
            .bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little,
            .version = 0,
            .decode = NULL,
            .renderingIntent = kCGRenderingIntentDefault
        };
        
        vImage_Error e = vImageBuffer_InitWithCGImage(&effectInBuffer, &format, NULL, inputImage.CGImage, kvImagePrintDiagnosticsToConsole);
        if (e != kvImageNoError) {
//            NSLog(@"*** error: vImageBuffer_InitWithCGImage returned error code %zi for inputImage: %@", e, inputImage);
            UIGraphicsEndImageContext();
            return nil;
        }
        
        vImageBuffer_Init(&scratchBuffer1, effectInBuffer.height, effectInBuffer.width, format.bitsPerPixel, kvImageNoFlags);
        inputBuffer = &effectInBuffer;
        outputBuffer = &scratchBuffer1;
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * inputImageScale;
            if (inputRadius - 2.f < __FLT_EPSILON__)
                inputRadius = 2.f;
            uint32_t radius = floor((inputRadius * 3.f * sqrt(2 * M_PI) / 4 + 0.5f) / 2);
            
            radius |= 1; // force radius to be odd so that the three box-blur methodology works.
            
            NSInteger tempBufferSize = vImageBoxConvolve_ARGB8888(inputBuffer, outputBuffer, NULL, 0, 0, radius, radius, NULL, kvImageGetTempBufferSize | kvImageEdgeExtend);
            void *tempBuffer = malloc(tempBufferSize);
            
            vImageBoxConvolve_ARGB8888(inputBuffer, outputBuffer, tempBuffer, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(outputBuffer, inputBuffer, tempBuffer, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(inputBuffer, outputBuffer, tempBuffer, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
            
            free(tempBuffer);
            
            vImage_Buffer *temp = inputBuffer;
            inputBuffer = outputBuffer;
            outputBuffer = temp;
        }
        
        // SATURATION ADJUSTMENT
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            // These values appear in the W3C Filter Effects spec:
            // https://dvcs.w3.org/hg/FXTF/raw-file/default/filters/index.html#grayscaleEquivalent
            //
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,                    1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            vImageMatrixMultiply_ARGB8888(inputBuffer, outputBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            
            vImage_Buffer *temp = inputBuffer;
            inputBuffer = outputBuffer;
            outputBuffer = temp;
        }
        
        CGImageRef effectCGImage;
        if ( (effectCGImage = vImageCreateCGImageFromBuffer(inputBuffer, &format, NULL, NULL, kvImageNoAllocate, NULL)) == NULL ) {
            effectCGImage = vImageCreateCGImageFromBuffer(inputBuffer, &format, NULL, NULL, kvImageNoFlags, NULL);
            free(inputBuffer->data);
        }
        if (maskImage) {
            // Only need to draw the base image if the effect image will be masked.
            CGContextDrawImage(outputContext, outputImageRectInPoints, inputCGImage);
        }
        
        // draw effect image
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, outputImageRectInPoints, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, outputImageRectInPoints, effectCGImage);
        CGContextRestoreGState(outputContext);
        
        // Cleanup
        CGImageRelease(effectCGImage);
        free(outputBuffer->data);
    } else {
        // draw base image
        CGContextDrawImage(outputContext, outputImageRectInPoints, inputCGImage);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, outputImageRectInPoints);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

#pragma mark - Private Helper

+ (BOOL)p_useOpaqueContext:(CGImageRef)inputCGImage
{
    CGBitmapInfo inputImageBitmapInfo = CGImageGetBitmapInfo(inputCGImage);
    CGImageAlphaInfo inputImageAlphaInfo = (inputImageBitmapInfo & kCGBitmapAlphaInfoMask);
    
    if (inputImageAlphaInfo == kCGImageAlphaNone ||
        inputImageAlphaInfo == kCGImageAlphaNoneSkipLast ||
        inputImageAlphaInfo == kCGImageAlphaNoneSkipFirst) {
        return YES;
    } else {
        return NO;
    }
}

@end
