//
//  NSObject+SystemInfo.m
//  MALHelp
//
//  Created by wangtian on 15/5/11.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "NSObject+SystemInfo.h"
#import <math.h>

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

#pragma mark - 通过UIColor获得r、g、b、a 的值
M_RGBA RGBAFromUIColor(UIColor *color)
{
    return RGBAFromCGColor(color.CGColor);
}

M_RGBA RGBAFromCGColor(CGColorRef color)
{
    M_RGBA rgba;
    
    CGColorSpaceRef color_space = CGColorGetColorSpace(color);
    CGColorSpaceModel color_space_model = CGColorSpaceGetModel(color_space);
    const CGFloat *color_components = CGColorGetComponents(color);
    size_t color_component_count = CGColorGetNumberOfComponents(color);
    
    switch (color_space_model)
    {
        case kCGColorSpaceModelMonochrome:
        {
            assert(color_component_count == 2);
            rgba = (M_RGBA)
            {
                .m_r = color_components[0],
                .m_g = color_components[0],
                .m_b = color_components[0],
                .m_a = color_components[1]
            };
            break;
        }
            
        case kCGColorSpaceModelRGB:
        {
            assert(color_component_count == 4);
            rgba = (M_RGBA)
            {
                .m_r = color_components[0],
                .m_g = color_components[1],
                .m_b = color_components[2],
                .m_a = color_components[3]
            };
            break;
        }
            
        default:
        {
            rgba = (M_RGBA) { 0, 0, 0, 0 };
            break;
        }
    }
    
    return rgba;
}

+ (NSInteger)getNumberWithIndex:(NSInteger)index andJinzhi:(NSInteger)jinzhi number:(NSInteger)number
{
    NSInteger result;
    result = number % (NSInteger)pow(jinzhi, index);
    result = result / (NSInteger)pow(jinzhi, index - 1);
    return result;
}

@end
