//
//  ControllerScrollView.m
//  SegDemo
//
//  Created by wangtian on 15-1-19.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "ControllerScrollView.h"
#import "UIView+MALFrame.h"

@interface ControllerScrollView()

@property (nonatomic, assign) BOOL isScrollow;//YES:代表是滑动cScrollView  NO:点击的分段控制控件

@end

@implementation ControllerScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpScrollView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setUpScrollView];
    }
    return self;
}

- (void)layoutSubviews
{
    [self setUpViewFrame];
    for (NSInteger i = 0; i < self.subVCArray.count; i++) {
        
        BOOL state = [[self.subViewStateArray objectAtIndex:i] boolValue];
        if (state) {
            
            UIView *subView = [[self.subVCArray objectAtIndex:i] view];
            [subView setViewX:i * WIDTH(self) Y:0 Width:WIDTH(self) Height:HEIGHT(self)];
        }
    }
    self.cScrollView.contentSize = CGSizeMake(WIDTH(self) * self.pageNumber, 0);
    self.cScrollView.contentOffset = CGPointMake(WIDTH(self) * self.currentPage, 0);
}


//+ (ControllerScrollView *)controllerScrollViewWithFrame:(CGRect)frame subViews:(NSMutableArray *)subViews
//{
//    ControllerScrollView *csView = [[ControllerScrollView alloc] initWithFrame:frame];
//    [csView configueDataWithSubViews:subViews];
//    [csView setUpView];
//    return csView;
//}

- (void)setUpViewFrame
{
    self.cScrollView.frame = self.bounds;
}

- (void)setUpScrollView
{
    self.isScrollow = YES;
    self.cScrollView = [[UIScrollView alloc] init];
    self.cScrollView.showsHorizontalScrollIndicator = NO;
    self.cScrollView.showsVerticalScrollIndicator = NO;
    self.cScrollView.pagingEnabled = YES;
    self.cScrollView.delegate = self;
    self.cScrollView.bounces = NO;
    [self addSubview:self.cScrollView];
}

- (void)setUpControllerScrollViewWithSubVC:(NSMutableArray *)subVC isPrestrain:(BOOL)isPrestrain
{
    [self setUpControllerScrollViewWithSubVC:subVC andCurrentIndex:0 isPrestrain:isPrestrain];
}

- (void)setUpControllerScrollViewWithSubVC:(NSMutableArray *)subVC andCurrentIndex:(NSInteger)currentIndex isPrestrain:(BOOL)isPrestrain
{
    self.isPrestrain = isPrestrain;
    [self configueControllerScrollViewWithSubVC:subVC andCurrentIndex:currentIndex];
    [self loadSubView];
    [self viewScrollToIndex:currentIndex];
    [self layoutSubviews];
}

- (void)configueControllerScrollViewWithSubVC:(NSMutableArray *)subVC andCurrentIndex:(NSInteger)currentIndex
{
    self.pageNumber = subVC.count;
    self.currentPage = currentIndex;
    self.subVCArray = [NSMutableArray arrayWithArray:subVC];
    self.subViewStateArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.pageNumber; i++)
    {
        NSNumber *state = [NSNumber numberWithBool:NO];
        [self.subViewStateArray addObject:state];
    }
}

- (void)loadSubView
{
    [self addSubViewWithIndex:self.currentPage];
    if (self.isPrestrain)
    {
        [self addSubViewWithIndex:self.currentPage - 1];
        [self addSubViewWithIndex:self.currentPage + 1];
    }
}

- (void)clearSubView
{
    for(NSInteger i = 0; i < self.pageNumber; i++){
    
        if ([[self.subViewStateArray objectAtIndex:i] boolValue]) {
            
            if (ABS(i - self.currentPage) > 1) {
                
                UIView *subView = [[self.subVCArray objectAtIndex:i] view];
                [subView removeFromSuperview];
                NSNumber *changeState = [NSNumber numberWithBool:NO];
                [self.subViewStateArray replaceObjectAtIndex:i withObject:changeState];
            }
        }
    }
}

- (void)addSubViewWithIndex:(NSInteger)index
{
    if (index < 0 || (index + 1) > self.pageNumber) {
        
        return;
    }
    BOOL viewIsLoad = [[self.subViewStateArray objectAtIndex:index] boolValue];
    if (!viewIsLoad) {
        
        UIView *view = [[self.subVCArray objectAtIndex:index] view];
        CGRect viewFrame;
        viewFrame.size = self.bounds.size;
        viewFrame.origin.x = index * CGRectGetWidth(self.frame);
        viewFrame.origin.y = 0;
        view.frame = viewFrame;
        [self.cScrollView addSubview:view];
        NSNumber *isLoad = [NSNumber numberWithBool:YES];
        [self.subViewStateArray replaceObjectAtIndex:index withObject:isLoad];
    }
}

- (void)scrollToViewControllerWithIndex:(NSInteger)index
{
    self.isScrollow = NO;
    [self.cScrollView setContentOffset:CGPointMake(index * WIDTH(self), 0) animated:NO];
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffSetX = scrollView.contentOffset.x;
    if (contentOffSetX < 0 || contentOffSetX > (self.pageNumber - 1) * WIDTH(self)) {
        
        return;
    }
    CGFloat ratio = contentOffSetX / WIDTH(self.cScrollView);
    //Log(@"%f",ratio);
    if (self.isScrollow) {//如果是点击分段控制控件切换controller的时候不需要再反过来更新分段控制控件的选项了
        
        if ([self.csDelegate respondsToSelector:@selector(viewScrollWithRadio:)]) {
            
            [self.csDelegate viewScrollWithRadio:ratio];
        }
    }
    else
        self.isScrollow = YES;
    CGFloat changeX = ratio - self.currentPage;
    if (changeX > 0.99 || changeX < -0.99) {//正常滑动
    
        NSInteger changeIndex = 1;
        if (changeX < 0) {
            
            changeIndex = -1;
        }
        if (changeX > 1 || changeX < -1){//点击tab切换  int 2 = 1 + 1.1
        
            changeIndex = changeX;
        }
        self.currentPage += changeIndex;
        [self loadSubView];
        //[self clearSubView];
        [self viewScrollToIndex:self.currentPage];
    }
}

#pragma mark - view滑动到index页
- (void)viewScrollToIndex:(NSInteger)index
{
    if ([self.csDelegate respondsToSelector:@selector(viewScrollToIndex:andCurrentVC:)])
    {
        [self.csDelegate viewScrollToIndex:index andCurrentVC:self.subVCArray[self.currentPage]];
    }
}

@end
