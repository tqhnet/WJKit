//
//  IMEScrollSubController.m
//  dewu
//
//  Created by tqh on 2020/7/10.
//  Copyright © 2020 tqh. All rights reserved.
//

#import "IMEScrollSubController.h"
#import "IMEHeader.h"

@interface IMEScrollSubController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *viewControllers;
@property (nonatomic,assign) NSInteger selectIndex;

@end

@implementation IMEScrollSubController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
}

- (void)addViewControllers:(NSArray<IMEScrollSubModel *> *)viewControllers {
    [viewControllers enumerateObjectsUsingBlock:^(IMEScrollSubModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        IMEBaseController *controller = [NSClassFromString(obj.controllerName) new];
        controller.haveNav = NO;
        [self.viewControllers addObject:controller];
    }];
    
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH *viewControllers.count, self.contentHeight?self.contentHeight:self.view.height)];
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentHeight?self.contentHeight:self.view.height);
    [self selectIndexControllerWithIndex:self.selectIndex];
}

#pragma mark - <<UIScrollViewDelegate>>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = floor((scrollView.contentOffset.x - SCREEN_WIDTH / 2) / SCREEN_WIDTH) + 1;
    [self selectIndexControllerWithIndex:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(IMEScrollSubControllerDidScrollIndex:)]) {
        [self.delegate IMEScrollSubControllerDidScrollIndex:index];
    }
}

#pragma mark - public

- (void)scrollToIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(index *SCREEN_WIDTH, 0) animated:YES];
}

#pragma mark - private

- (void)selectIndexControllerWithIndex:(NSInteger)index {
    self.selectIndex = index;
    if (index < self.viewControllers.count) {
        UIViewController *vc = self.viewControllers[index];
       if (!vc.isViewLoaded) {
           vc.view.frame = CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, self.scrollView.height);
           [self.scrollView addSubview:vc.view];
           [self addChildViewController:vc];
       }
    }
}

#pragma mark - 懒加载

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    }
    return _scrollView;
}

- (NSMutableArray *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray new];
    }
    return _viewControllers;
}

@end
