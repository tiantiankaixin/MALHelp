//
//  UIImage+MALImage.h
//  MALAnimationExample
//
//  Created by wangtian on 15/8/5.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MALImage)

/**
 *  图像处理
 *
 *  @param anImage UIImage 对象
 *  @param type    1、彩图灰度化  2、深棕色  3、反色
 *
 *  @return UIImage *
 */
+ (UIImage*)grayscale:(UIImage*)anImage type:(int)type;


- (UIImage *)addlogoImage:(UIImage *)resizedImage;

- (UIImage *)changeImageSize:(CGSize)newSize;

/**
 *  根据图片名称获得图片
 *
 *  @return UIImage
 */
+ (UIImage *)imageWithName:(NSString *)name;

@end
