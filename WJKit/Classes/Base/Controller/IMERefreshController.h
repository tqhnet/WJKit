//
//  IMERefreshController.h
//  dewu
//
//  Created by tqh on 2020/7/8.
//  Copyright © 2020 tqh. All rights reserved.
//

#import "IMEBaseController.h"

NS_ASSUME_NONNULL_BEGIN

/**刷新控制器*/
@interface IMERefreshController : IMEBaseController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIView *defaultFooterView;

@property (strong, nonatomic) NSMutableArray *dataArray;//这里写数据源的话可以用数据源判断空状态

@property (nonatomic) NSInteger page;

@property (nonatomic) BOOL showRefreshHeader;

@property (nonatomic) BOOL showRefreshFooter;

@property (nonatomic, readonly) BOOL isHeaderRefreshing;

@property (nonatomic, readonly) BOOL isFooterRefreshing;

- (void)tableViewDidTriggerHeaderRefresh;

- (void)tableViewDidTriggerFooterRefresh;

- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload;

@end

NS_ASSUME_NONNULL_END
