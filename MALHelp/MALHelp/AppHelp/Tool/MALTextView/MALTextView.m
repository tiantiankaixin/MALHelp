//
//  MALTextView.m
//  MALPlaceholderTextView
//
//  Created by wangtian on 15/7/21.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "MALTextView.h"

@interface MALTextView()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *placeHolderTextView;

@end

@implementation MALTextView

#pragma mark - getter
- (UITextView *)placeHolderTextView
{
    if (_placeHolderTextView == nil)
    {
        _placeHolderTextView = [[UITextView alloc] initWithFrame:self.bounds];
        _placeHolderTextView.textColor = [UIColor lightGrayColor];
        _placeHolderTextView.userInteractionEnabled = NO;
    }
    return _placeHolderTextView;
}

- (UITextView *)inputTextView
{
    if (_inputTextView == nil)
    {
        _inputTextView = [[UITextView alloc] initWithFrame:self.bounds];
        _inputTextView.backgroundColor = [UIColor clearColor];
        _inputTextView.delegate = self;
    }
    return _inputTextView;
}

- (void)setM_placeHolder:(NSString *)m_placeHolder
{
    _m_placeHolder = m_placeHolder;
    self.placeHolderTextView.text = _m_placeHolder;
}

- (void)setM_text:(NSString *)m_text
{
    _m_text = m_text;
    self.inputTextView.text = m_text;
}

- (void)setPFontSize:(CGFloat)pFontSize
{
    _pFontSize = pFontSize;
    self.placeHolderTextView.font = [UIFont systemFontOfSize:pFontSize];
}

- (void)setTextFontSize:(CGFloat)textFontSize
{
    _textFontSize = textFontSize;
    self.inputTextView.font = [UIFont systemFontOfSize:textFontSize];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.inputTextView.frame = self.bounds;
    self.placeHolderTextView.frame = self.bounds;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpView];
        [self fillData];
        [self setDefaultValue];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setUpView];
        [self fillData];
        [self setDefaultValue];
    }
    return self;
}

- (void)setUpView
{
    [self addSubview:self.placeHolderTextView];
    [self addSubview:self.inputTextView];
}

- (void)fillData
{
    self.placeHolderTextView.text = self.m_placeHolder;
    self.inputTextView.text = self.m_text;
}

- (void)setDefaultValue
{
    [self setPFontSize:17];
    [self setTextFontSize:17];
}

#pragma mark - textViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeHolderTextView.text = @"";
}

- (void)textViewDidChange:(UITextView *)textView
{
    if([textView.text isEqualToString:@""])
    {
        self.placeHolderTextView.text = self.m_placeHolder;
    }
}

@end
