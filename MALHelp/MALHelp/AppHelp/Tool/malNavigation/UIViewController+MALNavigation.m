//
//  UIViewController+MALNavigation.m
//  MALHelp
//
//  Created by wangtian on 15/5/7.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "UIViewController+MALNavigation.h"

#define ItemColor [UIColor redColor] //item颜色
#define SideItemTextSize   15        //左右item文字大小
#define CenterItemTextSize 17        //中间item文字大小

@implementation UIViewController (MALNavigation)

- (CustomBarItem *)setItemWithTitle:(NSString *)title textColor:(UIColor *)color fontSize:(CGFloat)font itemType:(ItemType)type
{
    CustomBarItem *item = [CustomBarItem itemWithTitle:title textColor:color fontSize:font itemType:type];
    [item setItemWithNavigationItem:self.navigationItem itemType:type];
    return item;
}

- (CustomBarItem *)setItemWithImage:(NSString *)imageName size:(CGSize)size itemType:(ItemType)type
{
    CustomBarItem *item = [CustomBarItem itemWithImage:imageName size:size type:type];
    [item setItemWithNavigationItem:self.navigationItem itemType:type];
    return item;
}

- (CustomBarItem *)setItemWithCustomView:(UIView *)customView itemType:(ItemType)type
{
    CustomBarItem *item = [CustomBarItem itemWithCustomeView:customView type:type];
    [item setItemWithNavigationItem:self.navigationItem itemType:type];
    return item;
}

- (CustomBarItem *)setLeftItemWithTitle:(NSString *)title
{
    return [self setItemWithTitle:title textColor:ItemColor fontSize:SideItemTextSize itemType:left];
}

- (CustomBarItem *)setCenterItemWithTitle:(NSString *)title
{
    return [self setItemWithTitle:title textColor:ItemColor fontSize:CenterItemTextSize itemType:center];
}

- (CustomBarItem *)setRightItemWithTitle:(NSString *)title
{
     return [self setItemWithTitle:title textColor:ItemColor fontSize:SideItemTextSize itemType:right];
}

#pragma mark - 设置返回按钮颜色
+  (void)setBackItemTextColor:(UINavigationController *)naviVC itemColor:(UIColor *)color
{
    [naviVC.navigationBar setTintColor:color];
}

#pragma mark - 设置导航栏背景图片
+ (void)setNavigationBarBgImage:(UINavigationController *)naviVC andBgImage:(UIImage *)bgImage
{
    [naviVC.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    naviVC.navigationBar.translucent = YES;
}


@end
