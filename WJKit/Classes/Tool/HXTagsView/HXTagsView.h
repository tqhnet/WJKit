//
//  HXTagsView.h
//  黄轩 https://github.com/huangxuan518
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTagCollectionViewFlowLayout.h"
#import "HXTagAttribute.h"

@class HXTagAttribute;

@interface HXTagsView : UIView

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *tags;//传入的标签数组 字符串数组
@property (nonatomic,strong) HXTagCollectionViewFlowLayout *layout;//布局layout
@property (nonatomic,strong) HXTagAttribute *tagAttribute;//按钮样式对象
@property (nonatomic,assign) BOOL isMultiSelect;//是否可以多选 默认:NO 单选
@property (nonatomic,copy) NSString *key;//搜索关键词
@property (nonatomic,strong) NSMutableArray *selectedTags;//选中的数组
@property (nonatomic,assign) BOOL canCancel;//是否能取消
@property (nonatomic,assign) BOOL hideHorizontalScrollIndicator;//隐藏横向滚动指示器

@property (nonatomic,copy) void (^completion)(NSArray *selectTags,NSInteger currentIndex);//选中的标签数组,当前点击的index

- (void)addSelectTagArray:(NSArray *)array tagArray:(NSArray *)tagArray;

//刷新界面
- (void)reloadData;
- (void)scrollSelectString:(NSString *)string;
/**
 *  计算Cell的高度
 *
 *  @param tags         标签数组
 *  @param layout       布局样式 默认则传nil
 *  @param tagAttribute 标签样式 默认传nil 涉及到计算的主要是titleSize
 *  @param width        计算的最大范围
 */
+ (CGFloat)getHeightWithTags:(NSArray *)tags layout:(HXTagCollectionViewFlowLayout *)layout tagAttribute:(HXTagAttribute *)tagAttribute width:(CGFloat)width;

- (CGFloat)getTagHeightWithWidth:(CGFloat)width;


//+ (HXTagAttribute *)mouoSearchTag;//搜索标签
//+ (HXTagAttribute *)mouoSearchTag2;//搜索标签二级页面
//+ (HXTagAttribute *)mouoVideoResultTag;//视频结束时
//
////陌友的属性扩展
//+ (HXTagAttribute *)mouoChatGameTagAttributeIsSender:(BOOL)isSender;//游戏达人
//+ (HXTagAttribute *)mouoChatCellGameTag;//游戏达人
//+ (HXTagAttribute *)mouoUserCard;//用户标签
//+ (HXTagAttribute *)mouoFateTag;//缘分页面
//+ (HXTagAttribute *)mouoFatePublishTag;
//+ (HXTagAttribute *)mouoPublishTag;//发布选择标签
//+ (HXTagAttribute *)mouoPublishSelectTag;
//
//+ (HXTagAttribute *)mouoPublishTagNew;//
//+ (HXTagAttribute *)mouoFateSquare;     //缘分广场标签
//
//
//+ (NSAttributedString *)changeWithString:(NSString *)str;
//+ (NSAttributedString *)changeFontWithString:(NSString *)str;
////分享赚钱模块
//+ (NSAttributedString *)changeshareColorWithString:(NSString *)str;

@end
