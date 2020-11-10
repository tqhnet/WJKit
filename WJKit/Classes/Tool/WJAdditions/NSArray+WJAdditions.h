//
//  NSArray+WJAdditions.h
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/12.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (WJAdditions)

///-------------------------------
/// Querying
///-------------------------------

- (id)objectOrNilAtIndex:(NSUInteger)idx;

- (id)firstObject;

- (id)randomObject;


- (BOOL)hasObjectEqualTo:(id)object;

- (BOOL)hasObjectIdenticalTo:(id)object;


///-------------------------------
/// Key-Value Coding
///-------------------------------

- (NSArray *)objectsForKeyPath:(NSString *)keyPath equalToValue:(id)value;

- (NSArray *)objectsForKeyPath:(NSString *)keyPath identicalToValue:(id)value;


- (id)firstObjectForKeyPath:(NSString *)keyPath equalToValue:(id)value;

- (id)firstObjectForKeyPath:(NSString *)keyPath identicalToValue:(id)value;


@end


@interface NSMutableArray (TapKit)

///-------------------------------
/// Adding and removing entries
///-------------------------------

- (id)addObjectIfNotNil:(id)object;

- (id)addUnequalObjectIfNotNil:(id)object;

- (id)addUnidenticalObjectIfNotNil:(id)object;


- (id)insertObject:(id)object atIndexIfNotNil:(NSUInteger)idx;


- (id)moveObjectAtIndex:(NSUInteger)idx toIndex:(NSUInteger)toIdx;


- (void)removeFirstObject;


///-------------------------------
/// Ordering and filtering
///-------------------------------

- (void)shuffle;

- (void)reverse;

- (void)unequal;

- (void)unidentical;


///-------------------------------
/// Stack
///-------------------------------

- (id)push:(id)object;

- (id)pop;


///-------------------------------
/// Queue
///-------------------------------

- (id)enqueue:(id)object;

- (id)dequeue;

@end

