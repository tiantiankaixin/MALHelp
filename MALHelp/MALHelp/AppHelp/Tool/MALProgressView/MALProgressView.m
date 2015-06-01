//
//  MALProgressView.m
//  UIProgressViewDemo
//
//  Created by wangtian on 15-3-13.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "MALProgressView.h"

@implementation MALProgressView

- (UIImageView *)bgView
{
    if (_bgView == nil) {
        
        _bgView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _bgView;
}

- (UIImageView *)topView
{
    if (_topView == nil) {
        
        _topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, self.bounds.size.height)];
    }
    return _topView;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _bgView.frame = self.bounds;
    _topView.frame = self.bounds;
    [self setM_progress:_m_progress];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpView];
        [self configueProgressView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setUpView];
        [self configueProgressView];//设置默认值要在initWithCoder之后   awakeFromNib之前
    }
    return self;
}

+ (MALProgressView *)malProgressViewWithRect:(CGRect)rect
{
    MALProgressView *pro = [[MALProgressView alloc] initWithFrame:rect];
    return pro;
}

#pragma mark - 配置默认值
- (void)configueProgressView
{
    self.m_progress = 0.5;
    [self setBgColor:[UIColor lightGrayColor] topColor:[UIColor blueColor]];
}

- (void)setUpView
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    [self addSubview:self.topView];
}

- (void)setBgColor:(UIColor *)bgColor
{
    self.bgView.backgroundColor = bgColor;
}

- (void)setTopColor:(UIColor *)topColor
{
    self.topView.backgroundColor = topColor;
}

- (void)setBgImage:(NSString *)bgImage
{
    self.bgView.image = [UIImage imageNamed:bgImage];
}

- (void)setTopImage:(NSString *)topImage
{
    self.topView.image = [UIImage imageNamed:topImage];
}

- (void)setBgImage:(UIImage *)bgImage topImage:(UIImage *)top
{
    self.bgView.image = bgImage;
    self.topView.image = top;
}

- (void)setM_progress:(CGFloat)m_progress
{
    if (m_progress > 1.0 || m_progress < 0.0) {
        
        Log(@"超过范围了");
        return;
    }
    _m_progress = m_progress;
    CGRect topRect = self.topView.frame;
    topRect.size.width = CGRectGetWidth(self.frame) * m_progress;
    self.topView.frame = topRect;
}

- (void)setBgColor:(UIColor *)bgColor topColor:(UIColor *)topColor
{
    self.bgView.backgroundColor = bgColor;
    self.topView.backgroundColor = topColor;
}

@end
