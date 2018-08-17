//
//  YYPassAndKeyboard
//
//  Created by 杨永亮 on 2018/8/13.
//  Copyright © 2018年 cstroll. All rights reserved.
//

#import <UIKit/UIKit.h>

#define isAboveiPhone5 ([UIDevice isRunningOveriPhone5])
#define isAboveiPhone6 ([UIDevice isRunningOveriPhone6])
#define isiPhone6   ([UIDevice isRunningAtiPhone6])
#define isAboveiPhone6Plus ([UIDevice isRunningOveriPhone6Plus])
#define isiPhone6Plus ([UIDevice isRunningAtiPhone6Plus])
#define isAboveiPhoneX ([UIDevice isRunningOveriPhoneX])
#define isiPhoneX ([UIDevice isRunningAtiPhoneX])

#define isiPad   ([UIDevice isiPadDevice])
#define isAboveiOS8 ([UIDevice isAboveiOSVersion:8.0f])
#define isAboveiOS9 ([UIDevice isAboveiOSVersion:9.0f])
#define isAboveiOS7 ([UIDevice isAboveiOSVersion:7.0f])
#define isAboveiOS10 ([UIDevice isAboveiOSVersion:10.0f])
enum {
    // 未知设备类型
    UIDeviceType_None           = 0,
    // iPhone 1,3,3GS 标准分辨率(320x480px)
    UIDeviceType_iPhoneStandard = 1 << 0,
    // iPhone 4,4S 高清分辨率(640x960px)
    UIDeviceType_iPhoneRetina   = 1 << 1,
    // iPhone 5 高清分辨率(640x1136px)
    UIDeviceType_iPhone5        = 1 << 2,
    // iPhone 6 高清分辨率(750x1334px)
    UIDeviceType_iPhone6        = 1 << 3,
    // iPhone 6 Plus 高清分辨率(1242x2208px)
    UIDeviceType_iPhone6Plus    = 1 << 4,
    // iPhone X 高清分辨率(1125x2436px)
    UIDeviceType_iPhoneX    = 1 << 5,
    // iPad 1,2 标准分辨率(1024x768px)
    UIDeviceType_iPadStandard   = 1 << 6,
    // iPad 3 High Resolution(2048x1536px)
    UIDeviceType_iPadRetina     = 1 << 7
}; typedef NSUInteger UIDeviceType;

@interface UIDevice (Additions)

/**
 *  获取当前设备类型
 *
 *  @return UIDeviceType
 */
+ (UIDeviceType)currentDeviceType;

/**
 *  当前是否运行在iPhone5以上的设备，包括iPhone5
 *
 *  @return true or false
 */
+ (BOOL)isRunningOveriPhone5;
+ (BOOL)isRunningOveriPhone6;
+ (BOOL)isRunningOveriPhone6Plus;
+ (BOOL)isRunningAtiPhone6Plus;
+ (BOOL)isRunningAtiPhone6;
+ (BOOL)isRunningOveriPhoneX;
+ (BOOL)isRunningAtiPhoneX;

//是否为iPad设备
+ (BOOL)isiPadDevice;
//是否为iPhone设备
+ (BOOL)isiPhoneDevice;
//是否为高清设备
+ (BOOL)isHighResolutionDevice;

//系统版本是否高于给定的version（包含version）
+ (BOOL)isAboveiOSVersion:(float)version;

/**
 *  获取设备的硬件型号
 *
 *  @return (iPhone3,1) or (iPhone4,1) etc
 */
+ (NSString *)platform;

/**
 *  获取设备的Mac地址
 *
 *  @return 设备的Mac地址,不带冒号
 */
+ (NSString *)macAddress;

/**
 *  获取设备的Mac地址
 *
 *  @return 设备的Mac地址,中间以冒号隔开
 */
+ (NSString *)macAddressWithColon;

/**
 判断当前设备是否横屏
 */
- (BOOL)deviceIsHorizontalScreen;

@end
