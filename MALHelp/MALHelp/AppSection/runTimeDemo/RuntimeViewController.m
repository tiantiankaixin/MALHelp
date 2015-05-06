//
//  RuntimeViewController.m
//  MALHelp
//
//  Created by wangtian on 15-3-6.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "RuntimeViewController.h"
#import "TestClassTwo.h"
@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"RuntimeViewController";
    [self testAppearance];
    // Do any additional setup after loading the view from its nib.
}

- (void)testAppearance
{
    [[TestClassTwo unitySet] setTestwo:@"这是个测试"];
    TestClassTwo *t1 = [TestClassTwo new];
    TestClassTwo *t2 = [TestClassTwo new];
    t2.testwo = @"123";
    Log(@"%@ %@",t1.testwo,t2.testwo);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
