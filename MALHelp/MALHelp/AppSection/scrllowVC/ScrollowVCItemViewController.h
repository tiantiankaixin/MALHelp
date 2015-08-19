//
//  ScrollowVCItemViewController.h
//  MALHelp
//
//  Created by wangtian on 15/5/11.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollowVCItemViewController : UIViewController

@property (nonatomic, copy) NSString *vcTitle;

- (void)vcDidShow;

- (void)vcDidHidden;


@end
