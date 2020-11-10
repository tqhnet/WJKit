//
//  WJAlertDropDownAnimation.m
//  alertControl
//
//  Created by 谭启宏 on 15/12/25.
//  Copyright © 2015年 谭启宏. All rights reserved.
//

#import "WJAlertDropDownAnimation.h"

@implementation WJAlertDropDownAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        return 0.5;
    }
    return 0.25;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    WJAlertController *alertController = (WJAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    alertController.backgroundView.alpha = 0.0;
    
    switch (alertController.preferredStyle) {
        case WJAlertControllerStyleAlert:
            alertController.alertView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetMaxY(alertController.alertView.frame));
            break;
        case WJAlertControllerStyleActionSheet:
            NSLog(@"don't support ActionSheet style!");
            break;
        default:
            break;
    }
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.65 initialSpringVelocity:0.5 options:0 animations:^{
        
        alertController.backgroundView.alpha = 1.0;
        alertController.alertView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
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
                NSLog(@"don't support ActionSheet style!");
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}


@end
