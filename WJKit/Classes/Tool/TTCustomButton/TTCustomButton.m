//
//  TTCustomButton.m
//  YJCloudLesson
//
//  Created by Lam_TT on 2018/4/25.
//  Copyright © 2018年 com.YJTC. All rights reserved.
//

#import "TTCustomButton.h"
@implementation TTCustomButton

#pragma mark Layout Subview
- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    if (imageWith == 0  || imageHeight == 0) {
        //此时还没有设置图片 不用设置edgeInsets
        return;
    }
    [self changeEdgeInsets];
}

- (void)changeEdgeInsets{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    //根据TTCustomButtonType和TT_spacing得到imageEdgeInsets和labelEdgeInsets的值
    switch (self.TT_buttonType) {
        case TTCustomButtonImageTop:{
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - self.TT_spacing , 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight - self.TT_spacing , 0);
            break;
        }
        case TTCustomButtonImageLeft:{
            
            imageEdgeInsets = UIEdgeInsetsMake(0, -self.TT_spacing , 0, self.TT_spacing );
            labelEdgeInsets = UIEdgeInsetsMake(0, self.TT_spacing , 0, -self.TT_spacing );
            break;
        }
        case TTCustomButtonImageBottom:{
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - self.TT_spacing , -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight - self.TT_spacing , -imageWith, 0, 0);
            break;
        }
        case TTCustomButtonImageRight:{
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + self.TT_spacing , 0, -labelWidth - self.TT_spacing );
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith - self.TT_spacing , 0, imageWith + self.TT_spacing );
            break;
        }
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    
}



- (void)setTT_buttonType:(TTCustomButtonType)TT_buttonType{
    _TT_buttonType  = TT_buttonType;
    
    if (self.frame.size.height == 0 || self.frame.size.width == 0) {
        //button还没设置frame  直接返回
        return;
    }
    
    [self changeEdgeInsets];
}

#pragma mark lazy loading
- (CGFloat)TT_spacing{
    if (!_TT_spacing) {
        _TT_spacing = 5;
    }
    return _TT_spacing;
}

@end
