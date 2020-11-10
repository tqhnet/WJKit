//
//  IMEHUD.h
//  dewu
//
//  Created by tqh on 2020/7/7.
//  Copyright © 2020 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 HUD
 */
@interface IMEHUD : NSObject

+ (void)showLoadingText:(NSString *)text;
//显示进度
+ (void)showLoading;

//显示提示
+ (void)showToast:(NSString *)text;

+ (void)hideHud;
//隐藏
+ (void)hide;

@end


NS_ASSUME_NONNULL_END
