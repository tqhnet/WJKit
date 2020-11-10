//
//  IMEWaterFallController.m
//  dewu
//
//  Created by tqh on 2020/7/9.
//  Copyright © 2020 tqh. All rights reserved.
//

#import "IMEWaterFallController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import <MJRefresh/MJRefresh.h>
#import "IMEHeader.h"

@interface IMEWaterFallController ()


@end

@implementation IMEWaterFallController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
          [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    _showRefreshHeader = NO;
    _showRefreshFooter = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews {
    if (self.haveNav) {
        self.collectionView.frame = CGRectMake(0, NAVHEIGHT, SCREEN_WIDTH, self.view.height - NAVHEIGHT);
    }else {
        self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.height);
    }
    
}

#pragma mark - setter

- (void)setShowRefreshHeader:(BOOL)showRefreshHeader
{
    if (_showRefreshHeader != showRefreshHeader) {
        _showRefreshHeader = showRefreshHeader;
        if (_showRefreshHeader) {
            __weak typeof(self) weakSelf = self;
            self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [weakSelf tableViewDidTriggerHeaderRefresh];
            }];
            self.collectionView.mj_header.accessibilityIdentifier = @"refresh_header";
//                        header.updatedTimeHidden = YES;
        }
        else{
            [self.collectionView setMj_header:nil];
        }
    }
}

- (void)setShowRefreshFooter:(BOOL)showRefreshFooter
{
    if (_showRefreshFooter != showRefreshFooter) {
        _showRefreshFooter = showRefreshFooter;
        if (_showRefreshFooter) {
            __weak typeof(self) weakSelf = self;
            self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                [weakSelf tableViewDidTriggerFooterRefresh];
            }];
            self.collectionView.mj_footer.accessibilityIdentifier = @"refresh_footer";
        }
        else{
            [self.collectionView setMj_footer:nil];
        }
    }
}

#pragma mark - getter


- (BOOL)isHeaderRefreshing
{
    BOOL isRefreshing = NO;
    if (self.showRefreshHeader) {
        isRefreshing = self.collectionView.mj_header.isRefreshing;
    }
    
    return isRefreshing;
}

- (BOOL)isFooterRefreshing
{
    BOOL isRefreshing = NO;
    if (self.showRefreshFooter) {
        isRefreshing = self.collectionView.mj_footer.isRefreshing;
    }
    return isRefreshing;
}

#pragma mark - public refresh

- (void)autoTriggerHeaderRefresh
{
    if (self.showRefreshHeader) {
        [self tableViewDidTriggerHeaderRefresh];
    }
}

- (void)tableViewDidTriggerHeaderRefresh
{
    
}

- (void)tableViewDidTriggerFooterRefresh
{
    
}

- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (reload) {
            [weakSelf.collectionView reloadData];
        }
        
        if (isHeader) {
            [weakSelf.collectionView.mj_header endRefreshing];
        }
        else{
            [weakSelf.collectionView.mj_footer endRefreshing];
        }
    });
}

#pragma mark - <UICollectionViewDataSource,UICollectionViewDelegate>

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    if (index %2 ==0) {
        return CGSizeMake(100, 150);
    }else {
        return CGSizeMake(100, 100);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - lazy

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc]init];
        
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
