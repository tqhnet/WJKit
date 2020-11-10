//
//  WJAlertController+TransitionAnimate.m
//  alertControl
//
//  Created by 谭启宏 on 15/12/25.
//  Copyright © 2015年 谭启宏. All rights reserved.
//

#import "WJAlertController+TransitionAnimate.h"
#import "WJAlertFadeAnimation.h"
#import "WJAlertScaleFadeAnimation.h"
#import "WJAlertDropDownAnimation.h"

@implementation WJAlertController (TransitionAnimate)

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    switch (self.transitionAnimation) {
        case 0:
            return [WJAlertFadeAnimation alertAnimationIsPresenting:YES];
        case 1:
            return [WJAlertScaleFadeAnimation alertAnimationIsPresenting:YES];
        case 2:
            return [WJAlertDropDownAnimation alertAnimationIsPresenting:YES];
        default:
            return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    switch (self.transitionAnimation) {
        case 0:
            return [WJAlertFadeAnimation alertAnimationIsPresenting:NO];
        case 1:
            return [WJAlertScaleFadeAnimation alertAnimationIsPresenting:NO];
        case 2:
            return [WJAlertDropDownAnimation alertAnimationIsPresenting:NO];
        default:
            return nil;
    }
}

@end
