//
//  BarItem.h
//  MALHelp
//
//  Created by wangtian on 15/11/17.
//  Copyright © 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MSwipDirection) {

    mLeft, //向左滑
    mRight
};

@interface BarItem : UIControl

@property (nonatomic, strong) UILabel *bgLabel;
@property (nonatomic, strong) UIView *topLBSuperView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIColor *defaultColor;
@property (nonatomic, strong) UIColor *selectColor;

- (instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame;
- (void)setLabelDefaultColor:(UIColor *)defaultColor selectColor:(UIColor *)selectColor;
- (void)changeItemWithProgress:(CGFloat)progress swipDirection:(MSwipDirection)direction isFromItem:(BOOL)isFromItem;

//选中item
- (void)selectItem;

@end
