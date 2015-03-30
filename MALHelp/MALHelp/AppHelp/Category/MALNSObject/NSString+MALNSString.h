//
//  NSString+MALNSString.h
//  MALHelp
//
//  Created by wangtian on 15-3-5.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 *字符串md5
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
@end
