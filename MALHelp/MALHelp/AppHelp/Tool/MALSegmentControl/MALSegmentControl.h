//
//  MALSegmentControl.h
//  MALSegControlDemo
//
//  Created by wangtian on 14-11-17.
//  Copyright (c) 2014年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+SystemInfo.h"
typedef enum{
    
    defaultControl,             //不带下划线的
    downSideLineControl,        //有下划线的
    upSideLineControl           //下划线在上部
    
}MalSegControlType;
typedef void(^MutableSegBlock)(NSInteger);

@interface MALSegmentControl : UIScrollView

@property (nonatomic, strong)   UIImageView *bgView;
@property (nonatomic, strong)   UIImageView *segControlBgView;
@property (nonatomic, copy)     MutableSegBlock changeHandle;//点击按钮触发的block
@property (nonatomic, assign)   NSInteger selectIndex;//当前选中项
@property (nonatomic, assign)   CGFloat animationTime;
@property (nonatomic, strong)   UIColor *selectTextColor;
@property (nonatomic, strong)   UIColor *normalTextColor;
@property (nonatomic, strong)   NSArray *titleArray;
@property (nonatomic, assign)   MalSegControlType controlType;
@property (nonatomic, assign)   NSInteger segNumbers;
@property (nonatomic, assign)   NSInteger onePageNumbers;
@property (nonatomic, assign)   CGFloat bgLineHegiht;
@property (nonatomic, assign)   CGFloat lineHeight;
/**
 *  seg上文字最大放大比例 默认值为2
 */
@property (nonatomic, assign)   CGFloat maxScale;

/**
 *  是否支持变色
 */
@property (nonatomic, assign) BOOL isChangeColor;

/**
 *  是否支持缩放
 */
@property (nonatomic, assign) BOOL isScale;

/**
 *得到一个控件
 *@param  titleArray 标题数组
 *@param  rect 控件的frame
 *@param  selectIndex 默认选中项
 *@param  controlType 控件样式(defaultControl,lineControl)(带下划线，不带下划线)
 *@return 一个MALSegmentControl对象
 */
+ (MALSegmentControl *)getControlWithTitlesArray:(NSArray *)titleArray andFrame:(CGRect)rect selectIndex:(NSInteger)selectIndex andControlType:(MalSegControlType)controlType buttonWidth:(CGFloat)buttonWidth;

/**
 *用代码来控制控件的切换
 *@param toIndex 从当前索引切换到的目标索引
 */
- (void)changeIndexto:(NSInteger)toIndex;//代码跳转选择

/**
 *  设置seg文字颜色
 *
 *  @param color           未选中seg文字颜色rgba值
 *  @param selectColorRgba 选中seg文字颜色rgba值
 *  @param fontSize        文字大小
 */
- (void)setSegNormalTextColorWithRgba:(M_RGBA)color selectTextColorRgba:(M_RGBA)selectColorRgba textFont:(CGFloat)fontSize;//设置按钮文字的颜色和大小(正常状态、和被点击后的状态)

/**
 *设置控件的背景
 *@param noraml 正常状态下的背景(可以是UIColor或者是图片名称)
 *@param select 选中状态下的背景(同上)
 */
- (void)setSegNormalBg:(id)noraml selectBg:(id)seclect;//设置按钮背景图片(参数可以是UIColor或图片名称)

/**
 *设置控件下划线背景
 *@param noraml 正常状态下的背景(可以是UIColor或者是图片名称)
 *@param select 选中状态下的背景(同上)
 */
- (void)setSegNormalLineColor:(id)normalColor selectColor:(id)selectColor;//设置按钮下划线颜色(正常状态、和被点击后的状态)

/**
 *为控件添加边框
 *@param imageName 边框图片名称
 */
- (void)addBoarderWithImageName:(NSString *)imageName;

/**
 *为控件添加边框
 *@param boarderColor 边框颜色
 *@param boarderWidth 边框宽度
 *@param cornerRadius 边框圆角大小
 *@return 返回值说明
 */
- (void)addBoarderWithColor:(UIColor *)boarderColor boarderWidth:(CGFloat)boarderWidth viewCornerRadius:(CGFloat)cornerRadius;

/**
 *点击控件触发block
 *@param handel  点击控件触发的block代码块
 *@param index   block参数 被点击的索引
 */
- (void)setControlHandel:(void(^)(NSInteger index))handel;

- (void)updateViewFrameWithRatio:(CGFloat)ratio;

@end
