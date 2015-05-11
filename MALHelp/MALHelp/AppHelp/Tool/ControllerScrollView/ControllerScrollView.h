//
//  ControllerScrollView.h
//  SegDemo
//
//  Created by wangtian on 15-1-19.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ControllerScrollViewDelegate <NSObject>

- (void)viewScrollWithRadio:(CGFloat)ratio;

@end

@interface ControllerScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *cScrollView;
@property (nonatomic, strong) NSMutableArray *subVCArray;
@property (nonatomic, strong) NSMutableArray *subViewStateArray;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, weak) id<ControllerScrollViewDelegate> csDelegate;
@property (nonatomic, assign) BOOL isScrollow;//YES:代表是滑动cScrollView  NO:点击的分段控制控件

//+ (ControllerScrollView *)controllerScrollViewWithFrame:(CGRect)frame subViews:(NSMutableArray *)subViews;
- (void)setUpControllerScrollViewWithSubVC:(NSMutableArray *)subVC;
- (void)setUpControllerScrollViewWithSubVC:(NSMutableArray *)subVC andCurrentIndex:(NSInteger)currentIndex;
- (void)scrollToViewControllerWithIndex:(NSInteger)index;
@end
