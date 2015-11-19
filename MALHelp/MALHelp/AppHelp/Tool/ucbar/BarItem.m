//
//  BarItem.m
//  MALHelp
//
//  Created by wangtian on 15/11/17.
//  Copyright © 2015年 wangtian. All rights reserved.
//

#import "BarItem.h"
#import "UIView+MALFrame.h"

@implementation BarItem

#pragma mark - getter
- (UILabel *)bgLabel
{
    if (_bgLabel == nil)
    {
        _bgLabel = [[UILabel alloc] init];
        _bgLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bgLabel;
}

- (UIView *)topLBSuperView
{
    if (_topLBSuperView == nil)
    {
        _topLBSuperView = [[UIView alloc] init];
        _topLBSuperView.clipsToBounds = YES;
        _topLBSuperView.userInteractionEnabled = NO;
        _topLBSuperView.backgroundColor = [UIColor whiteColor];
    }
    return _topLBSuperView;
}

- (UILabel *)topLabel
{
    if (_topLabel == nil)
    {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabel;
}

- (UIColor *)defaultColor
{
    if (_defaultColor == nil)
    {
        _defaultColor = [UIColor blackColor];
    }
    return _defaultColor;
}

- (UIColor *)selectColor
{
    if (_selectColor == nil)
    {
        _selectColor = [UIColor blueColor];
    }
    return _selectColor;
}

- (instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpViewWithTitle:title];
    }
    return self;
}

- (void)setUpViewWithTitle:(NSString *)title
{
    self.bgLabel.frame = self.bounds;
    self.topLBSuperView.frame = self.bounds;
    self.topLabel.frame = self.bounds;
    [self.topLBSuperView addSubview:self.topLabel];
    self.bgLabel.text = title;
    self.topLabel.text = title;
    [self addSubview:self.bgLabel];
    [self addSubview:self.topLBSuperView];
    [self setLabelDefaultColor:self.defaultColor selectColor:self.selectColor];
}

#pragma mark - 设置item默认状态 和选中状态时的文字颜色
- (void)setLabelDefaultColor:(UIColor *)defaultColor selectColor:(UIColor *)selectColor
{
    self.defaultColor = defaultColor;
    self.selectColor = selectColor;
    self.bgLabel.textColor = selectColor;
    self.topLabel.textColor = defaultColor;
}

#pragma mark - 选中item
- (void)selectItem
{
    [self.topLBSuperView setViewWidth:0];
}

- (void)changeItemWithProgress:(CGFloat)progress swipDirection:(MSwipDirection)direction isFromItem:(BOOL)isFromItem
{
    CGFloat itemWidth = WIDTH(self);
    CGFloat topViewWidth = itemWidth * (1 - progress);
    CGFloat zeroX = 0;//label的x零点
    if(direction == mLeft)//向左滑动 label应该贴着右侧
    {
        if (isFromItem)//取消选中的item      //下面是要选中的  上面是默认的
        {
            [self.topLBSuperView setViewX:zeroX];
            [self.topLBSuperView setViewWidth:topViewWidth];
            [self.topLabel setViewX:zeroX];
        }
        else//要选中的item
        {
            [self.topLBSuperView setViewWidth:topViewWidth];
            [self.topLBSuperView setViewX:itemWidth - topViewWidth];
            [self.topLabel setViewX:topViewWidth - itemWidth];
        }
    }
    else if (direction == mRight)//向右侧滑动
    {
        if(isFromItem)//取消选中  即上边的superView放大
        {
            [self.topLBSuperView setViewWidth:topViewWidth];
            [self.topLBSuperView setViewX:itemWidth - topViewWidth];
            [self.topLabel setViewX:topViewWidth - itemWidth];
        }
        else
        {
            [self.topLBSuperView setViewX:zeroX];
            [self.topLBSuperView setViewWidth:topViewWidth];
            [self.topLabel setViewX:zeroX];
        }
    }
}

//- (CGFloat)widthWithStr:(NSString *)str height:(CGFloat)height
//{
//   NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
//   CGSize strSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//    return strSize.width;
//}

@end
