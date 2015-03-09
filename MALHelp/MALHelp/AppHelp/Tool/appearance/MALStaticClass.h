//
//  MALStaticClass.h
//  MALUIAlertViewDemo
//
//  Created by wangtian on 15-3-5.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#ifndef MALUIAlertViewDemo_MALStaticClass_h
#define MALUIAlertViewDemo_MALStaticClass_h

#import <objc/runtime.h>

#define MALHFundation + (id)unitySet; // 写到头文件里

// .m实现上边
#define MStaticDefine   \
static id tc = nil; \
static NSMutableArray *propertyList = nil; \
static BOOL isDone = NO;


//.m 实现
#define MImplementation  \
- (NSMutableArray *)getPropertyList \
{  \
if (propertyList == nil) { \
\
propertyList = [[NSMutableArray alloc] init]; \
unsigned int propertyCount = 0; \
objc_property_t *properties = class_copyPropertyList([self class], &propertyCount); \
\
for (unsigned int i = 0; i < propertyCount; ++i) { \
\
objc_property_t property = properties[i]; \
const char * name = property_getName(property); \
[propertyList addObject:[NSString stringWithUTF8String:name]]; \
} \
} \
return propertyList; \
}\
- (instancetype)init{ \
if (self = [super init]) {\
\
if (isDone) { \
\
[[self getPropertyList] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {\
\
id pValue = [[[self class] unitySet] valueForKey:obj];\
[self setValue:pValue forKey:obj];\
}];\
}\
}\
return self;\
}\
+ (id)unitySet\
{\
if (tc == nil) {\
\
tc = [[self alloc] init];\
isDone = YES; \
} \
return tc; \
}


#endif
