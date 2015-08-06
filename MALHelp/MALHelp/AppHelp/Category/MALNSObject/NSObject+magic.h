//
//  NSObject+magic.h
//  MALHelp
//
//  Created by wangtian on 15/5/25.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//  黑魔法

#import <Foundation/Foundation.h>

@interface NSObject (magic)

/**
 *  延时执行handleBlock里的代码(一直等待直到收到sendSignal发送的信号不会阻塞主线程)，如果超时执行timeOutBlock里的代码。
 *
 *  @param time         超时时间
 *  @param timeOutBlock 超时执行block
 *  @param handleBlock  收到信号时执行block
 */
+ (void)waitUntilReciveSignalWithTimeout:(NSInteger)time timeOutBlock:(void(^)())timeOutBlock handleBlock:(void(^)())handleBlock;

/**
 *  发送信号
 */
+ (void)sendSignal;

/**
 *  开始计时
 */
+ (void)beginCountTime;

/**
 *  停止计时
 *
 *  @return 从beginCountTime执行开始到endConutTime执行完毕所经过时间
 */
+ (double)endConutTime;

/**
 *  在debug模式下执行block
 *
 *  @param block 被执行block
 */
+ (void)handleOnDebugMode:(void(^)(void))block;

@end
