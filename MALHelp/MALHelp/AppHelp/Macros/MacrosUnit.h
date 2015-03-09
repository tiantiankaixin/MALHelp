//
//  MacrosUnit.h
//  MALHelp
//
//  Created by wangtian on 15-3-5.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#ifndef MALHelp_MacrosUnit_h
#define MALHelp_MacrosUnit_h

//------------------View
#pragma mark -
#pragma mark iOS UI
//获取当前screen
#define IOS_SCREEN  [ UIScreen mainScreen ].bounds

// 屏幕高度
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height

// 屏幕宽度
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width
#define SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]
#define STATUSBAR_HEIGHT      [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVBAR_HEIGHT         (44.f + ((SYSTEM_VERSION >= 7) ? STATUSBAR_HEIGHT : 0))
#define FULL_WIDTH            SCREEN_WIDTH
#define FULL_HEIGHT           (SCREEN_HEIGHT - ((SYSTEM_VERSION >= 7) ? 0 : STATUSBAR_HEIGHT))
#define CONTENT_HEIGHT        (FULL_HEIGHT - NAVBAR_HEIGHT)

#define WIDTH(view) view.frame.size.width
#define HEIGHT(view) view.frame.size.height
#define X(view) view.frame.origin.x
#define Y(view) view.frame.origin.y
#define LEFT(view) view.frame.origin.x
#define TOP(view) view.frame.origin.y
#define BOTTOM(view) (view.frame.origin.y + view.frame.size.height)
#define RIGHT(view) (view.frame.origin.x + view.frame.size.width)

//------------------View



//-----------------系统信息
#pragma mark -
#pragma mark iOS info

//++++++++ app常用变量
#define APPDELEGATE  [[UIApplication sharedApplication]delegate] //appdelegate
#define KEYWINDOW    [UIApplication sharedApplication].keyWindow // keywindow
#define AppInfoDic   [[NSBundle mainBundle] infoDictionary] //应用信息字典
#define AppVersion   [AppInfoDic objectForKey:@"CFBundleVersion"] //应用版本号
#define AppName      [AppInfoDic objectForKey:@"CFBundleDisplayName"] //应用名称


//++++++++ 系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS_VERSION_EQUAL_TO(v)                 [[[UIDevice currentDevice] systemVersion] floatValue]==v
#define IOS_VERSION_GREATER_THAN(v)              [[[UIDevice currentDevice] systemVersion] floatValue]>v
#define IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  [[[UIDevice currentDevice] systemVersion] floatValue]>=v
#define IOS_VERSION_LESS_THAN(v)                 [[[UIDevice currentDevice] systemVersion] floatValue]<v
#define IOS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     [[[UIDevice currentDevice] systemVersion] floatValue]<=v



//-----------------系统信息





//-----------------颜色
#pragma mark -
#pragma mark UIColor
#define UIColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#define UIColorFromHex(hexValue)            UIColorFromHexWithAlpha(hexValue,1.0)
#define RGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b)                RGBA(r,g,b,1.0)
//-----------------颜色


//-----------------object
#pragma mark -
#pragma mark object

//++++++++NSValue
#define POINTERIZE(x) ((__typeof__(x) []){ x })
#define NSVALUE(x) [NSValue valueWithBytes: POINTERIZE(x) objCType: @encode(__typeof__(x))]

//++++++++NSNumber
#define NUM_INT(int) [NSNumber numberWithInt:int]
#define NUM_FLOAT(float) [NSNumber numberWithFloat:float]
#define NUM_BOOL(bool) [NSNumber numberWithBool:bool]


//-----------------object




//----------------function
#pragma mark -
#pragma mark function
/**
 *  判断id是为空
 *
 *  @param thing <#thing description#>
 *
 *  @return <#return value description#>
 */
static inline BOOL IsEmpty(id thing) {
    return thing == nil || [thing isEqual:[NSNull null]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

static inline NSString *StringFromObject(id object) {
    if (object == nil || [object isEqual:[NSNull null]]) {
        return @"";
    } else if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else if ([object respondsToSelector:@selector(stringValue)]){
        return [object stringValue];
    } else {
        return [object description];
    }
}

//----------------function
#endif
