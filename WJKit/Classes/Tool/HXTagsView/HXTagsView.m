//
//  HXTagsView.m
//  黄轩 https://github.com/huangxuan518
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.
//

#import "HXTagsView.h"
#import "HXTagCollectionViewCell.h"
#import "HXTagAttribute.h"
#import "IMEHeader.h"

@interface HXTagsView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong)NSMutableArray *tagAttArray;

@end

@implementation HXTagsView

static NSString * const reuseIdentifier = @"HXTagCollectionViewCellId";

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    //初始化样式
    _tagAttribute = [HXTagAttribute new];
    
    _layout = [[HXTagCollectionViewFlowLayout alloc] init];
    [self addSubview:self.collectionView];
    self.canCancel = YES;
}

- (void)addSelectTagArray:(NSArray *)array tagArray:(NSArray *)tagArray {
    
}

- (void)setTags:(NSArray *)tags {
    _tags = tags;
 
    self.tagAttArray = [NSMutableArray array];
    
    [tags enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ ",obj]];
        
        UIFont *font = [UIFont systemFontOfSize:_tagAttribute.titleSize];
//        att.fon
        [att addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, att.length)];
//        att.yy_font = font;
        if (_tagAttribute.deleteImage) {
            CGFloat paddingTop = font.lineHeight - font.pointSize;
            
            UIImage *image = _tagAttribute.deleteImage;
            NSTextAttachment *attach = [[NSTextAttachment alloc]init];
            attach.image = image;
            attach.bounds = CGRectMake(0, -paddingTop+2, 10, 10);
            NSAttributedString *imageAtt = [NSAttributedString attributedStringWithAttachment:attach];
            [att appendAttributedString:imageAtt];
        }
        
        [self.tagAttArray addObject:att];
    }];
}

#pragma mark - UICollectionViewDelegate | UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return _tags.count;
    return self.tagAttArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HXTagCollectionViewFlowLayout *layout = (HXTagCollectionViewFlowLayout *)collectionView.collectionViewLayout;
    CGSize maxSize = CGSizeMake(collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
    
    CGRect frame = CGRectZero;
    if (_tagAttribute.deleteImage) {
        NSAttributedString *att = self.tagAttArray[indexPath.item];
        frame = [att boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin context:nil];
    }else {
        frame = [_tags[indexPath.item] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:_tagAttribute.titleSize]} context:nil];
    }
    
    return CGSizeMake(frame.size.width + _tagAttribute.tagSpace, layout.itemSize.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HXTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = _tagAttribute.normalBackgroundColor;
    cell.layer.borderColor = _tagAttribute.borderColor.CGColor;
    cell.layer.cornerRadius = _tagAttribute.cornerRadius;
    cell.layer.borderWidth = _tagAttribute.borderWidth;
    cell.titleLabel.textColor = _tagAttribute.textColor;
    cell.titleLabel.font = [UIFont systemFontOfSize:_tagAttribute.titleSize];
//    cell.titleLabel.highlightedTextColor = _tagAttribute.selectedTextColor;
    NSString *title = self.tags[indexPath.item];
    if (_key.length > 0) {
        cell.titleLabel.attributedText = [self searchTitle:title key:_key keyColor:_tagAttribute.keyColor];
    } else {
//        cell.titleLabel.text = title;
        cell.titleLabel.attributedText = self.tagAttArray[indexPath.item];
    }
        
    if ([self.selectedTags containsObject:self.tags[indexPath.item]]) {
        cell.backgroundColor = _tagAttribute.selectedBackgroundColor;
        if (_tagAttribute.selectedTextColor) {
            cell.titleLabel.textColor = _tagAttribute.selectedTextColor;
            cell.layer.borderColor = [UIColor clearColor].CGColor;
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    HXTagCollectionViewCell *cell = (HXTagCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
     cell.layer.borderColor = _tagAttribute.borderColor.CGColor;
    if ([self.selectedTags containsObject:self.tags[indexPath.item]]) {
        cell.layer.borderColor = [UIColor clearColor].CGColor;
        if (!self.canCancel) {
            return;
        }
        cell.backgroundColor = _tagAttribute.normalBackgroundColor;
        cell.titleLabel.textColor = _tagAttribute.textColor;
        [self.selectedTags removeObject:self.tags[indexPath.item]];
    }
    else {
        if (_isMultiSelect) {
            cell.backgroundColor = _tagAttribute.selectedBackgroundColor;
            if (_tagAttribute.selectedTextColor) {
                cell.titleLabel.textColor = _tagAttribute.selectedTextColor;
                cell.layer.borderColor = [UIColor clearColor].CGColor;
            }
            [self.selectedTags addObject:self.tags[indexPath.item]];
        } else {
            [self.selectedTags removeAllObjects];
            [self.selectedTags addObject:self.tags[indexPath.item]];
            
            [self reloadData];
        }
    }
    
    if (_completion) {
        _completion(self.selectedTags,indexPath.item);
    }
}

// 设置文字中关键字高亮
- (NSMutableAttributedString *)searchTitle:(NSString *)title key:(NSString *)key keyColor:(UIColor *)keyColor {
    
    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:title];
    NSString *copyStr = title;
    
    NSMutableString *xxstr = [NSMutableString new];
    for (int i = 0; i < key.length; i++) {
        [xxstr appendString:@"*"];
    }
    
    while ([copyStr rangeOfString:key options:NSCaseInsensitiveSearch].location != NSNotFound) {
        
        NSRange range = [copyStr rangeOfString:key options:NSCaseInsensitiveSearch];
        
        [titleStr addAttribute:NSForegroundColorAttributeName value:keyColor range:range];
        copyStr = [copyStr stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:xxstr];
    }
    return titleStr;
}

- (void)reloadData {
    [self.collectionView reloadData];
}

- (void)scrollSelectString:(NSString *)string {
    NSInteger index = [self.tags indexOfObject:string];
    if (index!=NSNotFound) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
}

#pragma mark - 懒加载

- (NSMutableArray *)selectedTags
{
    if (!_selectedTags) {
        _selectedTags = [NSMutableArray array];
    }
    return _selectedTags;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[HXTagCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    _collectionView.collectionViewLayout = _layout;
    
    if (_layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        //垂直
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
    } else {
        if (self.hideHorizontalScrollIndicator) {
            _collectionView.showsHorizontalScrollIndicator = NO;
            _collectionView.showsVerticalScrollIndicator = NO;
        }else {
            _collectionView.showsHorizontalScrollIndicator = YES;
            _collectionView.showsVerticalScrollIndicator = NO;
        }
    }
    
    _collectionView.frame = self.bounds;
    
    return _collectionView;
}

- (CGFloat)getTagHeightWithWidth:(CGFloat)width {
   return [HXTagsView getHeightWithTags:self.tags layout:self.layout tagAttribute:self.tagAttribute width:width];
}

+ (CGFloat)getHeightWithTags:(NSArray *)tags layout:(HXTagCollectionViewFlowLayout *)layout tagAttribute:(HXTagAttribute *)tagAttribute width:(CGFloat)width
{
    CGFloat contentHeight;
    
    if (!layout) {
        layout = [[HXTagCollectionViewFlowLayout alloc] init];
    }
    
    if (tagAttribute.titleSize <= 0) {
        tagAttribute = [[HXTagAttribute alloc] init];
    }
    
    //cell的高度 = 顶部 + 高度
    contentHeight = layout.sectionInset.top + layout.itemSize.height;

    CGFloat originX = layout.sectionInset.left;
    CGFloat originY = layout.sectionInset.top;
    
    NSInteger itemCount = tags.count;
    
    for (NSInteger i = 0; i < itemCount; i++) {
        CGSize maxSize = CGSizeMake(width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
        
        CGRect frame = [tags[i] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:tagAttribute.titleSize]} context:nil];
        //tagAttribute
      //临时修改
        CGFloat extWith = 0;
        if (tagAttribute.deleteImage) {
            extWith = 10+5;
        }
        
        CGSize itemSize = CGSizeMake(frame.size.width + tagAttribute.tagSpace+extWith, layout.itemSize.height);
        
        if (layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
            //垂直滚动
            //当前CollectionViewCell的起点 + 当前CollectionViewCell的宽度 + 当前CollectionView距离右侧的间隔 > collectionView的宽度
            if ((originX + itemSize.width + layout.sectionInset.right) > width) {
                originX = layout.sectionInset.left;
                originY += itemSize.height + layout.minimumLineSpacing;
                
                contentHeight += itemSize.height + layout.minimumLineSpacing;
            }
        }
        
        originX += itemSize.width + layout.minimumInteritemSpacing;
    }
    
    contentHeight += layout.sectionInset.bottom;
    return contentHeight;
}

+ (HXTagAttribute *)mouoSearchTag {
    HXTagAttribute *att = [HXTagAttribute new];
    att.borderColor = [UIColor clearColor];
    att.cornerRadius = 14;
    att.tagSpace = 34;
    att.titleSize = 14;
    att.textColor = [UIColor colorWithHexString:@"#ffffff"];
    att.selectedTextColor = [UIColor whiteColor];
    att.normalBackgroundColor = [UIColor colorWithHexString:@"#A4BAE4"];
    att.selectedBackgroundColor = [UIColor colorWithHexString:@"#A4BAE4"];
    return att;
}

+ (HXTagAttribute *)mouoSearchTag2{
    HXTagAttribute *att = [HXTagAttribute new];
    att.borderColor = [UIColor clearColor];
    att.cornerRadius = 10;
    att.tagSpace = 20;
    att.titleSize = 12;
    att.textColor = [UIColor colorWithHexString:@"#ffffff"];
    att.selectedTextColor = [UIColor whiteColor];
    att.normalBackgroundColor = [UIColor colorWithHexString:@"#A4BAE4"];
    att.selectedBackgroundColor = [UIColor colorWithHexString:@"#A4BAE4"];
    return att;
}
+ (HXTagAttribute *)mouoVideoResultTag {
   
        HXTagAttribute *att = [HXTagAttribute new];
        att.borderColor = [UIColor clearColor];
        att.cornerRadius = 14;
        att.tagSpace = 20;
        att.titleSize = 13;
        att.textColor = [UIColor colorWithHexString:@"#FD5594"];
        att.selectedTextColor = [UIColor whiteColor];
        att.normalBackgroundColor = [UIColor colorWithHexString:@"#FFEDF4"];
        att.selectedBackgroundColor = [UIColor colorWithHexString:@"#FD5594"];
        return att;
  
}

+ (NSAttributedString *)changeWithString:(NSString *)str {
    NSMutableAttributedString *fontAttributeNameStr = [[NSMutableAttributedString alloc]initWithString:str];
           // 2.添加属性
           [fontAttributeNameStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium] range:NSMakeRange(0, str.length)];
    NSRange range = [str rangeOfString:@"分钟"];
    if (range.location != NSNotFound) {
         
        [fontAttributeNameStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium] range:range];
        return fontAttributeNameStr;
    }else {
        return fontAttributeNameStr;
    }
    
}

+ (NSAttributedString *)changeshareColorWithString:(NSString *)str {
    
    NSMutableAttributedString *att1 = [[NSMutableAttributedString alloc]initWithString:@"累计获得"];
    [att1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#9B9B9B"] range:NSMakeRange(0, att1.length)];
    NSMutableAttributedString *att2 = [[NSMutableAttributedString alloc]initWithString:@"元奖励"];
    [att2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#9B9B9B"] range:NSMakeRange(0, att2.length)];
    
    
    //
    NSMutableAttributedString *fontAttributeNameStr = [[NSMutableAttributedString alloc]initWithString:str];
             // 2.添加属性
    [fontAttributeNameStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] range:NSMakeRange(0, str.length)];
    
    [fontAttributeNameStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FD5594"] range:NSMakeRange(0, fontAttributeNameStr.length)];
    
    [att1 appendAttributedString:fontAttributeNameStr];
    [att1 appendAttributedString:att2];
    return att1;
}

@end
