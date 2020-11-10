//
//  NSDate+WJAdditions.h
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/12.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WJAdditions)

- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;

//月-日 时:分
+ (NSString *)stringForDateWithMDHM:(NSTimeInterval)time;
//12月23日
+ (NSString *)stringForDateWithMD:(NSTimeInterval)time;

//在线时间
+ (NSString *)stringForChatOnlineTime:(NSInteger)onlineTime;

+ (NSTimeInterval)timerWithDateString:(NSString *)dateString;

@end
