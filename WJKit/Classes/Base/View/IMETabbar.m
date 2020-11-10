//
//  IMETabbar.m
//  dewu
//
//  Created by tqh on 2020/7/9.
//  Copyright © 2020 tqh. All rights reserved.
//

#import "IMETabbar.h"
#import "IMEHeader.h"

@interface IMETabbar ()

@property (nonatomic,strong) UIImageView *bgView;
@property (nonatomic,strong) UIButton *publishButton;
@property (nonatomic,strong) TTCustomButton *leftButton;
@property (nonatomic,strong) TTCustomButton *rightButton;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation IMETabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        self.layer.masksToBounds = NO;
        [self addSubview:self.bgView];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.publishButton];
//        [self addSubview:self.lineView];
    }
    return self;
}

- (void)layoutSubviews {
    self.lineView.frame = CGRectMake(0, 0, self.width, 1);
    self.bgView.frame = CGRectMake(0, 0, self.width, 50);
    self.publishButton.frame = CGRectMake(SCREEN_WIDTH/2 - 25, -14, 50, 50);
    self.leftButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 50);
    self.rightButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 50);
}

- (void)addViewControllers:(NSArray <IMEMainTabBarItemModel *>*)viewControllers {
    
    
    IMEMainTabBarItemModel *model1 = viewControllers[0];
    IMEMainTabBarItemModel *model2 = viewControllers[1];
    
    
    [self.leftButton setTitle:model1.title forState:UIControlStateNormal];
    [self.rightButton setTitle:model2.title forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:10];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.leftButton setImage:[UIImage imageNamed:model1.normalImage] forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:model1.selectedImage] forState:UIControlStateSelected];
    [self.rightButton setImage:[UIImage imageNamed:model2.normalImage] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:model2.selectedImage] forState:UIControlStateSelected];
    
    [self.leftButton setTitleColor:[UIColor colorWithHexString:@"b9b9b9"] forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor colorWithHexString:@"#01B37A"] forState:UIControlStateSelected];
    [self.rightButton setTitleColor:[UIColor colorWithHexString:@"b9b9b9"] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor colorWithHexString:@"#01B37A"] forState:UIControlStateSelected];
    
    [self buttonPressed:self.leftButton];
}

#pragma mark - onClick

- (void)buttonPressed:(UIButton *)sender {
    if (sender == self.leftButton) {
        sender.selected = YES;
        self.rightButton.selected = NO;
    }else {
        sender.selected = YES;
        self.leftButton.selected = NO;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(IMETabbarDidItem:)]) {
        [self.delegate IMETabbarDidItem:sender.tag];
    }
}

- (void)addButtonPressed {
    if (self.delegate && [self.delegate respondsToSelector:@selector(IMETabbarDidAdd)]) {
        [self.delegate IMETabbarDidAdd];
    }
}
#pragma mark - layz

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5" alpha:0.5];
    }
    return _lineView;
}

- (TTCustomButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [TTCustomButton new];
        [_leftButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.tag = 0;
    }
    return _leftButton;
}

- (TTCustomButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [TTCustomButton new];
        [_rightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.tag = 1;
    }
    return _rightButton;
}

- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton = [UIButton new];
        [_publishButton setImage:[UIImage imageNamed:@"tabbar_add"] forState:UIControlStateNormal];
        [_publishButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishButton;
}

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [UIImageView new];
        _bgView.image = [UIImage imageNamed:@"tabbar_bg"];
    }
    return _bgView;
}

@end
