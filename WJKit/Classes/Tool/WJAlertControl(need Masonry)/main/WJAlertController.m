//
//  WJAlertController.m
//  alertControl
//
//  Created by 谭启宏 on 15/12/25.
//  Copyright © 2015年 谭启宏. All rights reserved.
//

#import "WJAlertController.h"
#import "Masonry.h"
#import "WJAlertController+TransitionAnimate.h"


// 判断是否是iPhone X系列
#define IS_iPhoneX      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
(\
CGSizeEqualToSize(CGSizeMake(375, 812),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(812, 375),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(414, 896),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(896, 414),[UIScreen mainScreen].bounds.size))\
:\
NO)

//#import "MouoWalletRechargeView.h"
//#import "MouoBalancePayPasswordView.h"

@interface WJAlertController ()

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, assign) WJAlertControllerStyle preferredStyle;

@property (nonatomic, assign) NSInteger transitionAnimation;

@property (nonatomic, weak) UITapGestureRecognizer *singleTap;

@property (nonatomic,assign)CGFloat alertViewCenterYOffset;
@property (nonatomic,assign)CGFloat alertViewCenterXOffset;
@end

@implementation WJAlertController

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(WJAlertControllerStyle)preferredStyle {
    
    //判断类型使用不同的过渡动画
    if (preferredStyle == WJAlertControllerStyleActionSheet || preferredStyle == WJAlertControllerStyleActionSheetTop) {
         return [[self alloc]initWithAlertView:alertView preferredStyle:preferredStyle transitionAnimation:0];
    }else {
         return [[self alloc]initWithAlertView:alertView preferredStyle:preferredStyle transitionAnimation:1];
    }
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(WJAlertControllerStyle)preferredStyle transitionAnimation:(NSInteger)transitionAnimation {
    return [[self alloc]initWithAlertView:alertView preferredStyle:preferredStyle transitionAnimation:transitionAnimation];
}

- (instancetype)initWithAlertView:(UIView *)alertView preferredStyle:(WJAlertControllerStyle)preferredStyle transitionAnimation:(NSInteger)transitionAnimation {
    self = [super init];
    if (self) {
        _alertView = alertView;
        _backgoundTapDismissEnable = YES;
        _preferredStyle = preferredStyle;
        _transitionAnimation = transitionAnimation;
        self.cankeyBoardNotify = YES;//允许键盘监听
        self.canIphoneXSpace = YES;
        [self configureController];
    
    }
    return self;

}

- (void)replayAnimation {
    
    self.backgroundView.alpha = 0.0;
    switch (self.preferredStyle) {
        case WJAlertControllerStyleAlert:
            self.alertView.alpha = 0.0;
            self.alertView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            break;
        case WJAlertControllerStyleActionSheet:
            self.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.alertView.frame));
            break;
        case WJAlertControllerStyleActionSheetTop:
            self.alertView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.alertView.frame));
            break;
        default:
            break;
    }
    
}

- (void)startAnimation {
    self.backgroundView.alpha = 0.0;
    
    switch (self.preferredStyle) {
        case WJAlertControllerStyleAlert:
            self.alertView.alpha = 0.0;
            self.alertView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            break;
        case WJAlertControllerStyleActionSheet:
            self.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.alertView.frame));
            break;
        case WJAlertControllerStyleActionSheetTop:
            self.alertView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.alertView.frame));
            break;
        default:
            break;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            self.backgroundView.alpha = 1.0;
            switch (self.preferredStyle) {
                case WJAlertControllerStyleAlert:
                    self.alertView.alpha = 1.0;
                    self.alertView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    break;
                case WJAlertControllerStyleActionSheet:
                    self.alertView.transform = CGAffineTransformMakeTranslation(0, -10.0);
                    break;
                case WJAlertControllerStyleActionSheetTop:
                    self.alertView.transform = CGAffineTransformIdentity;
                    break;
                default:
                    break;
            }
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.alertView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
               
            }];
        }];
    });
}
- (void)endAnimation {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.alpha = 0.0;
        switch (self.preferredStyle) {
            case WJAlertControllerStyleAlert:
                self.alertView.alpha = 0.0;
                self.alertView.transform = CGAffineTransformMakeScale(0.9, 0.9);
                break;
            case WJAlertControllerStyleActionSheet:
                self.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.alertView.frame));
                break;
            case WJAlertControllerStyleActionSheetTop:
                self.alertView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.alertView.frame));
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self addBackgroundView];
    [self addSingleTapGesture];
    [self configureAlertView];
    //不允许则为0
    if (!self.canIphoneXSpace) {
        self.actionSheetStyleBottomEdging = 0;
    }
    [self.view layoutIfNeeded];
    if (self.keyBoard) {
        return;
    }
    if (!self.cankeyBoardNotify) {
        return;
    }
    if (_preferredStyle == WJAlertControllerStyleAlert || _preferredStyle == WJAlertControllerStyleActionSheet) {
        //键盘监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    for (id object in _alertView.subviews) {
        
        if([object isKindOfClass:[UITextField class]] ){
            [object becomeFirstResponder];
        };
    }
}
#pragma mark - 背景视图

- (void)addBackgroundView {
    if (_backgroundView == nil) {
        UIView *backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
        backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _backgroundView = backgroundView;
    }
    _backgroundView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    [self.view insertSubview:_backgroundView atIndex:0];
//    [self.view addSubview:_backgroundView];
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
}

- (void)setBackgroundView:(UIView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = backgroundView;
    }else if(_backgroundView != backgroundView) {
        [self.view insertSubview:backgroundView aboveSubview:_backgroundView];
        backgroundView.alpha = 0;
        
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        [UIView animateWithDuration:0.3 animations:^{
            backgroundView.alpha = 1;
        } completion:^(BOOL finished) {
            [_backgroundView removeFromSuperview]; //移除原来的添加新的
            _backgroundView = backgroundView;
            [self addSingleTapGesture];
        }];
    }
}
- (void)addSingleTapGesture
{
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.enabled = _backgoundTapDismissEnable; //单击手势是否有用
    [_backgroundView addGestureRecognizer:singleTap];
    _singleTap = singleTap; //得到单击手势
}
- (void)setBackgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    _backgoundTapDismissEnable = backgoundTapDismissEnable;
    _singleTap.enabled = backgoundTapDismissEnable;
}

#pragma mark - configure

//核心配置
- (void)configureController {
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    //在WJAlertController+TransitionAnimate 写的转场过渡动画
    
    self.transitioningDelegate = self;
    _backgoundTapDismissEnable = NO;
    if (IS_iPhoneX) {
        _actionSheetStyleBottomEdging = 34;
    }else {
        _actionSheetStyleBottomEdging = 0;
    }
//    _actionSheetStyleBottomEdging = 0;
    _actionSheetStyleLeftEdging = 0;
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.1&&[[[UIDevice currentDevice] systemVersion] floatValue] <= 8.2) {
//        _actionSheetStyleBottomEdging = 164+64;
//    }
}

//自定义视图添加的位置
- (void)configureAlertView {
    if (_alertView == nil) {
        NSLog(@"%@: 提示:alertView is nil",NSStringFromClass([self class]));
        return;
    }
    _alertView.userInteractionEnabled = YES;
    [self.view addSubview:_alertView];
    switch (_preferredStyle) {
        case WJAlertControllerStyleActionSheet:
            [self layoutActionSheetStyleView];
            break;
        case WJAlertControllerStyleAlert:
            [self layoutAlertStyleView];
            break;
        case WJAlertControllerStyleActionSheetTop:
            [self layoutActionSheetTopStyleView];
            break;
        default:
            break;
    }
    
}

#pragma mark - layout

//actionsheet
- (void)layoutActionSheetStyleView {
   
    [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.actionSheetStyleLeftEdging);
        make.right.mas_equalTo(-self.actionSheetStyleLeftEdging);
        make.bottom.mas_equalTo(-self.actionSheetStyleBottomEdging);
        make.height.mas_equalTo(_alertView.bounds.size.height);
    }];

}

- (void)layoutActionSheetTopStyleView {
    
    [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.actionSheetStyleLeftEdging);
        make.right.mas_equalTo(-self.actionSheetStyleLeftEdging);
        make.top.mas_equalTo(self.actionSheetStyleBottomEdging);
        make.height.mas_equalTo(_alertView.bounds.size.height);
    }];
    
}

//alertView
- (void)layoutAlertStyleView {

    [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(_alertView.bounds.size);
        make.center.mas_equalTo(self.view);
    }];
    if (_alertView) {
        [_alertView layoutIfNeeded];
    }
    _alertViewCenterYOffset = _alertView.center.y;
    _alertViewCenterXOffset = _alertView.center.x;
}

#pragma mark - 事件监听

- (void)singleTap:(UITapGestureRecognizer *)sender {
//    if (self.dismiss) {
//        self.dismiss();
//    }else{
        [self dismissViewControllerAnimated:YES];
//    }
    
}

- (void)dismissViewControllerAnimated:(BOOL)animated
{

    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 通知
#pragma mark - notifycation

- (void)keyboardWillShow:(NSNotification*)notification{
    if (_preferredStyle == WJAlertControllerStyleAlert) {
        CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        CGFloat alertViewBottomEdge = CGRectGetHeight(self.view.frame) -  CGRectGetMaxY(_alertView.frame);
        CGFloat differ = CGRectGetHeight(keyboardRect) - alertViewBottomEdge;
        
        if (differ > 0) {
            [_alertView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(CGPointMake(0, - differ));
            }];
            [UIView animateWithDuration:0.25 animations:^{
                [self.view layoutIfNeeded];
            }];
        }
    }else if (_preferredStyle == WJAlertControllerStyleActionSheet){
        CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [_alertView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-CGRectGetHeight(keyboardRect));
        }];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillHide:(NSNotification*)notification{
    
    if (_preferredStyle == WJAlertControllerStyleAlert) {
        [_alertView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
        }];
        [self.view updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }else if (_preferredStyle == WJAlertControllerStyleActionSheet){
        [_alertView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-self.actionSheetStyleBottomEdging);
        }];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _alertView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

//弹出界面全部消失
+ (void)wj_AlldismissIsFinish:(void(^)(void))finish {
    UIViewController *currentVC = [self wj_findVisibleViewController];
    UIViewController *vcPresentVC = currentVC.presentingViewController;
     if (vcPresentVC) {
         while (vcPresentVC.presentingViewController)  {
             vcPresentVC = vcPresentVC.presentingViewController;
         }
         [vcPresentVC dismissViewControllerAnimated:YES completion:^{
             UIViewController *resultVC = [self wj_findVisibleViewController];
             if (resultVC.navigationController) {
                 if (resultVC.navigationController.viewControllers.count > 1) {
                    [resultVC.navigationController popToRootViewControllerAnimated:YES];
                     if (finish) {
                         finish();
                     }
                 }else {
                    if (finish) {
                        finish();
                    }
                 }
             }else {
                 if (finish) {
                     finish();
                 }
             }
         }];
     }else {
         if (finish) {
             finish();
         }
     }
}

//获取根控制器
+ (UIViewController *)wj_getRootViewController {
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

+ (UIViewController*)wj_viewControllerFromView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

//找到最顶层控制器
+ (UIViewController *)wj_findVisibleViewController {
    UIViewController* currentViewController = [self wj_getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else if ([currentViewController isKindOfClass:[UISplitViewController class]]) { // 当需要兼容 Ipad 时
                currentViewController = currentViewController.presentedViewController;
            } else {
                if (currentViewController.presentedViewController) {
                    currentViewController = currentViewController.presentedViewController;
                     NSLog(@"%@",[currentViewController class]);
                } else {
                    return currentViewController;
                }
            }
    }
    return currentViewController;
}

@end
