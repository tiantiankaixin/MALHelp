//
//  ProgressViewController.m
//  MALHelp
//
//  Created by wangtian on 15-3-13.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "ProgressViewController.h"
#import "MALProgressView.h"
#import "TestPopViewController.h"

@interface ProgressViewController ()

@property (nonatomic, strong) MALProgressView *malProgress;
@property (nonatomic, strong) TestPopViewController *testPop;

- (IBAction)changeProgress:(UIButton *)sender;

@end

@implementation ProgressViewController

- (MALProgressView *)malProgress
{
    if (_malProgress == nil) {
        
        _malProgress = [MALProgressView malProgressViewWithRect:CGRectMake(20, 100, 200, 3)];
        _malProgress.m_progress = 0.5;
    }
    return _malProgress;
}

- (TestPopViewController *)testPop
{
    if (_testPop == nil)
    {
        _testPop = [[TestPopViewController alloc] init];
    }
    return _testPop;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configue];
}

- (void)configue
{
    [self setCenterItemWithTitle:@"自定义进度条"];
    [self.view addSubview:self.malProgress];
    [self setProgressViewWithImage];
    //[self setProgressViewWithColor];
    [self.testPop setTestPopBlock:^(NSString *str) {
        
        Log(@"%@",str);
    }];
}

#pragma mark - 使用图片设置背景
- (void)setProgressViewWithImage
{
    [self.malProgress setBgImage:[UIImage imageNamed:@"ProgressEmpty"] topImage:[UIImage imageNamed:@"ProgressFull"]];
}

#pragma mark - 使用颜色设置背景
- (void)setProgressViewWithColor
{
    [self.malProgress setBgColor:[UIColor blackColor] topColor:[UIColor redColor]];
}

#pragma mark - 改变进度
- (IBAction)changeProgress:(UIButton *)sender
{
    CGFloat nowProgress;
    if(sender.tag == 1){
        
        _malProgress.m_progress += 0.1;
    }
    else{
        
        _malProgress.m_progress -= 0.1;
    }
    nowProgress = _malProgress.m_progress;
    Log(@"====%.2f",nowProgress);
}

#pragma mark - pop test
- (IBAction)showPopView:(UIButton *)sender
{
    [self.testPop showOrHiddenView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
