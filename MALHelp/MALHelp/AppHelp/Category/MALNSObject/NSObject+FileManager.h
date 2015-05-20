//
//  NSObject+FileManager.h
//  MALHelp
//
//  Created by wangtian on 15/5/20.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FileManager)

/**
 *  获得本地文件字节数
 *
 *  @param filePath 本地文件路径
 *
 *  @return 文件大小 若文件路径不存在返回0
 */
+ (NSUInteger)getLocalFileSizeWithPath:(NSString *)filePath;

@end
