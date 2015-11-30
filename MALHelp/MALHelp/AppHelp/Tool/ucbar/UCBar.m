//
//  UCBar.m
//  MALHelp
//
//  Created by wangtian on 15/11/17.
//  Copyright © 2015年 wangtian. All rights reserved.
//

#import "UCBar.h"
#import "BarItem.h"

@interface UCBar()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger onePageNO;//一页tab数目
@property (nonatomic, assign) CGFloat btnWidth;

@end

@implementation UCBar

- (UIScrollView *)contentScrollView
{
    if (_contentScrollView == nil)
    {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
    }
    return _contentScrollView;
}

- (NSMutableArray *)itemArray
{
    if (_itemArray == nil)
    {
        _itemArray = [[NSMutableArray alloc] init];
    }
    return _itemArray;
}

+  (UCBar *)barWithTitleArray:(NSArray *)titleArray btnWidth:(CGFloat)btnWidth frame:(CGRect)frame defaultSelectIndex:(NSInteger)selectIndex
{
    UCBar *bar = [[UCBar alloc] initWithFrame:frame];
    
    bar.onePageNO = SCREEN_WIDTH / btnWidth;
    bar.selectIndex = selectIndex;
    bar.btnWidth = btnWidth;
    [bar addItemWithTitleArray:titleArray btnWidth:btnWidth];
    
    return bar;
}

#pragma mark - 添加item
- (void)addItemWithTitleArray:(NSArray *)titleArray btnWidth:(CGFloat)btnWidth
{
    //先设置scrollView
    self.contentScrollView.frame = self.bounds;
    self.contentScrollView.contentSize = CGSizeMake(btnWidth * titleArray.count, 0);
    self.contentScrollView.delegate = self;
    [self addSubview:self.contentScrollView];
    
    //添加item
    [titleArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect itemFrame = CGRectMake(btnWidth * idx, 0, btnWidth, CGRectGetHeight(self.bounds));
        BarItem *item = [[BarItem alloc] initWithTitle:titleArray[idx] frame:itemFrame];
        item.tag = idx;
        [item addTarget:self action:@selector(itemClick:) forControlEvents:(UIControlEventTouchUpInside)];
        if (idx == self.selectIndex)//FIXME: 设置默认选中的item
        {
            [item selectItem];
        }
        [self.itemArray addObject:item];
        [self.contentScrollView addSubview:item];
    }];
}

#pragma mark - item被点击
- (void)itemClick:(BarItem *)item
{
    [self selectItemWithIndex:item.tag];
}

#pragma mark - 设置选中item
- (void)selectItemWithIndex:(NSInteger)index
{
    if (index == self.selectIndex)
    {
        return;
    }
    MSwipDirection swipDirection = mLeft;
    if (index < self.selectIndex)
    {
        swipDirection = mRight;
    }
    BarItem *fromItem = self.itemArray[self.selectIndex];
    BarItem *toItem = self.itemArray[index];
    [UIView animateWithDuration:0.5f animations:^{
        
        [fromItem changeItemWithProgress:0 swipDirection:swipDirection isFromItem:YES];
        [toItem changeItemWithProgress:1 swipDirection:swipDirection isFromItem:NO];
        
    } completion:^(BOOL finished) {
        
        if (finished)
        {
            [self updateContentoffSetWithFromIndex:self.selectIndex toIndex:index];
             self.selectIndex = index;
            if (self.selectIndexBlock)
            {
                self.selectIndexBlock(self.selectIndex);
            }
        }
    }];
}

- (void)updateViewFrameWithRatio:(CGFloat)ratio
{
    if (ratio > self.selectIndex)//往左边滑的
    {
        CGFloat changeProgress = ratio - self.selectIndex;
        BarItem *fromItem = self.itemArray[self.selectIndex];
        BarItem *toItem = self.itemArray[self.selectIndex + 1];
        [fromItem changeItemWithProgress:1 - changeProgress swipDirection:mLeft isFromItem:YES];
        [toItem changeItemWithProgress:changeProgress swipDirection:mLeft isFromItem:NO];
    }
    else
    {
        CGFloat changeProgress = self.selectIndex - ratio;
        BarItem *fromItem = self.itemArray[self.selectIndex];
        [fromItem changeItemWithProgress:1 - changeProgress swipDirection:mRight isFromItem:YES];
        if (changeProgress > 0.0)
        {
            BarItem *toItem = self.itemArray[self.selectIndex - 1];
            [toItem changeItemWithProgress:changeProgress swipDirection:mRight isFromItem:NO];
        }
    }
    NSInteger tempRatio = ratio;
    CGFloat ftempRatio = tempRatio;
    if (ftempRatio == ratio)
    {
        [self updateContentoffSetWithFromIndex:self.selectIndex toIndex:tempRatio];
        self.selectIndex = tempRatio;
    }
}

- (void)updateContentoffSetWithFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    NSInteger halfNumbers = self.onePageNO / 2;
    if (self.onePageNO % 2 != 0)
    {
        halfNumbers++;
    }
    NSInteger itemNumbers = self.itemArray.count;
    NSInteger leftItemNo = toIndex;//选中item左侧item数量
    NSInteger rightItemNo = itemNumbers - leftItemNo - 1;//右侧item数量
    CGFloat scrollViewMaxContentOffsetX = (self.itemArray.count - self.onePageNO) * self.btnWidth;//scrollView最大的contentOffsetx   最小是0
    if (fromIndex < toIndex)//向左滑动
    {
        if (leftItemNo >= halfNumbers)
        {
            CGFloat correctContentOffsetX = (toIndex - 2) * self.btnWidth;
            if (correctContentOffsetX > scrollViewMaxContentOffsetX)
            {
                correctContentOffsetX = scrollViewMaxContentOffsetX;
            }
            if (correctContentOffsetX <= scrollViewMaxContentOffsetX)
            {
                [self.contentScrollView setContentOffset:CGPointMake(correctContentOffsetX, 0) animated:YES];
            }
        }
    }
    else
    {
        if (rightItemNo >= halfNumbers)
        {
            CGFloat correctContentOffsetX = (toIndex - 2) * self.btnWidth;
            if(correctContentOffsetX < 0)
            {
                correctContentOffsetX = 0;
            }
            if (correctContentOffsetX >= 0)
            {
                  [self.contentScrollView setContentOffset:CGPointMake(correctContentOffsetX, 0) animated:YES];
            }
        }
    }
}

@end
