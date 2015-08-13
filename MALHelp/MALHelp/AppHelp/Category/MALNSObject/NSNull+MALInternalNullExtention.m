//
//  NSNull+MALInternalNullExtention.m
//  MALHelp
//
//  Created by wangtian on 15/8/13.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//
//http://blog.rpplusplus.me/blog/2014/03/28/nsnull-category/   虾神博客
//代码陈航写的

#define NSNullObjects @[@"",@0,@{},@[]]

#import "NSNull+MALInternalNullExtention.h"
#import <objc/runtime.h>

@implementation NSNull (MALInternalNullExtention)

//- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
//{
//    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
//    if (!signature)
//    {
//        for (NSObject *object in NSNullObjects)
//        {
//            signature = [object methodSignatureForSelector:selector];
//            if (signature) {
//                break;
//            }
//        }
//    }
//    return signature;
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    SEL aSelector = [anInvocation selector];
//    for (NSObject *object in NSNullObjects)
//    {
//        if ([object respondsToSelector:aSelector])
//        {
//            [anInvocation invokeWithTarget:object];
//            return;
//        }
//    }
//    [self doesNotRecognizeSelector:aSelector];
//}

//将消息转出某对象
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (!self.isCloseExceptionHandle)
    {
        NSLog(@"MyTestObject _cmd: %@", NSStringFromSelector(_cmd));
        Log(@"%@",NSStringFromSelector(aSelector));
        for(id obj in NSNullObjects)
        {
            if ([obj respondsToSelector:aSelector])
            {
                Log(@"%@",NSStringFromClass([obj class]));
                return obj;
            }
        }
    }
    return [super forwardingTargetForSelector: aSelector];
}

- (BOOL)isCloseExceptionHandle
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsCloseExceptionHandle:(BOOL)isCloseExceptionHandle
{
    objc_setAssociatedObject(self, @selector(isCloseExceptionHandle), [NSNumber numberWithBool:isCloseExceptionHandle], OBJC_ASSOCIATION_ASSIGN);
}

@end
