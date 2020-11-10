//
//  IMEBaseNavView.m
//  dewu
//
//  Created by tqh on 2020/7/8.
//  Copyright © 2020 tqh. All rights reserved.
//

#import "IMEBaseNavView.h"
#import "IMEHeader.h"

@interface IMEBaseNavView()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation IMEBaseNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.lineView];
        
    }
    return self;
}

- (void)layoutSubviews {
    self.leftButton.frame = CGRectMake(0, HeightStatusBar, 44, 44);
    self.rightButton.frame = CGRectMake(SCREEN_WIDTH - 44, HeightStatusBar, 44, 44);
    self.titleLabel.frame = CGRectMake(0, HeightStatusBar, SCREEN_WIDTH, 44);
    self.lineView.frame = CGRectMake(0, self.height - 1, SCREEN_WIDTH, 1);
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

#pragma mark - onClick

- (void)leftButtonPressed {
    if (self.backBlock) {
        self.backBlock();
    }
}

#pragma mark - lazy

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton new];
        [_leftButton addTarget:self action:@selector(leftButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton setImage:[UIImage imageNamed:@"ime_base_nav_back"] forState:UIControlStateNormal];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton new];
    }
    return _rightButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5" alpha:0.5];
    }
    return _lineView;
}

@end
