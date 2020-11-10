//
//  IMEHUD.m
//  dewu
//
//  Created by tqh on 2020/7/7.
//  Copyright © 2020 tqh. All rights reserved.
//

#import "IMEHUD.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation IMEHUD

+ (void)showLoadingText:(NSString *)text {
    [SVProgressHUD showWithStatus:text];
}

+ (void)showLoading {
    [SVProgressHUD show];
}

+ (void)hide {
    [SVProgressHUD dismiss];
}

+ (void)hideHud {
    [SVProgressHUD dismiss];
}

+ (void)showToast:(NSString *)text {
    [self hide];
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:text];
    [SVProgressHUD dismissWithDelay:2];
}

@end
