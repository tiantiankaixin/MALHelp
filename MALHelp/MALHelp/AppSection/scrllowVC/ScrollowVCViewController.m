//
//  ScrollowVCViewController.m
//  MALHelp
//
//  Created by wangtian on 15/5/11.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "ScrollowVCViewController.h"
#import "ControllerScrollView.h"
#import "ScrollowVCItemViewController.h"
#import "MALSegmentControl.h"

@interface ScrollowVCViewController ()<ControllerScrollViewDelegate>
{
    MALSegmentControl *_segControl;
    NSArray *_segTitleArray;
}

@property (weak, nonatomic) IBOutlet ControllerScrollView *controllerScrollView;


@end

@implementation ScrollowVCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpSegView];
    [self setUpControllerView];
}

- (void)setUpSegView
{
    NSArray *titleArray = @[@"推荐",@"卫视",@"央视", @"地方",@"卫星",@"东方时空"];
    _segTitleArray = titleArray;
    CGRect segFrame = self.segView.bounds;
    segFrame.size.width = IOS_SCREEN.size.width;
    segFrame.size.height = IOS_SCREEN.size.width * (1 / 8.0);
    _segControl = [MALSegmentControl getControlWithTitlesArray:titleArray andFrame:segFrame selectIndex:2 andControlType:downSideLineControl buttonWidth:SCREEN_WIDTH / 4];
    [self.segView addSubview:_segControl];
    [_segControl setSegNormalLineColor:[UIColor blueColor] selectColor:[UIColor orangeColor]];
    [_segControl setSegNormalTextColorWithRgba:M_RGBAFrom(29, 55, 45, 1.0) selectTextColorRgba:M_RGBAFrom(224, 6, 1, 1.0) textFont:17];
    __weak ScrollowVCViewController *selfPoint = self;
    [_segControl setControlHandel:^(NSInteger index) {
        
        [selfPoint.controllerScrollView scrollToViewControllerWithIndex:index];
    }];
}

- (void)setUpControllerView
{
    NSMutableArray *childVCArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _segTitleArray.count; i++)
    {
        ScrollowVCItemViewController *si = [[ScrollowVCItemViewController alloc] init];
        [self addChildViewController:si];
        si.vcTitle = MALStringFormat(@"%@",_segTitleArray[i]);
        [childVCArray addObject:si];
    }
    self.controllerScrollView.csDelegate = self;
    [self.controllerScrollView setUpControllerScrollViewWithSubVC:childVCArray andCurrentIndex:2];
}

- (void)viewScrollWithRadio:(CGFloat)ratio
{
    [_segControl updateViewFrameWithRatio:ratio];
}

- (void)dealloc
{
    Log(@"ScrollowVCViewController 被释放了");
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
