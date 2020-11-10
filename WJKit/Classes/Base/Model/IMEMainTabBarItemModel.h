//
//  IMEMainTabBarItemModel.h
//  dewu
//
//  Created by tqh on 2020/7/8.
//  Copyright © 2020 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**标签栏模型数据**/
@interface IMEMainTabBarItemModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *normalImage;
@property (nonatomic,copy) NSString *selectedImage;
@property (nonatomic,copy) NSString *controllerName;

@end

NS_ASSUME_NONNULL_END
