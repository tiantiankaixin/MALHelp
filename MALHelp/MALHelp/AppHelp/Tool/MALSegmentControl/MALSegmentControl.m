//
//  MALSegmentControl.m
//  MALSegControlDemo
//
//  Created by wangtian on 14-11-17.
//  Copyright (c) 2014年 wangtian. All rights reserved.
//

#import "MALSegmentControl.h"
#define Line_Height 1.5//底层下划线高度
#define Front_Line_Height 2.5 //表层下划线高度
#define AnimationTime 0.3//动画持续时间（滑动过渡效果）

//defaultControl 格式下使用的属性
#define bgView_Margin 4 //滑块与边界的距离的2倍
#define bgView_CornerRadius 4//滑块圆角大小
#define Max_Scale 2
@interface MALSegmentControl()<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) UIImageView *segControlLine;
@property (nonatomic,assign) CGFloat segWidth;
@property (nonatomic, assign) M_RGBA normalTextRgba;
@property (nonatomic, assign) M_RGBA selectTextRgba;
@property (nonatomic, assign) M_RGBA textRgba;

@end

@implementation MALSegmentControl

- (UIImageView *)segControlBgView
{
    if (_segControlBgView == nil) {
        
        _segControlBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.segNumbers * self.segWidth, CGRectGetHeight(self.frame))];
    }
    return _segControlBgView;
}

- (UIImageView *)segControlLine
{
    if (_segControlLine == nil) {
        
        CGFloat segControlLineY = 0;
        if (self.controlType == downSideLineControl) {
            
            segControlLineY = CGRectGetHeight(self.frame) - 1;
        }
        _segControlLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, segControlLineY, self.segWidth * self.segNumbers, Line_Height)];
        self.segControlLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _segControlLine;
}

- (UIImageView *)bgView
{
    if (_bgView == nil) {
        
        _bgView = [[UIImageView alloc] init];
        CGRect bgViewFrame = _bgView.frame;
        bgViewFrame.size.width = CGRectGetWidth(self.frame) / self.titleArray.count;
        bgViewFrame.size.height = CGRectGetHeight(self.frame);
        if (self.controlType == defaultControl) {
            
            bgViewFrame.size.width -= bgView_Margin;
            bgViewFrame.size.height -= bgView_Margin;
            _bgView.layer.cornerRadius = bgView_CornerRadius;
        }
        _bgView.frame = bgViewFrame;
    }
    return _bgView;
}

+ (MALSegmentControl *)getControlWithTitlesArray:(NSArray *)titleArray andFrame:(CGRect)rect selectIndex:(NSInteger)selectIndex andControlType:(MalSegControlType)controlType buttonWidth:(CGFloat)buttonWidth
{
    MALSegmentControl *seg = [[MALSegmentControl alloc] initWithFrame:rect];
    seg.titleArray = titleArray;
    seg.controlType = controlType;
    seg.selectIndex = selectIndex;
    seg.animationTime = AnimationTime;
    seg.maxScale = Max_Scale;
    [seg setSegNormalTextColor:[UIColor blackColor] selectTextColor:[UIColor blueColor] textFont:17];
    seg.segWidth = buttonWidth;
    seg.segNumbers = titleArray.count;
    seg.onePageNumbers = CGRectGetWidth(seg.frame) / buttonWidth;
    [seg setUpViewWithTitleArray:titleArray andSelectIndex:selectIndex];
    [seg changeIndexto:selectIndex];
    return  seg;
}

- (void)setUpViewWithTitleArray:(NSArray *)array andSelectIndex:(NSInteger)selectIndex
{
    [self setUpScrollView];
    NSInteger segNumbers = array.count;
    CGSize controlSize = self.frame.size;
    CGFloat buttonWidth = self.segWidth;
    CGFloat buttonHeight = controlSize.height;
    self.buttonArray = [[NSMutableArray alloc] init];
    [self addSubview:self.segControlBgView];
    [self addSubview:self.bgView];
    if (self.controlType == downSideLineControl || self.controlType == upSideLineControl) {
        
        [self addSubview:self.segControlLine];
    }
    for (int i = 0; i < segNumbers; i++) {
        
        UIButton *childButton = [self buttonWithTitle:[array objectAtIndex:i]];
        childButton.tag = i;
        [childButton addTarget:self action:@selector(segClick:) forControlEvents:(UIControlEventTouchUpInside)];
        CGRect buttonFrame = CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight);
        childButton.frame = buttonFrame;
        [self addSubview:childButton];
        [self.buttonArray addObject:childButton];
        if (i == selectIndex) {
            
            self.bgView.center = CGPointMake(i * buttonWidth + buttonWidth / 2, buttonHeight / 2);
            
            CGRect lineFrame;
            if (self.controlType == downSideLineControl) {
                lineFrame = CGRectMake(i * buttonWidth, buttonHeight - Front_Line_Height, buttonWidth, Front_Line_Height);
                UIImageView *underLine = [[UIImageView alloc] init];
                underLine.backgroundColor = [UIColor blueColor];
                underLine.frame = lineFrame;
                [self addSubview:underLine];
                self.lineView = underLine;
            } else if (self.controlType == upSideLineControl) {
                lineFrame = CGRectMake(i * buttonWidth, 0, buttonWidth, Front_Line_Height);
                UIImageView *underLine = [[UIImageView alloc] init];
                underLine.backgroundColor = [UIColor blueColor];
                underLine.frame = lineFrame;
                [self addSubview:underLine];
                self.lineView = underLine;
            }
            
        }
    }
    [self setButtonTextColorWithIndex:selectIndex color:self.selectTextColor];
}

#pragma mark - 设置scrollView的一些属性
- (void)setUpScrollView
{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
    self.contentSize = CGSizeMake(self.segWidth * self.segNumbers, 0);
}

#pragma mark - 视图上德按钮被点击
- (void)segClick:(UIButton *)sender
{
    [self segChangeWithFromIndex:self.selectIndex toIndex:sender.tag];
}

- (void)segChangeWithFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    [UIView animateWithDuration:self.animationTime //时长
                          delay:0 //延迟时间
                        options:UIViewAnimationOptionTransitionFlipFromLeft//动画效果
                     animations:^{
                         
                         CGRect underLineFrame = self.lineView.frame;
                         underLineFrame.origin.x = toIndex * self.segWidth;
                         self.lineView.frame = underLineFrame;
                         [self setBgViewFrameWithIndex:toIndex];
                         [self updateContentoffSetWithToIndex:toIndex withAnimation:NO];
                         
                     } completion:^(BOOL finish){
                         
                         self.selectIndex = toIndex;
                         [self updateTextColor];
                         
                         if (self.changeHandle) {
                             
                             self.changeHandle(toIndex);
                         }
                     }];
}

#pragma mark - 改变当前选中seg后  改变颜色
- (void)updateTextColor
{
    for(NSInteger i = 0; i < self.buttonArray.count; i++)
    {
        if (i != self.selectIndex) {
            
            [self setButtonTextColorWithIndex:i color:self.normalTextColor];
            [self setButtonTextScaleWithIndex:i scale:0];
        }
        else{
            
            [self setButtonTextColorWithIndex:i color:self.selectTextColor];
            [self setButtonTextScaleWithIndex:i scale:1];
        }
    }
}

- (void)changeIndexto:(NSInteger)toIndex
{
    if (![self validIndex:toIndex])
    {
        return;
    }
    [self segChangeWithFromIndex:self.selectIndex toIndex:toIndex];
}

- (void)setBgViewFrameWithIndex:(NSInteger)index
{
    if (![self validIndex:index])
    {
        return;
    }
    CGPoint bgViewCenter = self.bgView.center;
    bgViewCenter.x = index * self.segWidth + self.segWidth / 2;
    self.bgView.center = bgViewCenter;
}

- (UIButton *)buttonWithTitle:(NSString *)title;
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:self.normalTextColor forState:(UIControlStateNormal)];
    return button;
}

#pragma mark - 检查索引的有效性
- (BOOL)validIndex:(NSInteger)index
{
    if (index < 0 || index >= self.segNumbers)
    {
        return NO;
    }
    return YES;
}

- (void)setButtonTextColorWithIndex:(NSInteger)index color:(UIColor *)color
{
    if (![self validIndex:index])
    {
        return;
    }
    UIButton *button = [self.buttonArray objectAtIndex:index];
    [button setTitleColor:color forState:(UIControlStateNormal)];
}

#pragma mark - 设置按钮的缩放比例
- (void)setButtonTextScaleWithIndex:(NSInteger)index scale:(CGFloat)scale
{
    if (![self validIndex:index] || !self.isScale)
    {
        return;
    }
    UIButton *button = [self.buttonArray objectAtIndex:index];
    CGFloat nowScale = 1 + (self.maxScale - 1) * scale;
    if (scale < 0)
    {
        nowScale = self.maxScale + (self.maxScale - 1) * scale;
    }
    button.transform = CGAffineTransformMakeScale(nowScale,nowScale);
}

- (void)setButtonBgColorWithIndex:(NSInteger)index color:(UIColor *)color
{
    UIButton *button = [self.buttonArray objectAtIndex:index];
    [button setBackgroundColor:color];
}

- (void)setButtonBgImageWithIndex:(NSInteger)index imageName:(NSString *)imageName
{
    UIButton *button = [self.buttonArray objectAtIndex:index];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
}

- (void)setSegNormalTextColor:(UIColor *)color selectTextColor:(UIColor *)selectColor textFont:(CGFloat)fontSize
{
    self.normalTextColor = color;
    self.selectTextColor = selectColor;
    for(int i = 0; i < self.buttonArray.count; i++)
    {
        UIButton *button = [self.buttonArray objectAtIndex:i];
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        if (i == self.selectIndex)
        {
            [self setButtonTextColorWithIndex:i color:selectColor];
            continue;
        }
        [self setButtonTextColorWithIndex:i color:color];
    }
}

- (void)setSegNormalTextColorWithRgba:(M_RGBA)color selectTextColorRgba:(M_RGBA)selectColorRgba textFont:(CGFloat)fontSize
{
    [self setSegNormalTextColor:RGBA(color.m_r, color.m_g, color.m_b, color.m_a) selectTextColor:RGBA(selectColorRgba.m_r, selectColorRgba.m_g, selectColorRgba.m_b, selectColorRgba.m_a) textFont:fontSize];
    self.normalTextRgba = color;
    self.selectTextRgba = selectColorRgba;
    self.textRgba = [NSObject mrgbaWithR:selectColorRgba.m_r - color.m_r G:selectColorRgba.m_g - color.m_g B:selectColorRgba.m_b - color.m_b A:color.m_a];
    
}

- (void)setSegNormalBg:(id)noraml selectBg:(id)seclect
{
    [self setImageViewBg:self.segControlBgView bg:noraml];
    [self setImageViewBg:self.bgView bg:seclect];
}

- (void)setImageViewBg:(UIImageView *)imageView bg:(id)bg
{
    if ([bg isKindOfClass:[UIColor class]]) {
        
        [imageView setBackgroundColor:bg];
    }
    else if([bg isKindOfClass:[NSString class]]){
        
        [imageView setImage:[UIImage imageNamed:bg]];
    }
}

- (void)setSegNormalLineColor:(id)normalColor selectColor:(id)selectColor
{
    [self setImageViewBg:self.segControlLine bg:normalColor];
    [self setImageViewBg:self.lineView bg:selectColor];
}

- (void)addBoarderWithImageName:(NSString *)imageName
{
    UIImageView *viewBoarder = [[UIImageView alloc] initWithFrame:self.bounds];
    viewBoarder.image = [UIImage imageNamed:imageName];
    [self addSubview:viewBoarder];
    
}

- (void)addBoarderWithColor:(UIColor *)boarderColor boarderWidth:(CGFloat)boarderWidth viewCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = boarderWidth;
    self.layer.borderColor = boarderColor.CGColor;
}

- (void)setControlHandel:(void (^)(NSInteger index))handel
{
    self.changeHandle = handel;
}

#pragma mark - 根据进度设置文本颜色  及大小
- (void)setNowTextColorWithRatio:(CGFloat)ratio
{
    if (ratio > self.segNumbers)
    {
        return;
    }
    CGFloat colorProgress = ratio - self.selectIndex;
    if (self.selectIndex > ratio)
    {
        colorProgress = -colorProgress;
    }
    if (self.isChangeColor)
    {
        M_RGBA nowNormalText;
        nowNormalText.m_r = self.textRgba.m_r * colorProgress + self.normalTextRgba.m_r;
        nowNormalText.m_g = self.textRgba.m_g * colorProgress + self.normalTextRgba.m_g;
        nowNormalText.m_b = self.textRgba.m_b * colorProgress + self.normalTextRgba.m_b;
        
        M_RGBA nowSelectText;
        nowSelectText.m_r = self.selectTextRgba.m_r - self.textRgba.m_r * colorProgress;
        nowSelectText.m_g = self.selectTextRgba.m_g - self.textRgba.m_g * colorProgress;
        nowSelectText.m_b = self.selectTextRgba.m_b - self.textRgba.m_b * colorProgress;
        
        UIColor *selectTextColor = RGB(nowNormalText.m_r, nowNormalText.m_g, nowNormalText.m_b);
        UIColor *normalTextColor = RGB(nowSelectText.m_r, nowSelectText.m_g, nowSelectText.m_b);
        if (self.selectIndex < ratio)//向左滑动
        {
            [self setButtonTextColorWithIndex:self.selectIndex color:normalTextColor];
            [self setButtonTextColorWithIndex:self.selectIndex + 1 color:selectTextColor];
        }
        else //向右滑动
        {
            [self setButtonTextColorWithIndex:self.selectIndex color:normalTextColor];
            [self setButtonTextColorWithIndex:self.selectIndex - 1 color:selectTextColor];
            }
    }
    if (self.isScale)
    {
        if (self.selectIndex < ratio)//向左滑动
        {
            [self setButtonTextScaleWithIndex:self.selectIndex scale:-colorProgress];
            [self setButtonTextScaleWithIndex:self.selectIndex + 1 scale:colorProgress];
        }
        else //向右滑动
        {
            [self setButtonTextScaleWithIndex:self.selectIndex scale:-colorProgress];
            [self setButtonTextScaleWithIndex:self.selectIndex - 1 scale:colorProgress];
        }
    }
}

- (void)updateViewFrameWithRatio:(CGFloat)ratio
{
    CGRect underLineFrame = self.lineView.frame;
    underLineFrame.origin.x = self.segWidth * ratio;
    self.lineView.frame = underLineFrame;//移动下划线
    
    CGPoint bgViewCenter = self.bgView.center;
    bgViewCenter.x = self.segWidth * ratio / 2;
    self.bgView.center = bgViewCenter;//移动滑块
    
    [self setNowTextColorWithRatio:ratio];
    
    NSInteger tempRadio = ratio;
    CGFloat temp = tempRadio;
    if (temp == ratio)
    {
        [self updateContentoffSetWithToIndex:tempRadio withAnimation:YES];
         self.selectIndex = tempRadio;
        [self updateTextColor];
    }
}

- (void)updateContentoffSetWithToIndex:(NSInteger)toIndex withAnimation:(BOOL)animation
{
    NSInteger halfNumbers = self.onePageNumbers / 2;
    NSInteger left = toIndex;
    NSInteger right = (self.segNumbers - 1) - toIndex;
    CGFloat contentOffSet;
    if(right <= halfNumbers){
        
        NSInteger leftNeedNumbers = self.onePageNumbers - right - 1;
        contentOffSet = (toIndex - leftNeedNumbers) * self.segWidth;
        [self setContentOffset:CGPointMake(contentOffSet, 0) animated:animation];
    }
    else{
        
        if (left > halfNumbers) {
            
            contentOffSet = (toIndex - halfNumbers) * self.segWidth;
            [self setContentOffset:CGPointMake(contentOffSet, 0) animated:animation];
        }
        else{
            
            CGFloat nowContentOffSetX = self.contentOffset.x;
            if (nowContentOffSetX >= 0) {
                
                contentOffSet = 0;
                [self setContentOffset:CGPointMake(contentOffSet, 0) animated:animation];
            }
        }
    }
}

@end
