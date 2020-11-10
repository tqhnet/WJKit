
#import <UIKit/UIKit.h>

@interface UIView (WJExtension)
//x坐标
@property (nonatomic, assign) CGFloat x;
//y坐标
@property (nonatomic, assign) CGFloat y;
//maxx坐标
@property (nonatomic, assign) CGFloat maxX;
//maxy坐标
@property (nonatomic, assign) CGFloat maxY;
//中心点x坐标
@property (nonatomic, assign) CGFloat centerX;
//中心点y坐标
@property (nonatomic, assign) CGFloat centerY;
//宽度
@property (nonatomic, assign) CGFloat width;
//高度
@property (nonatomic, assign) CGFloat height;
//size
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat top;

@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat bottom;
@end
