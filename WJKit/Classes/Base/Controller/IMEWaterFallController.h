//
//  IMEWaterFallController.h
//  dewu
//
//  Created by tqh on 2020/7/9.
//  Copyright © 2020 tqh. All rights reserved.
//

#import "IMEBaseController.h"
#import "CHTCollectionViewWaterfallLayout.h"
NS_ASSUME_NONNULL_BEGIN
/**瀑布流控制器**/
@interface IMEWaterFallController : IMEBaseController<UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic) BOOL showRefreshHeader;

@property (nonatomic) BOOL showRefreshFooter;

@property (nonatomic, readonly) BOOL isHeaderRefreshing;

@property (nonatomic, readonly) BOOL isFooterRefreshing;

- (void)tableViewDidTriggerHeaderRefresh;

- (void)tableViewDidTriggerFooterRefresh;

- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload;

@end

NS_ASSUME_NONNULL_END
