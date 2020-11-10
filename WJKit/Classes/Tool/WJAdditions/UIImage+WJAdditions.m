//
//  UIImage+WJAdditions.m
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/17.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import "UIImage+WJAdditions.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/UTCoreTypes.h>
@implementation UIImage (WJAdditions)


+ (UIImage *)QRencoderImage {
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    // 3.给过滤器添加数据
    NSString *dataString = @"http://www.520it.com";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    // 5.将CIImage转换成UIImage，并放大显示
    return [UIImage imageWithCIImage:outputImage scale:20.0 orientation:UIImageOrientationUp];
}

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIImage *)borderImage {
    UIImage *image = self;
    CGFloat top = 2; // 顶端盖高度
    CGFloat bottom = 2 ; // 底端盖高度
    CGFloat left = 2; // 左端盖宽度
    CGFloat right = 2; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    image = [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return image;
}

/*图片拉伸、平铺接口，兼容iOS5+*/
- (UIImage *)resizableImageWithCompatibleCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode
{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 6.0) {
        return [self resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
    } else if (version >= 5.0) {
        if (resizingMode == UIImageResizingModeStretch) {
            return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
        } else {//UIImageResizingModeTile
            return [self resizableImageWithCapInsets:capInsets];
        }
    } else {
        return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    }
}

/*图片以ScaleToFit方式拉伸后的CGSize*/
- (CGSize)sizeOfScaleToFit:(CGSize)scaledSize
{
    CGFloat scaleFactor = scaledSize.width / scaledSize.height;
    CGFloat imageFactor = self.size.width / self.size.height;
    if (scaleFactor <= imageFactor) {//图片横向填充
        return CGSizeMake(scaledSize.width, scaledSize.width / imageFactor);
    } else {//纵向填充
        return CGSizeMake(scaledSize.height * imageFactor, scaledSize.height);
    }
}

/*将图片转向调整为向上*/
- (UIImage *)fixOrientation
{
    if (self.imageOrientation == UIImageOrientationUp) {
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0.0, 0.0, self.size.width, self.size.height)];
    
    UIImage *fixedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return fixedImage;
    
}
/*以ScaleToFit方式压缩图片*/
- (UIImage *)compressedImageWithSize:(CGSize)compressedSize
{
    if (CGSizeEqualToSize(self.size, CGSizeZero) || (self.size.width <= compressedSize.width && self.size.height <= compressedSize.height)) {//不用压缩
        return self;
    }
    
    CGSize scaledSize = [self sizeOfScaleToFit:compressedSize];
    //压缩大小，调整转向
    UIGraphicsBeginImageContext(scaledSize);
    [self drawInRect:CGRectMake(0.0, 0.0, scaledSize.width, scaledSize.height)];
    UIImage *compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return compressedImage;
}

- (UIImage *)compressImagetoTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = self.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [self drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


#pragma mark  - 尺寸压缩
//    //压缩成宽高均为width的矩形
//+(UIImage *)imageWithFileInZip:(NSString *)filePath aimWidth:(NSInteger)width{
//    UIImage * image = [self imageWithFileInZip:filePath];
//    if (!image) {
//        return nil;
//    }
//    return [self imageWithImage:image aimWidth:width];
//}
    
    //压缩成宽高均为width的矩形
+ (UIImage *)imageWithImage:(UIImage *)image aimWidth:(NSInteger)width{
    if (!image) {
        return nil;
    }
    UIImage * newImage = [self rectImageWithImage:image];
    if (width > 0 && newImage.size.width > width) {
        return [self imageWithImage:newImage scaledToSize:CGSizeMake(width, width)];
    }
    return newImage;
}
    
    //指定压缩尺寸
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    if (!image) {
        return nil;
    }
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
    
    //剪切成方形image
+ (UIImage *)rectImageWithImage:(UIImage *)image{
    if (!image) {
        return nil;
    }
    
    if (image.size.width == image.size.height) {
        return image;
    }
    CGImageRef  image_cg = [image CGImage];
    CGSize      imageSize = CGSizeMake(CGImageGetWidth(image_cg), CGImageGetHeight(image_cg));
    
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    CGFloat width;
    CGPoint purePoint;
    if (imageWidth > imageHeight){
        width = imageHeight;
        purePoint = CGPointMake((imageWidth - width) / 2, 0);
    }else{
        width = imageWidth;
        purePoint = CGPointMake(0, (imageHeight - width) / 2);
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(purePoint.x, purePoint.y, width, width));
    UIImage * thumbImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbImage;
    
}
    
#pragma mark  - 质量压缩
    /**
     图片尺寸不变，压缩到指定大小
     
     @param image 要压缩的图片
     @param length 目标占用寸尺空间大小
     @param accuracy 压缩控制误差范围（＋／－）
     @param maxCircleNum 最大循环裁剪次数
     @return 目标image obj
     */
+ (NSData *)compressImageWithImage:(UIImage *)image aimLength:(NSInteger)length accurancyOfLength:(NSInteger)accuracy maxCircleNum:(int)maxCircleNum{
    if (!image) {
        return nil;
    }
    NSData * imageData = UIImageJPEGRepresentation(image, 1);
    CGFloat scale = image.size.height/image.size.width;
    if (imageData.length <= length + accuracy) {
        return imageData;
    }else{
        //先对质量进行0.99的压缩，再压缩尺寸
        NSData * imgData = UIImageJPEGRepresentation(image, 0.99);
        if (imgData.length <= length + accuracy) {
            return imgData;
        }else{
            UIImage * img = [UIImage imageWithData:imgData];
            int flag = 0;
            NSInteger maxWidth = img.size.width;
            NSInteger minWidth = 50;
            NSInteger midWidth = (maxWidth + minWidth)/2;
            if (flag == 0) {
                UIImage * newImage = [UIImage imageWithImage:img scaledToSize:CGSizeMake(minWidth, minWidth*scale)];
                NSData * data = UIImageJPEGRepresentation(newImage, 1);
                if ([data length] > length + accuracy) {
                    return data;
                }
            }
            
            while (1) {
                flag ++ ;
                UIImage * newImage = [UIImage imageWithImage:img scaledToSize:CGSizeMake(midWidth, midWidth*scale)];
                NSData * data = UIImageJPEGRepresentation(newImage, 1);
                NSInteger imageLength = data.length;
                if (flag >= maxCircleNum) {
                    return data;
                }
                
                if (imageLength > length + accuracy) {
                    maxWidth = midWidth;
                    midWidth = (minWidth + maxWidth)/2;
                    continue;
                }else if (imageLength < length - accuracy){
                    minWidth = midWidth;
                    midWidth = (minWidth + maxWidth)/2;
                    continue;
                }else{
                    return data;
                }
            }
        }
    }
}
    
    /**
     *  压缩图片质量
     *  aimWidth:  （宽高最大值）
     *  aimLength: 目标大小，单位：字节（b）
     *  accuracyOfLength: 压缩控制误差范围(+ / -)
     */
+ (NSData *)compressImageWithImage:(UIImage *)image aimWidth:(CGFloat)width aimLength:(NSInteger)length accuracyOfLength:(NSInteger)accuracy {
    if (!image) {
        return nil;
    }
    CGFloat imgWidth = image.size.width;
    CGFloat imgHeight = image.size.height;
    CGSize  aimSize;
    if (width >= imgWidth) {
        aimSize = image.size;
    }else{
        aimSize = CGSizeMake(width, width*imgHeight/imgWidth);
    }
    UIImage * newImage = [UIImage imageWithImage:image scaledToSize:aimSize];
    
    NSData  * data = UIImageJPEGRepresentation(newImage, 1);
    NSInteger imageDataLen = [data length];
    
    if (imageDataLen <= length + accuracy) {
        return data;
    }else{
        NSData * imageData = UIImageJPEGRepresentation( newImage, 0.99);
        if (imageData.length < length + accuracy) {
            return imageData;
        }
        
        
        CGFloat maxQuality = 1.0;
        CGFloat minQuality = 0.0;
        int flag = 0;
        
        while (1) {
            @autoreleasepool {
                CGFloat midQuality = (maxQuality + minQuality)/2;
                
                if (flag >= 6) {
                    NSData * data = UIImageJPEGRepresentation(newImage, minQuality);
                    return data;
                }
                flag ++;
                
                NSData * imageData = UIImageJPEGRepresentation(newImage, midQuality);
                NSInteger len = imageData.length;
                
                if (len > length+accuracy) {
                    maxQuality = midQuality;
                    continue;
                }else if (len < length-accuracy){
                    minQuality = midQuality;
                    continue;
                }else{
                    return imageData;
                    break;
                }
            }
        }
    }
}

//+ (NSData *)compressImageWithGIFData:(NSData *)data aimWidth:(CGFloat)width aimLength:(NSInteger)length accuracyOfLength:(NSInteger)accuracy {
//
//
//
//    return nil;
//}

//+ (NSData *)zipGIFWithData:(NSData *)data {
//    if (!data) {
//        return nil;
//    }
//    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
//    size_t count = CGImageSourceGetCount(source);
//    UIImage *animatedImage = nil;
//    NSMutableArray *images = [NSMutableArray array];
//    NSTimeInterval duration = 0.0f;
//    for (size_t i = 0; i < count; i++) {
//        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
//        duration += [self frameDurationAtIndex:i source:source];
//        UIImage *ima = [UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
//        ima = [ima zip];
//        [images addObject:ima];
//        CGImageRelease(image);
//        if (!duration) {
//            duration = (1.0f / 10.0f) * count;
//        }
//        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
//    }
//    CFRelease(source);
//    return UIImagePNGRepresentation(animatedImage);
//}

+ (NSData *)compressImageWithGIFData:(NSData *)data aimWidth:(CGFloat)width aimLength:(NSInteger)length accuracyOfLength:(NSInteger)accuracy {
    return [NSData dataWithContentsOfFile:[self exportGifImageData:data]];
//    if (!data) {
//        return nil;
//    }
//
//    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
//
//    size_t count = CGImageSourceGetCount(source);
//
//    UIImage *animatedImage;
//
//    if (count <= 1) {
//        animatedImage = [[UIImage alloc] initWithData:data];
//    }
//    else {
//        NSMutableArray *images = [NSMutableArray array];
//
//        NSTimeInterval duration = 0.0f;
//
//        for (size_t i = 0; i < count; i++) {
//            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
//            if (!image) {
//                continue;
//            }
//
//            duration += [self sd_frameDurationAtIndex:i source:source];
//            NSData *data = [UIImage compressImageWithImage:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp] aimWidth:width aimLength:length accuracyOfLength:accuracy];
//            UIImage *newImage = [UIImage imageWithData:data];
//            [images addObject:newImage];
//
////            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
////            [NSData]
//            CGImageRelease(image);
//        }
//
//        if (!duration) {
//            duration = (1.0f / 10.0f) * count;
//        }
//        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
//    }
//
//    CFRelease(source);
//    return UIImagePNGRepresentation(animatedImage);
}

/**
 合成gif
  图片路径数组
 */
+ (NSString *)exportGifImageData:(NSData *)data
{
    
    NSArray *images = [UIImage praseGIFDataToImageArray:data];
    NSArray *delays = nil;
    NSInteger loopCount = 0;
    NSString *fileName = [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"gif"];
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:filePath],
                                                                        kUTTypeGIF, images.count, NULL);
    if(!loopCount){
        loopCount = 0;
    }
    NSDictionary *gifProperties = @{ (__bridge id)kCGImagePropertyGIFDictionary: @{
                                             (__bridge id)kCGImagePropertyGIFLoopCount: @(loopCount), // 0 means loop forever
                                             }
                                     };
    float delay = 0.1; //默认每一帧间隔0.1秒
    for (int i=0; i<images.count; i++) {
        UIImage *itemImage = images[i];
        if(delays && i<delays.count){
            delay = [delays[i] floatValue];
        }
        //每一帧对应的延迟时间
        NSDictionary *frameProperties = @{(__bridge id)kCGImagePropertyGIFDictionary: @{
                                                  (__bridge id)kCGImagePropertyGIFDelayTime: @(delay), // a float (not double!) in seconds, rounded to centiseconds in the GIF data
                                                  }
                                          };
        CGImageDestinationAddImage(destination,itemImage.CGImage, (__bridge CFDictionaryRef)frameProperties);
    }
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)gifProperties);
    if (!CGImageDestinationFinalize(destination)) {
        NSLog(@"failed to finalize image destination");
    }
    CFRelease(destination);
    return filePath;
}

//gif转数组
+ (NSMutableArray *)praseGIFDataToImageArray:(NSData *)data;
{
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    CGFloat animationTime = 0.f;
    if (src) {
        size_t l = CGImageSourceGetCount(src);
        frames = [NSMutableArray arrayWithCapacity:l];
        for (size_t i = 0; i < l; i++) {
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime += [delayTime floatValue];
            if (img) {
                //图片压缩
                UIImage *image1 = [UIImage imageWithData:[UIImage compressImageWithImage:[UIImage imageWithCGImage:img] aimWidth:400 aimLength:50 accuracyOfLength:3]];
                [frames addObject:image1];
                CGImageRelease(img);
            }
        }
        CFRelease(src);
    }
    return frames;
}


+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}


- (NSString *)stringImageInfoSize {
    return [NSString stringWithFormat:@"%f_%f",self.size.width,self.size.height];
}

#pragma mark - orher
//#warning 生成二维码崩溃了
+ (UIImage *)encodeQRImageWithContent:(NSString *)content size:(CGSize)size {
    UIImage *codeImage = nil;
    
        NSData *stringData = [content dataUsingEncoding: NSUTF8StringEncoding];
        
        //生成
        CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [qrFilter setValue:stringData forKey:@"inputMessage"];
        [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
        
        UIColor *onColor = [UIColor blackColor];
        UIColor *offColor = [UIColor whiteColor];
        
        //上色
        CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                           keysAndValues:
                                 @"inputImage",qrFilter.outputImage,
                                 @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                                 @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
                                 nil];
        
        CIImage *qrImage = colorFilter.outputImage;
        CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(context, kCGInterpolationNone);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
        codeImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGImageRelease(cgImage);
  
    return codeImage;
}

+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

@end
