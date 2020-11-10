//
//  NSString+WJAdditions.h
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/12.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <uiki>
@interface NSString (WJAdditions)

///-------------------------------
/// UUID
///-------------------------------

+ (NSString *)UUIDString;

+ (NSString *)replaceUnicode:(NSString *)unicodeStr;

///-------------------------------
/// Validity
///-------------------------------

/**
 * 字母、数字、中文正则判断（不包括空格）
 */
- (BOOL)isInputRuleNotBlank;
/**
 * 字母、数字、中文正则判断（包括空格）
 */
- (BOOL)isInputRuleAndBlank;

- (BOOL)isDecimalNumber;

- (BOOL)isWhitespaceAndNewline;


- (BOOL)isInCharacterSet:(NSCharacterSet *)characterSet;


///-------------------------------
/// Hash
///-------------------------------

- (NSString *)md5;

- (NSString *)MD5HashString;

- (NSString *)SHA1HashString;


///-------------------------------
/// URL
///-------------------------------

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

- (NSDictionary *)queryDictionary;
- (NSString *)stringByAddingQueryDictionary:(NSDictionary *)dictionary;
- (NSString *)stringByAppendingValue:(NSString *)value forKey:(NSString *)key;


///-------------------------------
/// MIME types
///-------------------------------

- (NSString *)MIMEType;

- (BOOL)isEmailAddress;
- (BOOL)isLetters;
- (BOOL)isNumbers;
- (BOOL)isNumberOrLetters;
+ (BOOL)CheckPhonenumberInput:(NSString *)_text;

#pragma mark - more



/**
 判断该字符串是不是一个有效的URL
 
 @return YES：是一个有效的URL or NO
 */
- (BOOL)isValidUrl;

/** 根据图片名 判断是否是gif图 */
- (BOOL)isGifImage;

/** 根据图片data 判断是否是gif图 */
+ (BOOL)isGifWithImageData: (NSData *)data;

/**
 根据image的data 判断图片类型
 
 @param data 图片data
 @return 图片类型(png、jpg...)
 */
+ (NSString *)contentTypeWithImageData: (NSData *)data;


@end
