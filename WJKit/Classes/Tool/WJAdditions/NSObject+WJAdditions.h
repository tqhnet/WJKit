//
//  NSObject+WJAdditions.h
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/12.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WJAdditions)


/**
 * 类名
 */

+ (NSString *)classString;
- (NSString *)classString;

/**
 ＊ 获取这个类的所有属性
 */

+ (NSDictionary *)propertyAttributes;


///-------------------------------
/// Associate object
///-------------------------------

- (void)associateValue:(id)value withKey:(void *)key;

- (void)weaklyAssociateValue:(id)value withKey:(void *)key;

- (id)associatedValueForKey:(void *)key;


///-------------------------------
/// Key-Value coding
///-------------------------------

- (BOOL)isValueForKeyPath:(NSString *)keyPath equalToValue:(id)value;

- (BOOL)isValueForKeyPath:(NSString *)keyPath identicalToValue:(id)value;

@end
