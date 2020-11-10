//
//  TTCustomButton.h
//  YJCloudLesson
//
//  Created by Lam_TT on 2018/4/25.
//  Copyright © 2018年 com.YJTC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger) {
    TTCustomButtonImageTop    = 0 , //图片在上边
    TTCustomButtonImageLeft   = 1 , //图片在左边
    TTCustomButtonImageBottom = 2 , //图片在下边
    TTCustomButtonImageRight  = 3   //图片在右边
}TTCustomButtonType;

@interface TTCustomButton : UIButton
/** 图片和文字间距 默认10px*/
@property (nonatomic , assign) CGFloat TT_spacing;

/** 按钮类型 默认TTCustomButtonImageTop 图片在上边*/
@property (nonatomic , assign) TTCustomButtonType TT_buttonType;

@end
