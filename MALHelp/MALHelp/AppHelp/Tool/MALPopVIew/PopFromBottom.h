//
//  PopFromBottom.h
//  MALHelp
//
//  Created by wangtian on 15/7/27.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopFromBottom : UIViewController

/**
 *  YES 显示
 */
@property (nonatomic, copy) void(^popBlock)(BOOL isShow);

@property (nonatomic, strong) UIView *bgView;

- (void)showOrHiddenView;

@end
