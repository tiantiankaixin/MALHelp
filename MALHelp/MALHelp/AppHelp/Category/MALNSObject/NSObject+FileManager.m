//
//  NSObject+FileManager.m
//  MALHelp
//
//  Created by wangtian on 15/5/20.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "NSObject+FileManager.h"

@implementation NSObject (FileManager)

#pragma mark - 获得本地文件字节数
+ (NSUInteger)getLocalFileSizeWithPath:(NSString *)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath])
    {
        return (NSUInteger)[[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

@end
