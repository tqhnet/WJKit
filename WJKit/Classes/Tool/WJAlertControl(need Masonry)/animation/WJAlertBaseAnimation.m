//
//  WJAlertBaseAnimation.m
//  alertControl
//
//  Created by 谭启宏 on 15/12/25.
//  Copyright © 2015年 谭启宏. All rights reserved.
//

#import "WJAlertBaseAnimation.h"

@interface WJAlertBaseAnimation ()

@property (nonatomic, assign) BOOL isPresenting;

@end

@implementation WJAlertBaseAnimation

- (instancetype)initWithIsPresenting:(BOOL)isPresenting
{
    if (self = [super init]) {
        self.isPresenting = isPresenting;
    }
    return self;
}

+ (instancetype)alertAnimationIsPresenting:(BOOL)isPresenting
{
    return [[self alloc]initWithIsPresenting:isPresenting];
}

//+ (instancetype)alertAnimationIsPresenting:(BOOL)isPresenting preferredStyle:(WJAlertControllerStyle)preferredStyle
//{
//    return [[self alloc]initWithIsPresenting:isPresenting];
//}

#pragma mark - <UIViewControllerAnimatedTransitioning>

// override this moethod
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (_isPresenting) {
        [self presentAnimateTransition:transitionContext];
    }else {
        [self dismissAnimateTransition:transitionContext];
    }
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
}

@end
