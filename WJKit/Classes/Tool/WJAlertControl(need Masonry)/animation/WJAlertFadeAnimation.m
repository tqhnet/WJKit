//
//  WJAlertFadeAnimation.m
//  alertControl
//
//  Created by 谭启宏 on 15/12/25.
//  Copyright © 2015年 谭启宏. All rights reserved.
//

#import "WJAlertFadeAnimation.h"

@implementation WJAlertFadeAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        return 0.45;
        
    }
    return 0.25;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    WJAlertController *alertController = (WJAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    alertController.backgroundView.alpha = 0.0;
    
    switch (alertController.preferredStyle) {
        case WJAlertControllerStyleAlert:
            alertController.alertView.alpha = 0.0;
            alertController.alertView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            break;
        case WJAlertControllerStyleActionSheet:
            alertController.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertController.alertView.frame));
            break;
        case WJAlertControllerStyleActionSheetTop:
            alertController.alertView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(alertController.alertView.frame));
            break;
        default:
            break;
    }
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];
    
    [UIView animateWithDuration:0.25 animations:^{
        alertController.backgroundView.alpha = 1.0;
        switch (alertController.preferredStyle) {
            case WJAlertControllerStyleAlert:
                alertController.alertView.alpha = 1.0;
                alertController.alertView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                break;
            case WJAlertControllerStyleActionSheet:
                alertController.alertView.transform = CGAffineTransformMakeTranslation(0, -10.0);
                break;
            case WJAlertControllerStyleActionSheetTop:
                alertController.alertView.transform = CGAffineTransformIdentity;
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            alertController.alertView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }];
    
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    WJAlertController *alertController = (WJAlertController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:0.25 animations:^{
        alertController.backgroundView.alpha = 0.0;
        switch (alertController.preferredStyle) {
            case WJAlertControllerStyleAlert:
                alertController.alertView.alpha = 0.0;
                alertController.alertView.transform = CGAffineTransformMakeScale(0.9, 0.9);
                break;
            case WJAlertControllerStyleActionSheet:
                alertController.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertController.alertView.frame));
                break;
            case WJAlertControllerStyleActionSheetTop:
                alertController.alertView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(alertController.alertView.frame));
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
