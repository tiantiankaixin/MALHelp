//
//  ControllerScrollView.h
//  SegDemo
//
//  Created by wangtian on 15-1-19.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ControllerScrollViewDelegate <NSObject>

@optional
- (void)viewScrollWithRadio:(CGFloat)ratio;
- (void)viewScrollToIndex:(NSInteger)currentIndex andCurrentVC:(UIViewController *)currentVC;

@end

@interface ControllerScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *cScrollView;
@property (nonatomic, strong) NSMutableArray *subVCArray;
@property (nonatomic, strong) NSMutableArray *subViewStateArray;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, weak) id<ControllerScrollViewDelegate> csDelegate;

/**
 *  是否开启预加载 YES:开启
 */
@property (nonatomic, assign) BOOL isPrestrain;

//+ (ControllerScrollView *)controllerScrollViewWithFrame:(CGRect)frame subViews:(NSMutableArray *)subViews;
/**
 *  初始化控件
 *
 *  @param subVC       子viewcontroller数组
 *  @param isPrestrain 是否开启预加载
 */
- (void)setUpControllerScrollViewWithSubVC:(NSMutableArray *)subVC isPrestrain:(BOOL)isPrestrain;

/**
 *  初始化控件
 *
 *  @param subVC        子viewcontroller数组
 *  @param currentIndex 默认选择项
 *  @param isPrestrain  是否开启预加载
 */
- (void)setUpControllerScrollViewWithSubVC:(NSMutableArray *)subVC andCurrentIndex:(NSInteger)currentIndex isPrestrain:(BOOL)isPrestrain;
- (void)scrollToViewControllerWithIndex:(NSInteger)index;
@end
