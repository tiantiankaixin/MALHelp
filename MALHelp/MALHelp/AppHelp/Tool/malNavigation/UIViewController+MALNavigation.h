//
//  UIViewController+MALNavigation.h
//  MALHelp
//
//  Created by wangtian on 15/5/7.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBarItem.h"

@interface UIViewController (MALNavigation)

- (CustomBarItem *)setItemWithTitle:(NSString *)title textColor:(UIColor *)color fontSize:(CGFloat)font itemType:(ItemType)type;
- (CustomBarItem *)setItemWithImage:(NSString *)imageName size:(CGSize)size itemType:(ItemType)type;
- (CustomBarItem *)setItemWithCustomView:(UIView *)customView itemType:(ItemType)type;

//使用默认设置来设置item
- (CustomBarItem *)setLeftItemWithTitle:(NSString *)title;
- (CustomBarItem *)setCenterItemWithTitle:(NSString *)title;
- (CustomBarItem *)setRightItemWithTitle:(NSString *)title;

/**
 *  设置返回按钮颜色，全局有效
 *
 *  @param color 颜色
 */
+ (void)setBackItemTextColor:(UIColor *)color;

/**
 *  设置导航栏背景图片
 *
 *  @param naviVC  导航栏所属导航控制器
 *  @param bgImage UIImage
 */
+ (void)setNavigationBarBgImage:(UINavigationController *)naviVC andBgImage:(UIImage *)bgImage;
@end
