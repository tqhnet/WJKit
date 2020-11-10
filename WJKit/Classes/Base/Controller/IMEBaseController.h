//
//  IMEBaseController.h
//  dewu
//
//  Created by tqh on 2020/7/8.
//  Copyright © 2020 tqh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMEBaseNavView.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMEBaseController : UIViewController

@property (nonatomic,strong) IMEBaseNavView *navView;
@property (nonatomic,assign) BOOL haveNav;//是否有导航栏的高度间距（默认有）

@end

NS_ASSUME_NONNULL_END
