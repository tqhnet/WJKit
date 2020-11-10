//
//  IMEConfigureHeader.h
//  IMDemo
//
//  Created by tqh on 2019/7/5.
//  Copyright © 2019 tqh. All rights reserved.
//

#ifndef IMEConfigureHeader_h
#define IMEConfigureHeader_h

#define WidthRatio CGRectGetWidth([UIScreen mainScreen].bounds)/375
#define HeightRatio CGRectGetHeight([UIScreen mainScreen].bounds)/667
#define iOS11 ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)
#define iOS10 ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define iOS9GREATER ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9LESSTHAN ([UIDevice currentDevice].systemVersion.floatValue < 9.0f)
//屏幕大小
#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#define SCREEN_SCALE SCREEN_WIDTH/SCREEN_HEIGHT
#define ISIPHONEX ((SCREEN_HEIGHT == 812.0f || SCREEN_HEIGHT == 869.0f) ? YES : NO)

#define NAVHEIGHT ((ISIPHONEX == YES) ? 88.0f : 64.0f)
#define TABBARHEIGHT ((ISIPHONEX == YES) ? 83.0f : 49.0f)
#define HeightNavContentBar 44.0f
#define HeightStatusBar ((ISIPHONEX==YES)?44.0f: 20.0f)
#define TABBAREXTRAHEIGHT ((ISIPHONEX==YES)?34.0f: 0.0f)
#define STATUSBAREXTRAHEIGHT ((ISIPHONEX==YES)?24.0f: 0.0f)

#endif /* IMEConfigureHeader_h */
