//
//  YYPassAndKeyboard
//
//  Created by 杨永亮 on 2018/8/13.
//  Copyright © 2018年 cstroll. All rights reserved.
//

#import "UIDevice+Additions.h"

#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation UIDevice (Additions)


+ (UIDeviceType)currentDeviceType {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //iPad
        if ([self isHighResolutionDevice]) {
            return UIDeviceType_iPadRetina;
        }
        return UIDeviceType_iPadStandard;
    }
    else {
        //iPhone
        if ([self isHighResolutionDevice]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
            if (result.height == 960.0f) {
                return UIDeviceType_iPhoneRetina;
            } else if (result.height == 1136.0f) {
                return UIDeviceType_iPhone5;
            } else if (result.height == 1334.0f) {
                return UIDeviceType_iPhone6;
            } else if (result.height == 2208.0f) {
                return UIDeviceType_iPhone6Plus;
            }if (result.height == 2436.0f) {
                return UIDeviceType_iPhoneX;
            }
        }
        
        return UIDeviceType_iPhoneStandard;
    }
    
}

+ (BOOL)isRunningOveriPhone5 {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [self currentDeviceType] >= UIDeviceType_iPhone5;
    }
    return NO;
}

+ (BOOL)isRunningOveriPhone6 {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [self currentDeviceType] >= UIDeviceType_iPhone6;
    }
    return NO;
}

+ (BOOL)isRunningOveriPhone6Plus {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [self currentDeviceType] >= UIDeviceType_iPhone6Plus;
    }
    return NO;
}

+ (BOOL)isRunningAtiPhone6Plus {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [self currentDeviceType] == UIDeviceType_iPhone6Plus;
    }
    return NO;
}

+ (BOOL)isRunningAtiPhone6 {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [self currentDeviceType] == UIDeviceType_iPhone6;
    }
    return NO;
}

+ (BOOL)isRunningOveriPhoneX {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [self currentDeviceType] >= UIDeviceType_iPhoneX;
    }
    return NO;
}

+ (BOOL)isRunningAtiPhoneX {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [self currentDeviceType] == UIDeviceType_iPhoneX;
    }
    return NO;
}

+ (BOOL)isiPadDevice {
    return UIUserInterfaceIdiomPad == [UIDevice currentDevice].userInterfaceIdiom;
}

+ (BOOL)isiPhoneDevice {
    return UIUserInterfaceIdiomPhone == [UIDevice currentDevice].userInterfaceIdiom;
}

+ (BOOL)isHighResolutionDevice {
    return ([UIScreen mainScreen].scale + 0.01) > 2.0;
}

+ (BOOL)isAboveiOSVersion:(float)version
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= version;
}

+ (NSString *)platform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString *)macAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return @"";
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return @"";
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return @"";
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return @"";
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];
    free(buf);
    return [outstring uppercaseString];
}

+ (NSString *)macAddressWithColon {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return @"";
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return @"";
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return @"";
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return @"";
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];
    free(buf);
    return [outstring uppercaseString];
}

/**
 判断当前设备是否横屏
 */
- (BOOL)deviceIsHorizontalScreen{
    // 判断当前设备方向
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        return YES;
    }
    return NO;
}
@end
