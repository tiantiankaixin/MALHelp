//
//  MALTextView.h
//  MALPlaceholderTextView
//
//  Created by wangtian on 15/7/21.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface MALTextView : UIView

@property (nonatomic, copy) IBInspectable NSString *m_placeHolder;
@property (nonatomic, copy) IBInspectable NSString *m_text;
@property (nonatomic, assign) IBInspectable CGFloat pFontSize;
@property (nonatomic, assign) IBInspectable CGFloat textFontSize;
@property (nonatomic, strong) UIColor *placeHolderColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UITextView *inputTextView;

@end
