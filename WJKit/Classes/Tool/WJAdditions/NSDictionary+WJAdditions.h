//
//  NSDictionary+WJAdditions.h
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/12.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (WJAdditions)

- (NSString *)queryString;

- (BOOL)hasObjectEqualTo:(id)object;
- (BOOL)hasObjectIdenticalTo:(id)object;
- (BOOL)hasKeyEqualTo:(id)key;
- (BOOL)hasKeyIdenticalTo:(id)key;


///-------------------------------
/// URL
///-------------------------------

- (id)objectOrNilForKey:(NSString *)key;

@end

@interface NSMutableDictionary (WJAdditions)

///-------------------------------
/// Adding and removing entries
///-------------------------------

- (void)setObject:(id)object forKeyIfNotNil:(id)key;

- (void)removeObjectForKeyIfNotNil:(id)key;

@end

