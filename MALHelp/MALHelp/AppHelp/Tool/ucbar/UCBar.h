//
//  UCBar.h
//  MALHelp
//
//  Created by wangtian on 15/11/17.
//  Copyright © 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCBar : UIView

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, copy) void(^selectIndexBlock)(NSInteger selectIndex);

+ (UCBar *)barWithTitleArray:(NSArray *)titleArray btnWidth:(CGFloat)btnWidth frame:(CGRect)frame defaultSelectIndex:(NSInteger)selectIndex;

- (void)selectItemWithIndex:(NSInteger)index;

- (void)updateViewFrameWithRatio:(CGFloat)ratio;

@end
