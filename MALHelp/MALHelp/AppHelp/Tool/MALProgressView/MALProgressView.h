//
//  MALProgressView.h
//  UIProgressViewDemo
//
//  Created by wangtian on 15-3-13.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface MALProgressView : UIView

@property (nonatomic, strong)  UIImageView *bgView;
@property (nonatomic, strong)  UIImageView *topView;
@property (nonatomic, assign)  IBInspectable CGFloat m_progress;
@property (nonatomic, strong)  IBInspectable UIColor *bgColor;
@property (nonatomic, strong)  IBInspectable UIColor *topColor;
@property (nonatomic, copy)    IBInspectable NSString *bgImage;
@property (nonatomic, copy)    IBInspectable NSString *topImage;

+ (MALProgressView *)malProgressViewWithRect:(CGRect)rect;
- (void)setBgImage:(UIImage *)bgImage topImage:(UIImage *)top;
- (void)setBgColor:(UIColor *)bgColor topColor:(UIColor *)topColor;

@end
