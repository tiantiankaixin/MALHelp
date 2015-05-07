//
//  UIView+MALFunction.m
//  MALHelp
//
//  Created by wangtian on 15/5/7.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "UIView+MALFunction.h"

@implementation UIView (MALFunction)

#pragma mark - view转换为图片
- (UIImage *)imageFromView
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
