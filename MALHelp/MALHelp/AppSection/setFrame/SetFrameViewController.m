//
//  SetFrameViewController.m
//  MALHelp
//
//  Created by wangtian on 15/5/7.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "SetFrameViewController.h"
#import "UIView+MALFrame.h"

@interface SetFrameViewController ()

@end

@implementation SetFrameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidLayoutSubviews
{
    [self.testView setViewX:200];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
