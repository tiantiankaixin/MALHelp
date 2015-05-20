//
//  NSObject+SystemInfo.m
//  MALHelp
//
//  Created by wangtian on 15/5/11.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "NSObject+SystemInfo.h"

@implementation NSObject (SystemInfo)

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

#pragma mark - 通过UIColor获得r、g、b、a 的值
+ (M_RGBA)rgbaWithColor:(UIColor *)color
{
    M_RGBA mrgba;
    CGColorRef cgColor = [color CGColor];
    unsigned long numComponents = CGColorGetNumberOfComponents(cgColor);
    if (numComponents >= 3)
    {
        const CGFloat *tmComponents = CGColorGetComponents(cgColor);
        mrgba.m_r = tmComponents[0] * 255;
        mrgba.m_g = tmComponents[1] * 255;
        mrgba.m_b = tmComponents[2] * 255;
        mrgba.m_a = tmComponents[3];
    }
    return mrgba;
}

#pragma mark - 初始化一个M_RGBA
+ (M_RGBA)mrgbaWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a
{
    M_RGBA rgba;
    rgba.m_r = r;
    rgba.m_g = g;
    rgba.m_b = b;
    rgba.m_a = a;
    return rgba;
}

#pragma mark - 获得当前活动的VC
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
