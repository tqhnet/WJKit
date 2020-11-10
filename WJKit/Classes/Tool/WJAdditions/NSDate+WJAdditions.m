//
//  NSDate+WJAdditions.m
//  moyouAPP
//
//  Created by 幻想无极（谭启宏） on 16/8/12.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import "NSDate+WJAdditions.h"
#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@implementation NSDate (WJAdditions)

- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
    return [self dateByAddingDays: (dDays * -1)];
}

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSString *)stringForDateWithMD:(NSTimeInterval)time {
    if(time > 140000000000) {
        time = time / 1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日"];
    NSString *dateTime = [formatter stringFromDate:date];
    
    return dateTime;
}
+ (NSString *)stringForDateWithMDHM:(NSTimeInterval)time {
    if(time > 140000000000) {
        time = time / 1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *dateTime = [formatter stringFromDate:date];
        
    return dateTime;
}

+ (NSString *)stringForChatOnlineTime:(NSInteger)onlineTime {
    
    NSTimeInterval dis = [NSDate date].timeIntervalSince1970  - onlineTime/1000;
    
    if (onlineTime <= 0) {
        return NSLocalizedString(@"当前在线", nil);
    }
    
    onlineTime = dis;
    if (onlineTime <= 0) {
        return NSLocalizedString(@"刚刚", nil);
    }
    else if (onlineTime > 0 && onlineTime < 60) {
        return [NSString stringWithFormat:@"%ld%@", (long)onlineTime, NSLocalizedString(@"秒前", nil)];
    }else if (onlineTime >= 60 && onlineTime < 60 * 60) {
        return [NSString stringWithFormat:@"%ld%@", onlineTime/60, NSLocalizedString(@"分钟前", nil)];
    } else if (onlineTime >= 60 * 60 && onlineTime < 60 * 60*24) {
        return [NSString stringWithFormat:@"%ld%@", onlineTime/60/60, NSLocalizedString(@"小时前", nil)];
    } else if (onlineTime >= 60 * 60 * 24 && onlineTime <60 * 60 * 24 * 30){
        return [NSString stringWithFormat:@"%ld%@", onlineTime/60/60/24, NSLocalizedString(@"天前", nil)];
    } else if (onlineTime >=60 * 60 * 24 * 30 && onlineTime <60 * 60 * 24 * 30 * 12){
        return [NSString stringWithFormat:@"%ld%@", onlineTime/60/60/24/30, NSLocalizedString(@"月前", nil)];
    } else {
        return NSLocalizedString(@"1年前", nil);
    }
}

+ (NSTimeInterval)timerWithDateString:(NSString *)dateString {
    NSString *birthdayStr = dateString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    NSDate *birthdayDate = [dateFormatter dateFromString:birthdayStr];
    return birthdayDate.timeIntervalSince1970;
}

@end
