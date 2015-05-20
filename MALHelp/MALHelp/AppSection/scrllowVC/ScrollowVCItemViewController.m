//
//  ScrollowVCItemViewController.m
//  MALHelp
//
//  Created by wangtian on 15/5/11.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "ScrollowVCItemViewController.h"

@interface ScrollowVCItemViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation ScrollowVCItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    Log(@"%@ 加载了",self.vcTitle);
    self.titleLabel.text = self.vcTitle;
    // Do any additional setup after loading the view from its nib.
}

//PS:vc  的view经过addSubView被加到别的视图中时 viewDidLoad viewWillAppear viewDidAppear均会被调用就相当与已经显示了   当vc的view从superView移除后 调用viewWillDisappear
//- (void)viewWillAppear:(BOOL)animated
//{
//    Log(@"%@  viewWillAppear",self.vcTitle);
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    Log(@"%@  viewDidAppear",self.vcTitle);
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    Log(@"%@  viewWillDisappear",self.vcTitle);
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
