//
//  NSObject+SystemInfo.h
//  MALHelp
//
//  Created by wangtian on 15/5/11.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct{
    
    CGFloat m_r;
    CGFloat m_g;
    CGFloat m_b;
    CGFloat m_a;
    
}M_RGBA;

#define M_RGBAFrom(r,g,b,a) [NSObject mrgbaWithR:r G:g B:b A:a]

@interface NSObject (SystemInfo)

/**
 *  判断应用是否第一次启动
 *
 *  @return YES 是   NO:否
 */
+ (BOOL)isFirstLaunch;

/**
 *  初始化一个M_RGBA 值
 */
+ (M_RGBA)mrgbaWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;

/**
 *  获得当前活动的VC
 *
 */
+ (UIViewController *)getCurrentVC;

/**
 *  获取UIColor对象的RGBA值
 *
 *  @param color UIColor
 *
 *  @return M_RGBA
 */
M_RGBA RGBAFromUIColor(UIColor *color);

@end
