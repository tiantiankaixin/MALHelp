//
//  DeviceInfo.m
//  MALHelp
//
//  Created by wangtian on 15/4/13.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "DeviceInfo.h"

@implementation DeviceInfo

#pragma mark - 应用是否为第一次启动
+ (BOOL)isFirstLaunch
{
    NSString *versionKey = (NSString *)kCFBundleVersionKey;
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
    NSString *currentVersion =[[[NSBundle mainBundle] infoDictionary] objectForKey:versionKey];
    if ([lastVersion isEqualToString:currentVersion])
    {
        return NO;
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    return NO;
}

@end
