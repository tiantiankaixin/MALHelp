//
//  NSObject+magic.m
//  MALHelp
//
//  Created by wangtian on 15/5/25.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "NSObject+magic.h"

static dispatch_semaphore_t sem = nil;

@implementation NSObject (magic)

#pragma mark - 延时执行handleBlock里的代码(当收到信号时执行sendSignal)，如果超时执行timeOutBlock里的代码
+ (void)waitUntilReciveSignalWithTimeout:(NSInteger)time timeOutBlock:(void (^)())timeOutBlock handleBlock:(void (^)())handleBlock
{
    sem = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (dispatch_semaphore_wait(sem, dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC)))//如果超时了执行
        {
            if (timeOutBlock)
            {
                timeOutBlock();
                sem = nil;
            }
        }
       else
       {
           if (handleBlock)
           {
               sem = nil;
               handleBlock();
           }
       }
    });
}

//发送信号
+ (void)sendSignal
{
    if (sem)
    {
        dispatch_semaphore_signal(sem);
    }
}



@end
