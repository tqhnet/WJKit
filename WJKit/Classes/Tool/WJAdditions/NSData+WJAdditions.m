//
//  NSData+WJAdditions.m
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/12.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import "NSData+WJAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (WJAdditions)
- (NSString *)MD5HashString
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([self bytes], (int)[self length], result);
    
    NSString *fmt = @"%02x%02x%02x%02x%02x%02x%02x%02x"
    @"%02x%02x%02x%02x%02x%02x%02x%02x";
    
    return [[NSString alloc] initWithFormat:fmt,
            result[ 0], result[ 1], result[ 2], result[ 3],
            result[ 4], result[ 5], result[ 6], result[ 7],
            result[ 8], result[ 9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

- (NSString *)SHA1HashString
{
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1([self bytes], (int)[self length], result);
    
    NSString *fmt = @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
    @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x";
    
    return [[NSString alloc] initWithFormat:fmt,
            result[ 0], result[ 1], result[ 2], result[ 3],
            result[ 4], result[ 5], result[ 6], result[ 7],
            result[ 8], result[ 9], result[10], result[11],
            result[12], result[13], result[14], result[15],
            result[16], result[17], result[18], result[19]];
}


@end
