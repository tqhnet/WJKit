//
//  NSDictionary+WJAdditions.m
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/12.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import "NSDictionary+WJAdditions.h"
#import "NSString+WJAdditions.h"

@implementation NSDictionary (WJAdditions)

//#pragma mark - Querying

- (BOOL)hasObjectEqualTo:(id)object
{
    return ( [[self allValues] indexOfObject:object] != NSNotFound );
}

- (BOOL)hasObjectIdenticalTo:(id)object
{
    return ( [[self allValues] indexOfObjectIdenticalTo:object] != NSNotFound );
}

- (BOOL)hasKeyEqualTo:(id)key
{
    return ( [[self allKeys] indexOfObject:key] != NSNotFound );
}

- (BOOL)hasKeyIdenticalTo:(id)key
{
    return ( [[self allKeys] indexOfObjectIdenticalTo:key] != NSNotFound );
}



#pragma mark - URL

- (NSString *)queryString
{
    NSMutableArray *pairs = [[NSMutableArray alloc] init];
    
    for ( NSString *key in [self keyEnumerator] ) {
        NSString *value = [[NSString stringWithFormat:@"%@", [self objectForKey:key]] URLEncodedString];
        NSString *pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }
    
    if ( [pairs count] > 0 ) {
        return [pairs componentsJoinedByString:@"&"];
    }
    
    return nil;
}

- (id)objectOrNilForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    else
    {
        return object;
    }
}


@end

@implementation NSMutableDictionary (WJAdditions)


#pragma mark - Adding and removing entries

- (void)setObject:(id)object forKeyIfNotNil:(id)key
{
    if ( object && key ) {
        [self setObject:object forKey:key];
    }
}

- (void)removeObjectForKeyIfNotNil:(id)key
{
    if ( key ) {
        [self removeObjectForKey:key];
    }
}

@end