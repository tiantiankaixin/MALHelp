//
//  NSString+MALNSString.h
//  MALHelp
//
//  Created by wangtian on 15-3-5.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SafeString(str) [NSString getSafeStr:str]

typedef struct{
    
    int m_hour;
    int m_minutes;
    int m_second;
    
}MALTime;

@interface NSString (MALNSString)

/**
 *是否是一个有效的手机号码
 */
- (BOOL)isMobilePhoneNumber;

/**
 *是否是一个有效的邮箱
 */
- (BOOL)isEmail;

/**
 *清楚字符串空格
 */
- (NSString *)clearBlank;

/**
 *字符串是否含有除了空格外的字符
 */
- (BOOL)isEmpty;

/**
 *获得一个字符串的16位md5串
 */
+ (NSString*)getmd5WithString:(NSString *)string;

/**
 *文件md5
 */
+ (NSString*)getFileMD5WithPath:(NSString*)path;

/**
 *NSData md5
 */
+ (NSString*)getMD5WithData:(NSData *)data;

/**
 *把秒转换为时分秒
 */
- (MALTime)getMALTime;

/**
 *  把秒转换为 HH:mm:ss 格式
 *
 *@param seconds 总秒数量
 *
 *@return HH:mm:ss 格式的字符串
 */
+ (NSString *)timeFromSecond:(unsigned int)seconds;

/**
 *  把HH:mm:ss格式的时间转换为秒
 *
 *  @param timeStr HH:mm:ss 格式的时间
 *
 *  @return 总秒数
 */
+ (NSInteger)secondFromTimeString:(NSString *)timeStr;


/**
 *  判断输入的字符串是否全是英文
 *
 *  @param str 输入字符串
 *
 *  @return      YES: 是     NO：否
 */
+ (BOOL)isEnString:(NSString *)str;

/**
 *  判断输入的是否全是中文
 *
 *  @param str 输入字符串
 *
 *  @return     YES：是   NO：否
 */
+ (BOOL)isChineseString:(NSString *)str;

/**
 *  判断输入的是否全是数字
 *
 *  @param str 输入字符串
 *
 *  @return     YES：是   NO：否
 */
+ (BOOL)isNumString:(NSString *)str;

/**
 *  判断是不是数字 可以是浮点型
 *
 *  @return YES：是
 */
- (BOOL)isNumber;

/**
 *  gbk转码
 *
 *  @return utf-8 转 gbk
 */
- (NSString *)gbkStr;

/**
 *  3.5 = 4  3.3 = 3
 *
 *  @return 四舍五入
 */
- (NSString *)getIntStr;

/**
 *  得到安全的字符串
 *
 *  @param ob id 类型
 *
 *  @return   如果是NSValue类型转为NSString  如果是nil或者NSNull返回@""   否则返回本身
 */
+ (NSString *)getSafeStr:(id)ob;

/**
 *  得到安全的object
 *
 *  @param obj <#obj description#>
 *
 *  @return <#return value description#>
 */
+ (id)safeObject:(id)obj;

@end
