//
//  UIView+MALFrame.h
//  MALHelp
//
//  Created by wangtian on 15/5/7.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MALFrame)

//frame
//set
- (void)setViewX:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height;

- (void)setViewX:(CGFloat)x;
- (void)setViewY:(CGFloat)y;
- (void)setViewX:(CGFloat)x Y:(CGFloat)y;
- (void)setViewOrigin:(CGPoint)origin;

- (void)setViewWidth:(CGFloat)width;
- (void)setViewHeight:(CGFloat)height;
- (void)setViewWidth:(CGFloat)width Height:(CGFloat)height;
- (void)setViewSize:(CGSize)size;

- (void)changeViewX:(CGFloat)x;
- (void)changeViewY:(CGFloat)y;
- (void)changeViewX:(CGFloat)x Y:(CGFloat)y;

- (void)changeViewWidth:(CGFloat)width;
- (void)changeViewHeight:(CGFloat)height;
- (void)changeViewWidth:(CGFloat)width Height:(CGFloat)height;


//center
//set
- (void)setViewCenterX:(CGFloat)x Y:(CGFloat)y;
- (void)setViewCenterX:(CGFloat)x;
- (void)setViewCenterY:(CGFloat)y;
- (void)setViewCenter:(CGPoint)center;

- (void)changeViewCenterX:(CGFloat)x;
- (void)changeViewCenterY:(CGFloat)y;

@end
