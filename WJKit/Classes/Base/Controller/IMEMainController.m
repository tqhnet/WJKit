//
//  IMEMainController.m
//  dewu
//
//  Created by tqh on 2020/7/8.
//  Copyright © 2020 tqh. All rights reserved.
//

#import "IMEMainController.h"
#import "IMEHeader.h"


#define kColor_Blue [UIColor colorWithRed:45 / 255.0 green:116 / 255.0 blue:215 / 255.0 alpha:1.0]

@interface IMEMainController ()<UITabBarDelegate>

@property (nonatomic, strong) UITabBar *tabBar;
@property (nonatomic, strong) IMETabbar *imeTabBar;
@property (nonatomic, strong) UIView *addView;

@end

@implementation IMEMainController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self _setupSubviews];
    [self _setupImeTabbar];
}

- (void)addViewControllers:(NSArray<IMEMainTabBarItemModel *> *)viewControllers {
    
    [self _imeAddViewControllers:viewControllers];
}

- (void)_normalAddViewControllers:(NSArray<IMEMainTabBarItemModel *> *)viewControllers {
    NSMutableArray *itemArray = [NSMutableArray array];
       [viewControllers enumerateObjectsUsingBlock:^(IMEMainTabBarItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           UIViewController *controller = [NSClassFromString(obj.controllerName) new];
           [self addChildViewController:controller];
           [self.viewControllers addObject:controller];
           UITabBarItem *item =  [self _setupTabBarItemWithTitle:obj.title imgName:obj.normalImage selectedImgName:obj.selectedImage tag:idx];
           controller.tabBarItem = item;
           [itemArray addObject:item];
       }];
       [self.tabBar setItems:itemArray];
       self.tabBar.selectedItem = itemArray[0];
       [self tabBar:self.tabBar didSelectItem:itemArray[0]];
}

- (void)_imeAddViewControllers:(NSArray<IMEMainTabBarItemModel *> *)viewControllers {
    [viewControllers enumerateObjectsUsingBlock:^(IMEMainTabBarItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *controller = [NSClassFromString(obj.controllerName) new];
        [self addChildViewController:controller];
        [self.viewControllers addObject:controller];
    }];
    [self.imeTabBar addViewControllers:viewControllers];
}

#pragma mark - <UITabBarDelegate>


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger tag = item.tag;
    [self changeVcWithIndex:tag];
}

#pragma mark - <IMETabbarDelegate>

- (void)IMETabbarDidItem:(NSInteger)index {
    [self changeVcWithIndex:index];
}

#pragma mark - private

- (void)changeVcWithIndex:(NSInteger)tag {
    UIView *tmpView = nil;
    UIViewController *controller = self.viewControllers[tag];
    tmpView = controller.view;
    
    if (self.addView == tmpView) {
        return;
    } else {
        [self.addView removeFromSuperview];
        self.addView = nil;
    }
    
    self.addView = tmpView;
    if (self.addView) {
        [self.view addSubview:self.addView];
        [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.imeTabBar.mas_top);
        }];
    }
    [self.view addSubview:self.imeTabBar];
}

- (void)_setupSubviews
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout: UIRectEdgeNone];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tabBar = [[UITabBar alloc] init];
    self.tabBar.delegate = self;
    self.tabBar.translucent = NO;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tabBar];
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-TABBAREXTRAHEIGHT);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(50);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.tabBar addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabBar.mas_top);
        make.left.equalTo(self.tabBar.mas_left);
        make.right.equalTo(self.tabBar.mas_right);
        make.height.equalTo(@1);
    }];
}

//自定义tabbar
- (void)_setupImeTabbar {
    [self.view addSubview:self.imeTabBar];
    self.imeTabBar.delegate = self;
    [self.imeTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-TABBAREXTRAHEIGHT);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(50);
    }];
}

- (UITabBarItem *)_setupTabBarItemWithTitle:(NSString *)aTitle
                                    imgName:(NSString *)aImgName
                            selectedImgName:(NSString *)aSelectedImgName
                                        tag:(NSInteger)aTag
{
    UITabBarItem *retItem = [[UITabBarItem alloc] initWithTitle:aTitle image:[UIImage imageNamed:aImgName] selectedImage:[UIImage imageNamed:aSelectedImgName]];
    retItem.tag = aTag;
    [retItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont systemFontOfSize:14], NSFontAttributeName, [UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [retItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, kColor_Blue, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    return retItem;
}

#pragma mark - lazy

- (NSMutableArray *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}

- (IMETabbar *)imeTabBar {
    if (!_imeTabBar) {
        _imeTabBar = [[IMETabbar alloc]init];
    }
    return _imeTabBar;
}

@end
