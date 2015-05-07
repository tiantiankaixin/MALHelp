//
//  BlurViewController.m
//  MALHelp
//
//  Created by wangtian on 15/5/7.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//  模糊效果

#import "BlurViewController.h"
#import "UIView+MALFunction.h"
#import <GPUImage.h>

@interface BlurViewController ()
{
    NSString *test;
}

@property (weak, nonatomic) IBOutlet GPUImageView *gpuImageView;
@property (nonatomic, strong) GPUImageiOSBlurFilter *filter;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation BlurViewController

#pragma mark - getter
- (GPUImageiOSBlurFilter *)filter
{
    if (_filter == nil)
    {
        _filter = [[GPUImageiOSBlurFilter alloc] init];
        _filter.blurRadiusInPixels = 1.0f;
    }
    return  _filter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidLayoutSubviews
{
    [self setUpFilter];
}

- (void)setUpView
{
    self.title = @"模糊效果";
}

- (void)setUpFilter
{
    self.gpuImageView.clipsToBounds = YES;
    //而contentsGravity确保图片出现在image view的顶部
    self.gpuImageView.layer.contentsGravity = kCAGravityTop;
    
    UIImage *image = [self.bgImageView imageFromView];
    
    GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:image];
    [picture addTarget:self.filter];
    [self.filter addTarget:self.gpuImageView];
    [picture processImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
