//
//  MALImage.h
//  MALHelp
//
//  Created by wangtian on 15/6/26.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MALImage : UIImage

/**
 *  图像处理
 *
 *  @param anImage UIImage 对象
 *  @param type    1、彩图灰度化  2、深棕色  3、反色
 *
 *  @return <#return value description#>
 */
+ (UIImage*)grayscale:(UIImage*)anImage type:(int)type;

@end
