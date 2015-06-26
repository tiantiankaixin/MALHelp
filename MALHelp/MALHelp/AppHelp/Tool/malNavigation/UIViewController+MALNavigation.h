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

- (CustomBarItem *)setItemWithTitle:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font itemType:(ItemType)type;
- (CustomBarItem *)setItemWithImage:(NSString *)imageName size:(CGSize)size itemType:(ItemType)type;
- (CustomBarItem *)setItemWithCustomView:(UIView *)customView itemType:(ItemType)type;

//使用默认设置来设置item
- (CustomBarItem *)setLeftItemWithTitle:(NSString *)title;
- (CustomBarItem *)setCenterItemWithTitle:(NSString *)title;
- (CustomBarItem *)setRightItemWithTitle:(NSString *)title;

/**
 *  设置导航控制器导航栏返回按钮文字颜色
 *
 *  @param naviVC 要设置的navigationController
 *  @param color  返回按钮颜色
 */
+ (void)setBackItemTextColor:(UINavigationController *)naviVC itemColor:(UIColor *)color;

/**
 *  设置导航栏背景图片
 *
 *  @param naviVC  导航栏所属导航控制器
 *  @param bgImage UIImage
 */
+ (void)setNavigationBarBgImage:(UINavigationController *)naviVC andBgImage:(UIImage *)bgImage;
@end
