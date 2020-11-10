//
//  IMEMainController.h
//  dewu
//
//  Created by tqh on 2020/7/8.
//  Copyright © 2020 tqh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMEMainTabBarItemModel.h"
#import "IMETabbar.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMEMainController : UIViewController<IMETabbarDelegate>
@property (strong, nonatomic) NSMutableArray *viewControllers;
/***添加控制器 **/
- (void)addViewControllers:(NSArray <IMEMainTabBarItemModel *>*)viewControllers;

@end

NS_ASSUME_NONNULL_END
