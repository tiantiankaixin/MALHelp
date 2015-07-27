//
//  PopFromBottom.m
//  MALHelp
//
//  Created by wangtian on 15/7/27.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "PopFromBottom.h"
#import "UIView+MALFrame.h"

@interface PopFromBottom ()

@end

@implementation PopFromBottom

- (UIView *)bgView
{
    if (_bgView == nil)
    {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.0f;
    }
    return _bgView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 设置视图
- (void)setUpView
{
    [self.view setViewY:SCREEN_HEIGHT];
    [self.view setViewSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)showOrHiddenView
{
    BOOL isShow = YES;
    CGFloat selfY = Y(self.view);
    CGFloat changeY = 0;
    CGFloat alpla = 0.6;
    if (selfY == 0)
    {
        changeY = SCREEN_HEIGHT;
        alpla = 0.0f;
        isShow = NO;
    }
    if (![self.bgView isDescendantOfView:KEYWINDOW])
    {
        [KEYWINDOW addSubview:self.bgView];
    }
    
    if (![self.view isDescendantOfView:KEYWINDOW])
    {
        [KEYWINDOW addSubview:self.view];
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.view setViewY:changeY];
        self.bgView.alpha = alpla;
    } completion:^(BOOL finished) {
        
        if (finished)
        {
            if (self.popBlock)
            {
                self.popBlock(isShow);
            }
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
