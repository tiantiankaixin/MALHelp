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
#pragma mark iOS Frame
//获取当前screen
#define mainSize    [UIScreen mainScreen].bounds.size
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
#define userDefaults [NSUserDefaults standardUserDefaults]


//++++++++ 系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS_VERSION_EQUAL_TO(v)                 [[[UIDevice currentDevice] systemVersion] floatValue]==v
#define IOS_VERSION_GREATER_THAN(v)              [[[UIDevice currentDevice] systemVersion] floatValue]>v
#define IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  [[[UIDevice currentDevice] systemVersion] floatValue]>=v
#define IOS_VERSION_LESS_THAN(v)                 [[[UIDevice currentDevice] systemVersion] floatValue]<v
#define IOS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     [[[UIDevice currentDevice] systemVersion] floatValue]<=v

//++++++++ storyBoard
#define StoryBoardWithName(name)  [UIStoryboard storyboardWithName:name bundle:nil]
#define ControllerWithSBAndIdentifier(sb,identifier)  [sb instantiateViewControllerWithIdentifier:identifier]
#define MALNibWithName(name)   [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil]
#define MALUINibWithName(name)  [UINib nibWithNibName:name bundle:nil];

//++++++++ 沙盒文件路径



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

//++++++NSString
#define MALStringFormat(fmt,...)  [NSString stringWithFormat:fmt,## __VA_ARGS__]

//弱指针
#define WeakSelf(ws) __weak __typeof(&*self) ws = self
//-----------------object




//----------------function
#pragma mark -
#pragma mark function
/**
 *  判断id是为空
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

//log输出
#ifndef __OPTIMIZE__
#define Log(FORMAT,...)  fprintf(stderr,"file：%s\nline：%d\nfunc：%s\noutput：%s\n\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__,__func__ ,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define Log(...)  {}
#endif


#ifndef __OPTIMIZE__
#define YNLog(...) NSLog(__VA_ARGS__)
#else
#define YNLog(...){}
#endif

//设置导航栏返回标题
#define SetBackItemTitle(title)  [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil]]
#define SetBackItem  SetBackItemTitle(@"")

//----------------function





//----------------thread
#pragma mark -
#pragma mark - thread
/**
 *  在主线程执行代码
 *
 *  @param block 你要执行的代码块
 *
 */
#define HandleOnMainThread(block) dispatch_async(dispatch_get_main_queue(),block);

/**
 *  gcd调度时间 dispatch_time
 */
#define MGCDTime(time) dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC)

/**
 *  dispatch_after   延时执行代码
 */
#define MGCDAfter(delayTime,block)  dispatch_after(MGCDTime(delayTime), dispatch_get_main_queue(),block)

//----------------thread





//----------------UIView
#pragma mark -
#pragma mark - UIView

//弹出框
#define AlertViewWithTitleAndMsg(title,msg)  [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show]
#define AlertViewWithTitle(title)   AlertViewWithTitleAndMsg(title,nil)

//按钮
#define BtnTitleForState(btn,state)  (NSString *)[btn titleForState:state]
#define BtnTitleForNormal(btn)        BtnTitleForState(btn,UIControlStateNormal)

//----------------UIView

#endif
