//
//  IMEBaseNavView.h
//  dewu
//
//  Created by tqh on 2020/7/8.
//  Copyright © 2020 tqh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMEBaseNavView : UIView

@property (nonatomic,assign) NSString *title;
@property (nonatomic,strong) UIButton *leftButton;

@property (nonatomic,copy) dispatch_block_t backBlock;
@property (nonatomic,copy) dispatch_block_t doneBlcok;

@end


NS_ASSUME_NONNULL_END
