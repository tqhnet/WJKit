//
//  WJAlertBaseAnimation.h
//  alertControl
//
//  Created by 谭启宏 on 15/12/25.
//  Copyright © 2015年 谭启宏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJAlertController.h"
@interface WJAlertBaseAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) BOOL isPresenting; // present . dismiss

+ (instancetype)alertAnimationIsPresenting:(BOOL)isPresenting;

////自定义的
//+ (instancetype)alertAnimationIsPresenting:(BOOL)isPresenting preferredStyle:(WJAlertControllerStyle) preferredStyle;

// override transiton time
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

// override present
- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

// override dismiss
- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
