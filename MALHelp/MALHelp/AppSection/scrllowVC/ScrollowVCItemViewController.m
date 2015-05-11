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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
