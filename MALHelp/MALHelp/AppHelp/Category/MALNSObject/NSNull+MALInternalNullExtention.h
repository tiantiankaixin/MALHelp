//
//  NSNull+MALInternalNullExtention.h
//  MALHelp
//
//  Created by wangtian on 15/8/13.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (MALInternalNullExtention)

/**
 *  是否关闭异常处理  YES关闭   默认为NO 
 */
@property (nonatomic,assign) BOOL isCloseExceptionHandle;

@end
