//
//  NSData+WJAdditions.h
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/12.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <zip>
@interface NSData (WJAdditions)

//加密

- (NSString *)MD5HashString;
- (NSString *)SHA1HashString;


@end
