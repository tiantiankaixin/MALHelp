//
//  TestPopViewController.h
//  MALHelp
//
//  Created by wangtian on 15/7/27.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "PopFromBottom.h"

@interface TestPopViewController : PopFromBottom

@property (nonatomic, copy) void(^testPopBlock)(NSString *testStr);


@end
