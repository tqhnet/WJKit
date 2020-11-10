//
//  NSObject+WJAdditions.m
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/12.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import "NSObject+WJAdditions.h"
#import <objc/runtime.h>

@implementation NSObject (WJAdditions)

#pragma mark - Class string

+ (NSString *)classString
{
    return NSStringFromClass([self class]);
}

- (NSString *)classString
{
    return NSStringFromClass([self class]);
}



#pragma mark - Associate object

- (void)associateValue:(id)value withKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)weaklyAssociateValue:(id)value withKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)associatedValueForKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}



#pragma mark - Key-Value Coding

- (BOOL)isValueForKeyPath:(NSString *)keyPath equalToValue:(id)value
{
    if ( [keyPath length] > 0 ) {
        id objectValue = [self valueForKeyPath:keyPath];
        return ([objectValue isEqual:value]
                || ((objectValue==nil) && (value==nil))
                );
    }
    return NO;
}

- (BOOL)isValueForKeyPath:(NSString *)keyPath identicalToValue:(id)value
{
    if ( [keyPath length] > 0 ) {
        return ( [self valueForKeyPath:keyPath] == value );
    }
    return NO;
}

+ (NSDictionary *)propertyAttributes
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(self, &count);
    
    for ( int i=0; i<count; ++i ) {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        NSString *attribute = [NSString stringWithUTF8String:property_getAttributes(property)];
        [dictionary setObject:attribute forKey:name];
    }
    free(properties);
    
    if ( [dictionary count] > 0 ) {
        return dictionary;
    }
    
    return nil;
}

@end
