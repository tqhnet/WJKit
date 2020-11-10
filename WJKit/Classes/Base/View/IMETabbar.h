//
//  IMETabbar.h
//  dewu
//
//  Created by tqh on 2020/7/9.
//  Copyright © 2020 tqh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMEMainTabBarItemModel.h"

@protocol IMETabbarDelegate <NSObject>


@optional
- (void)IMETabbarDidItem:(NSInteger)index;
- (void)IMETabbarDidAdd;

@end

NS_ASSUME_NONNULL_BEGIN

@interface IMETabbar : UIView

- (void)addViewControllers:(NSArray <IMEMainTabBarItemModel *>*)viewControllers;

@property (nonatomic,weak) id <IMETabbarDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
