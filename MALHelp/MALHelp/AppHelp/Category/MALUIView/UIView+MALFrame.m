//
//  UIView+MALFrame.m
//  MALHelp
//
//  Created by wangtian on 15/5/7.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "UIView+MALFrame.h"

CGFloat const notSet = MAXFLOAT;

@implementation UIView (MALFrame)

#pragma mark - frame
//set
- (void)setViewX:(CGFloat)x  Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height
{
    CGRect viewFrame = self.frame;
    if (x != notSet) {
        
        viewFrame.origin.x = x;
    }
    if (y != notSet) {
        
        viewFrame.origin.y = y;
    }
    if (width != notSet) {
        
        viewFrame.size.width = width;
    }
    if (height != notSet) {
        
        viewFrame.size.height = height;
    }
    self.frame = viewFrame;
}

- (void)setViewX:(CGFloat)x
{
    [self setViewX:x Y:notSet Width:notSet Height:notSet];
}

- (void)setViewY:(CGFloat)y
{
    [self setViewX:notSet Y:y Width:notSet Height:notSet];
}

- (void)setViewX:(CGFloat)x Y:(CGFloat)y
{
    [self setViewX:x Y:y Width:notSet Height:notSet];
}

- (void)setViewOrigin:(CGPoint)origin
{
    [self setViewX:origin.x Y:origin.y];
}

- (void)setViewWidth:(CGFloat)width
{
    [self setViewX:notSet Y:notSet Width:width Height:notSet];
}

- (void)setViewHeight:(CGFloat)height
{
    [self setViewX:notSet Y:notSet Width:notSet Height:height];
}

- (void)setViewWidth:(CGFloat)width Height:(CGFloat)height
{
    [self setViewX:notSet Y:notSet Width:width Height:height];
}

- (void)setViewSize:(CGSize)size
{
    [self setViewWidth:size.width Height:size.height];
}

- (void)changeViewX:(CGFloat)x
{
    CGFloat viewX = self.frame.origin.x + x;
    [self setViewX:viewX Y:notSet Width:notSet Height:notSet];
}

- (void)changeViewY:(CGFloat)y
{
    CGFloat viewY = self.frame.origin.y + y;
    [self setViewX:notSet Y:viewY Width:notSet Height:notSet];
}

- (void)changeViewX:(CGFloat)x Y:(CGFloat)y
{
    CGFloat viewX = self.frame.origin.x + x;
    CGFloat viewY = self.frame.origin.y + y;
    [self setViewX:viewX Y:viewY Width:notSet Height:notSet];
}

- (void)changeViewWidth:(CGFloat)width
{
    CGFloat viewWidth = self.frame.size.width + width;
    [self setViewX:notSet Y:notSet Width:viewWidth Height:notSet];
}

- (void)changeViewHeight:(CGFloat)height
{
    CGFloat viewHeight = self.frame.size.height + height;
    [self setViewX:notSet Y:notSet Width:notSet Height:viewHeight];
}

- (void)changeViewWidth:(CGFloat)width Height:(CGFloat)height
{
    CGFloat viewWidth = self.frame.size.width + width;
    CGFloat viewHeight = self.frame.size.height + height;
    [self setViewX:notSet Y:notSet Width:viewWidth Height:viewHeight];
}

#pragma mark - center
//set
- (void)setViewCenterX:(CGFloat)x Y:(CGFloat)y
{
    CGPoint viewCenter = self.center;
    if (x != notSet) {
        
        viewCenter.x = x;
    }
    if (y != notSet) {
        
        viewCenter.y = y;
    }
    self.center = viewCenter;
}

- (void)setViewCenterX:(CGFloat)x
{
    [self setViewCenterX:x Y:notSet];
}

- (void)setViewCenterY:(CGFloat)y
{
    [self setViewCenterX:notSet Y:y];
}

- (void)setViewCenter:(CGPoint)center
{
    [self setViewCenterX:center.x Y:center.y];
}

- (void)changeViewCenterX:(CGFloat)x
{
    CGFloat viewCenterX = self.center.x;
    [self setViewCenterX:viewCenterX Y:notSet];
}

- (void)changeViewCenterY:(CGFloat)y
{
    CGFloat viewCenterY = self.center.y;
    [self setViewCenterY:viewCenterY];
}


@end
