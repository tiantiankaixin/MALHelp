//
//  UCTopBarViewController.m
//  MALHelp
//
//  Created by wangtian on 15/11/17.
//  Copyright © 2015年 wangtian. All rights reserved.
//

#import "UCTopBarViewController.h"
#import "ControllerScrollView.h"
#import "ScrollowVCItemViewController.h"
#import "UCBar.h"
#import "UIView+MALFrame.h"

@interface UCTopBarViewController ()<ControllerScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (weak, nonatomic) IBOutlet ControllerScrollView *controllerScrollView;
@property (nonatomic, strong) UCBar *ucBar;
@property (weak, nonatomic) IBOutlet UIView *topBar;

@end

@implementation UCTopBarViewController

- (NSMutableArray *)titleArray
{
    if (_titleArray == nil)
    {
        _titleArray = [NSMutableArray arrayWithArray: @[@"推荐",@"卫视",@"央视", @"地方",@"卫星",@"东方1",@"地方",@"卫星",@"东方2"]];
    }
    return _titleArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
}

#pragma mark - 设置视图
- (void)setUpView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setCenterItemWithTitle:@"滚动视图"];
    [self setUpUCView];
    [self setUpControllerView];
}

- (void)setUpUCView
{
    [self.view layoutSubviews];//FIXME: 为毛没用(取出来的view的frame不对)
    self.ucBar = [UCBar barWithTitleArray:self.titleArray btnWidth:60 frame:CGRectMake(0, 0, SCREEN_WIDTH, 50) defaultSelectIndex:0];
    [self.ucBar setViewWidth:SCREEN_WIDTH];
    WeakSelf(ws);
    [self.ucBar setSelectIndexBlock:^(NSInteger selectIndex) {
        
        [ws.controllerScrollView scrollToViewControllerWithIndex:selectIndex];
    }];
    [self.topBar addSubview:self.ucBar];
}

- (void)setUpControllerView
{
    NSMutableArray *childVCArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.titleArray.count; i++)
    {
        ScrollowVCItemViewController *si = [[ScrollowVCItemViewController alloc] init];
        [self addChildViewController:si];
        si.vcTitle = MALStringFormat(@"%@",self.titleArray[i]);
        [childVCArray addObject:si];
    }
    self.controllerScrollView.csDelegate = self;
    [self.controllerScrollView setUpControllerScrollViewWithSubVC:childVCArray andCurrentIndex:0 isPrestrain:YES];
}

- (void)viewScrollWithRadio:(CGFloat)ratio
{
    [self.ucBar updateViewFrameWithRatio:ratio];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
