//
//  NSString+MALNSString.m
//  MALHelp
//
//  Created by wangtian on 15-3-5.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "NSString+MALNSString.h"
#import <CommonCrypto/CommonDigest.h>
#define FileHashDefaultChunkSizeForReadingData 1024 * 8

@implementation NSString (MALNSString)

#pragma mark - 是否是一个有效的手机号码
- (BOOL)isMobilePhoneNumber
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma mark - 是否是一个有效的邮箱
- (BOOL)isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

#pragma mark - 清除字符串中得空格
- (NSString *)clearBlank
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (BOOL)isEmpty
{
    NSString *str = [self clearBlank];
    if (str.length == 0) {
        
        return YES;
    }
    return NO;
}

#pragma mark - 获得一个字符串的16位md5串
+ (NSString*)getmd5WithString:(NSString *)string
{
    const char* original_str=[string UTF8String];
    
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    
    CC_MD5(original_str, (CC_LONG)strlen(original_str), digist);
    
    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        
        [outPutStr appendFormat:@"%02x", digist[i]];// 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5
        
    }
    return [outPutStr lowercaseString];
}

#pragma mark - 获得本地文件的md5值
+(NSString*)getFileMD5WithPath:(NSString*)path
{
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)path, FileHashDefaultChunkSizeForReadingData);
}

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,size_t chunkSizeForReadingData){
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) goto done;
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
    }
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,(UInt8 *)buffer,(CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault,(const char *)hash,kCFStringEncodingUTF8);
    
done:
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}

#pragma mark - 获取NSData的16位的md5字符串
+ (NSString*)getMD5WithData:(NSData *)data
{
    
    const char* original_str = (const char *)[data bytes];
    
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    
    CC_MD5(original_str, (CC_LONG)strlen(original_str), digist);
    
    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        
        [outPutStr appendFormat:@"%02x",digist[i]];// 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5
        
    }
    // 也可以定义一个字节数组来接收计算得到的 MD5 值
    
    //    Byte byte[16];
    
    //    CC_MD5(original_str, strlen(original_str), byte);
    
    //    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    
    //    for(int  i = 0; i<CC_MD5_DIGEST_LENGTH;i++){
    
    //        [outPutStr appendFormat:@"%02x",byte[i]];
    
    //    }
    
    //    [temp release];
    
    
    
    return [outPutStr lowercaseString];
}

#pragma mark - 把秒转换为时分秒
- (MALTime)getMALTime
{
    MALTime malTime;
    
    int seconds = self.intValue;
    if (seconds < 60) {
        
        malTime.m_hour = 0;
        malTime.m_minutes = 0;
        malTime.m_second = seconds;
    }
    else{
        
        malTime.m_second = seconds % 60;
        int minute = seconds / 60;
        int hour = 0;
        if (minute >= 60) {
            
            int tempMinute = minute;
            minute = minute % 60;
            hour = tempMinute / 60;
        }
        malTime.m_hour = hour;
        malTime.m_minutes = minute;
    }
    return malTime;
}

#pragma mark - 把秒转换为  HH:mm:ss 格式字符串
+ (NSString *)timeFromSecond:(unsigned int)seconds
{
    unsigned int time = seconds;
    unsigned int hour = time / 3600;
    unsigned int min = (time % 3600) / 60;
    unsigned int sec = time % 60;
    NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, min, sec];
    return timeStr;
}

#pragma mark - HH:mm:ss 格式字符串  转换为秒
+ (NSInteger)secondFromTimeString:(NSString *)timeStr
{
    NSInteger second;
    
    NSArray *timeArray = [timeStr componentsSeparatedByString:@":"];
    
    NSInteger hours = [timeArray[0] intValue];
    NSInteger minutes = [timeArray[1] intValue];
    NSInteger seconds = [timeArray[2] intValue];
    
    second = hours * 3600 + minutes * 60 + seconds;
    
    return second;
}

#pragma mark - 判断输入的字符串是否全是英文
+ (BOOL)isEnString:(NSString *)str
{
    NSString *regex = @"^[a-zA-Z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:str];
}

#pragma mark - 判断输入的是否全是中文
+ (BOOL)isChineseString:(NSString *)str
{
    NSString *regex = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:str];
}

#pragma mark - 判断输入的是否全是数字
+ (BOOL)isNumString:(NSString *)str
{
    NSString *regex = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:str];
}

#pragma mark - 判断是否是数字可以是浮点型
- (BOOL)isNumber
{
    NSString *tempStr = [self stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (![NSString isNumString:tempStr])
    {
        return NO;
    }
    NSInteger oldLength = self.length;
    NSInteger newLength = tempStr.length;
    if (oldLength - newLength > 1)
    {
        return NO;
    }
    
    if ([self hasPrefix:@"."])
    {
        return NO;
    }
    
    if ([self hasSuffix:@"."])
    {
        return NO;
    }
    
    return YES;
}

-(BOOL)judgeStringIfisAnTypeOfNumber
{
    NSString *theRegex = @"^[0-9]+(.[0-9])?$";//{1,5}一到5位小数
    NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",theRegex];
    BOOL isNumber = NO;
    isNumber = [thePredicate evaluateWithObject:self];
    
    if (isNumber)
    {
        if (self.length >= 2)
        {
            NSInteger theFirstChar = [[self substringWithRange:NSMakeRange(0,1)] integerValue];
            
            if (theFirstChar==0 && [self rangeOfString:@"."].location == NSNotFound)
            {
                isNumber = NO;
            }
            
        }
    }
    return isNumber;
}

#pragma mark - gbk编码
- (NSString *)gbkStr
{
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [[NSString alloc] initWithData:data encoding:gbkEncoding];
}

#pragma mark - 四舍五入字符串
- (NSString *)getIntStr
{
    NSString *result;
    NSArray *strArray = [self componentsSeparatedByString:@"."];
    int tou;
    if(strArray.count == 1)
    {
        return [strArray firstObject];
    }
    if (strArray.count != 2)
    {
        return nil;
    }
    else
    {
        tou = [strArray[0] intValue];
        int wei = [strArray[1] intValue];
        if (wei >= 5)
        {
            tou++;
        }
    }
    result = [NSString stringWithFormat:@"%d",tou];
    return result;
}

#pragma mark - 得到安全的字符串
+ (NSString *)getSafeStr:(id)ob
{
    if(ob == nil || [ob isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    if ([ob isKindOfClass:[NSValue class]])
    {
        ob = [NSString stringWithFormat:@"%@",ob];
    }
    return ob;
}

+ (id)safeObject:(id)obj
{
    if ([obj isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    return obj;
}

@end
