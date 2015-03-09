//
//  TestClass.m
//  MALUIAlertViewDemo
//
//  Created by wangtian on 15-3-5.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "TestClass.h"
#import <objc/runtime.h>

static id tc = nil;
static NSMutableArray *propertyList = nil;
static BOOL isDone = NO;

@implementation TestClass

- (NSMutableArray *)getPropertyList
{
    if (propertyList == nil) {
        
        propertyList = [[NSMutableArray alloc] init];
        unsigned int propertyCount = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
        
        for (unsigned int i = 0; i < propertyCount; ++i) {
            
            objc_property_t property = properties[i];
            const char * name = property_getName(property);//获取属性名字
            //const char * attributes = property_getAttributes(property);//获取属性类型
            //NSLog(@"%@ : %@",[NSString stringWithUTF8String:name],[NSString stringWithUTF8String:attributes]);
            [propertyList addObject:[NSString stringWithUTF8String:name]];
        }
    }
    return propertyList;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        if (isDone) {
            
            [[self getPropertyList] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
                
                id pValue = [[[self class] unitySet] valueForKey:obj];
                [self setValue:pValue forKey:obj];
            }];
        }
    }
    return self;
}

+ (id)unitySet
{
    if (tc == nil) {
        
        tc = [[self alloc] init];
        isDone = YES;
    }
    return tc;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %d",self.test,self.name,(int)self.age];
}

@end
