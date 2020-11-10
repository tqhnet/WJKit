//
//  TYAlertScaleFadeAnimation.m
//  alertControl
//
//  Created by 谭启宏 on 15/12/25.
//  Copyright © 2015年 谭启宏. All rights reserved.
//

#import "WJAlertScaleFadeAnimation.h"

@implementation WJAlertScaleFadeAnimation


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    WJAlertController *alertController = (WJAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    alertController.backgroundView.alpha = 0.0;
    
    switch (alertController.preferredStyle) {
        case WJAlertControllerStyleAlert:
            alertController.alertView.alpha = 0.0;
            alertController.alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            break;
        case WJAlertControllerStyleActionSheet:
            alertController.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertController.alertView.frame));
            break;
        default:
            break;
    }
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertController.backgroundView.alpha = 1.0;
        switch (alertController.preferredStyle) {
            case WJAlertControllerStyleAlert:
                alertController.alertView.alpha = 1.0;
                alertController.alertView.transform = CGAffineTransformIdentity;
                break;
            case WJAlertControllerStyleActionSheet:
                alertController.alertView.transform = CGAffineTransformIdentity;
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    WJAlertController *alertController = (WJAlertController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertController.backgroundView.alpha = 0.0;
        switch (alertController.preferredStyle) {
            case WJAlertControllerStyleAlert:
                alertController.alertView.alpha = 0.0;
                alertController.alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                break;
            case WJAlertControllerStyleActionSheet:
                alertController.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertController.alertView.frame));
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
