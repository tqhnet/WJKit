//
//  NSArray+WJAdditions.m
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/12.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import "NSArray+WJAdditions.h"
#import "NSObject+WJAdditions.h"
@implementation NSArray (WJAdditions)

#pragma mark - Querying

- (id)objectOrNilAtIndex:(NSUInteger)idx
{
    if ( idx < [self count] ) {
        return [self objectAtIndex:idx];
    }
    return nil;
}

- (id)firstObject
{
    return [self objectOrNilAtIndex:0];
}

- (id)randomObject
{
    if ( [self count] > 0 ) {
        NSUInteger idx = arc4random() % [self count];
        return [self objectAtIndex:idx];
    }
    return nil;
}


- (BOOL)hasObjectEqualTo:(id)object
{
    return ( [self indexOfObject:object] != NSNotFound );
}

- (BOOL)hasObjectIdenticalTo:(id)object
{
    return ( [self indexOfObjectIdenticalTo:object] != NSNotFound );
}



#pragma mark - Key-Value Coding

- (NSArray *)objectsForKeyPath:(NSString *)keyPath equalToValue:(id)value
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for ( int i=0; i<[self count]; ++i ) {
        id object = [self objectAtIndex:i];
        if ( [object isValueForKeyPath:keyPath equalToValue:value] ) {
            [array addObject:object];
        }
    }
    
    if ( [array count] > 0 ) {
        return array;
    }
    
    return nil;
}

- (NSArray *)objectsForKeyPath:(NSString *)keyPath identicalToValue:(id)value
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for ( int i=0; i<[self count]; ++i ) {
        id object = [self objectAtIndex:i];
        if ( [object isValueForKeyPath:keyPath identicalToValue:value] ) {
            [array addObject:object];
        }
    }
    
    if ( [array count] > 0 ) {
        return array;
    }
    
    return nil;
}


- (id)firstObjectForKeyPath:(NSString *)keyPath equalToValue:(id)value
{
    for ( int i=0; i<[self count]; ++i ) {
        id object = [self objectAtIndex:i];
        if ( [object isValueForKeyPath:keyPath equalToValue:value] ) {
            return object;
        }
    }
    return nil;
}

- (id)firstObjectForKeyPath:(NSString *)keyPath identicalToValue:(id)value
{
    for ( int i=0; i<[self count]; ++i ) {
        id object = [self objectAtIndex:i];
        if ( [object isValueForKeyPath:keyPath identicalToValue:value] ) {
            return object;
        }
    }
    return nil;
}


@end

@implementation NSMutableArray (TapKit)


#pragma mark - Adding and removing entries

- (id)addObjectIfNotNil:(id)object
{
    if ( object ) {
        [self addObject:object];
        return object;
    }
    return nil;
}

- (id)addUnequalObjectIfNotNil:(id)object
{
    if ( ![self hasObjectEqualTo:object] ) {
        return [self addObjectIfNotNil:object];
    }
    return nil;
}

- (id)addUnidenticalObjectIfNotNil:(id)object
{
    if ( ![self hasObjectIdenticalTo:object] ) {
        return [self addObjectIfNotNil:object];
    }
    return nil;
}


- (id)insertObject:(id)object atIndexIfNotNil:(NSUInteger)idx
{
    if ( object ) {
        if ( idx <= [self count] ) {
            [self insertObject:object atIndex:idx];
            return object;
        }
    }
    return nil;
}


- (id)moveObjectAtIndex:(NSUInteger)idx toIndex:(NSUInteger)toIdx
{
    if ((idx != toIdx)
        && (idx < [self count])
        && (toIdx < [self count]))
    {
        id object = [self objectAtIndex:idx];
        [self removeObjectAtIndex:idx];
        [self insertObject:object atIndex:toIdx];
        return object;
    }
    return nil;
}


- (void)removeFirstObject
{
    if ( [self count] > 0 ) {
        [self removeObjectAtIndex:0];
    }
}



#pragma mark - Ordering and filtering

// http://en.wikipedia.org/wiki/Knuth_shuffle
- (void)shuffle
{
    for ( NSUInteger i=[self count]; i>1; --i ) {
        
        NSUInteger m = 1;
        do {
            m <<= 1;
        } while ( m < i );
        
        NSUInteger j = 0;
        do {
            j = arc4random() % m;
        } while ( j >= i );
        
        [self exchangeObjectAtIndex:(i-1) withObjectAtIndex:j];
    }
}

- (void)reverse
{
    int semi = floor( [self count]/2.0 );
    for ( int i=0; i<semi; ++i ) {
        NSUInteger idx = [self count] - (i+1);
        [self exchangeObjectAtIndex:i withObjectAtIndex:idx];
    }
}

- (void)unequal
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self];
    
    [self removeAllObjects];
    
    for ( int i=0; i<[array count]; ++i ) {
        id object = [array objectAtIndex:i];
        [self addUnequalObjectIfNotNil:object];
    }
}

- (void)unidentical
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self];
    
    [self removeAllObjects];
    
    for ( int i=0; i<[array count]; ++i ) {
        id object = [array objectAtIndex:i];
        [self addUnidenticalObjectIfNotNil:object];
    }
}



#pragma mark - Stack

- (id)push:(id)object
{
    return [self addObjectIfNotNil:object];
}

- (id)pop
{
    id object = [self lastObject];
    [self removeLastObject];
    return object;
}



#pragma mark - Queue

- (id)enqueue:(id)object
{
    return [self addObjectIfNotNil:object];
}

- (id)dequeue
{
    id object = [self firstObject];
    [self removeFirstObject];
    return object;
}

@end


