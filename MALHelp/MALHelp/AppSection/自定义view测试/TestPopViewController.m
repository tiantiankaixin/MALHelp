//
//  TestPopViewController.m
//  MALHelp
//
//  Created by wangtian on 15/7/27.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "TestPopViewController.h"

@interface TestPopViewController ()

@end

@implementation TestPopViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configue];
    // Do any additional setup after loading the view from its nib.
}

- (void)configue
{
    WeakSelf(ws);
    self.popBlock = ^(BOOL isSHow){
    
        if (ws.testPopBlock)
        {
            if (isSHow)
            {
                ws.testPopBlock(@"view显示了");
            }
            else
            {
                ws.testPopBlock(@"view隐藏了");
            }
        }
    };
}

- (IBAction)hidden:(UIButton *)sender
{
    [self showOrHiddenView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
