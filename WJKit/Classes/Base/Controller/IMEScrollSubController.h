//
//  IMEScrollSubController.h
//  dewu
//
//  Created by tqh on 2020/7/10.
//  Copyright © 2020 tqh. All rights reserved.
//

#import "IMEBaseController.h"
#import "IMEScrollSubModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IMEScrollSubControllerDelegate <NSObject>

- (void)IMEScrollSubControllerDidScrollIndex:(NSInteger)index;

@end

/**分页滚动控制器**/
@interface IMEScrollSubController : IMEBaseController

@property (nonatomic,assign) NSInteger contentHeight;
@property (nonatomic,weak) id<IMEScrollSubControllerDelegate>delegate;

- (void)addViewControllers:(NSArray <IMEScrollSubModel *>*)viewControllers;

//主动选中下标
- (void)scrollToIndex:(NSInteger)index;



@end

NS_ASSUME_NONNULL_END
