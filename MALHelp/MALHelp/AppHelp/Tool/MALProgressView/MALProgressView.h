//
//  MALProgressView.h
//  UIProgressViewDemo
//
//  Created by wangtian on 15-3-13.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MALProgressView : UIView

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, assign) CGFloat m_progress;

+ (MALProgressView *)malProgressViewWithRect:(CGRect)rect;
- (void)setBgImage:(UIImage *)bgImage topImage:(UIImage *)top;
- (void)setBgColor:(UIColor *)bgColor topColor:(UIColor *)topColor;

@end
