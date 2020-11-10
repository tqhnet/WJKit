//
//  IMEBaseController.m
//  dewu
//
//  Created by tqh on 2020/7/8.
//  Copyright © 2020 tqh. All rights reserved.
//

#import "IMEBaseController.h"
#import "IMEBaseNavView.h"
#import "IMEHeader.h"


@interface IMEBaseController ()
@end

@implementation IMEBaseController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.haveNav = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    
    self.navView.leftButton.hidden = self.navigationController.viewControllers.count <= 1 ?YES:NO;
    __weak typeof(self) myself = self;
    [self.navView setBackBlock:^{
        if (myself.navigationController.viewControllers.count <= 1) {
            [myself dismissViewControllerAnimated:YES completion:nil];
        }else {
            [myself.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)setHaveNav:(BOOL)haveNav {
    _haveNav = haveNav;
    if (haveNav) {
        self.navView.hidden = NO;
        self.navView.height = NAVHEIGHT;
    }else {
        self.navView.hidden = YES;
        self.navView.height = 0;
    }
    if (self.isViewLoaded) {
        [self viewDidLayoutSubviews];
    }
}

- (IMEBaseNavView *)navView {
    if (!_navView) {
        _navView = [[IMEBaseNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVHEIGHT)];
    }
    return _navView;
}

@end
