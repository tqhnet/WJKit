//
//  UIImage+WJAdditions.h
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/17.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WJAdditions)

+ (UIImage *)QRencoderImage;

/**
 *  绘制圆角
 *
 *  @param radius 圆角大小
 *
 *  @return 圆角UIImage
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

/**
 *  生成透明图片
 *
 *  @param color  颜色
 *  @param height 透明度
 *
 *  @return UIImage
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

/**图像边框默认的2像素*/
- (UIImage *)borderImage;

/**图片拉伸、平铺接口*/
- (UIImage *)resizableImageWithCompatibleCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode;

/**图片以ScaleToFit方式拉伸后的CGSize*/
- (CGSize)sizeOfScaleToFit:(CGSize)scaledSize;

/**将图片转向调整为向上*/
- (UIImage *)fixOrientation;

    
#pragma mark - 图片压缩
    
/**以ScaleToFit方式压缩图片*/
- (UIImage *)compressedImageWithSize:(CGSize)compressedSize;

/**图片根据宽度缩放*/
- (UIImage *)compressImagetoTargetWidth:(CGFloat)targetWidth;

/**
*  压缩图片质量
*  aimWidth:  （宽高最大值）
*  aimLength: 目标大小，单位：字节（b）
*  accuracyOfLength: 压缩控制误差范围(+ / -)
*/
+ (NSData *)compressImageWithImage:(UIImage *)image aimWidth:(CGFloat)width aimLength:(NSInteger)length accuracyOfLength:(NSInteger)accuracy;

+ (NSData *)compressImageWithGIFData:(NSData *)data aimWidth:(CGFloat)width aimLength:(NSInteger)length accuracyOfLength:(NSInteger)accuracy;

/*******图片的宽高信息字符串形式****/
- (NSString *)stringImageInfoSize;

#pragma mark - others
/**生成二维码*/
+ (UIImage *)encodeQRImageWithContent:(NSString *)content size:(CGSize)size;

/*
 *videoURL:视频地址(本地/网络)
 *time      :第N帧
 */
+ (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

@end
