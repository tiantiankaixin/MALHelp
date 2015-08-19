//
//  ScrollowVCItemViewController.m
//  MALHelp
//
//  Created by wangtian on 15/5/11.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "ScrollowVCItemViewController.h"

@interface ScrollowVCItemViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ScrollowVCItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
    Log(@"%@ 加载了",self.vcTitle);
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"scrollowVCCell"];
    self.tableView.scrollsToTop = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scrollowVCCell"];
    
    cell.textLabel.text = self.vcTitle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//PS:vc  的view经过addSubView被加到别的视图中时 viewDidLoad viewWillAppear viewDidAppear均会被调用就相当与已经显示了   当vc的view从superView移除后 调用viewWillDisappear
- (void)viewWillAppear:(BOOL)animated
{
    Log(@"%@  viewWillAppear",self.vcTitle);
}

- (void)viewDidAppear:(BOOL)animated
{
    Log(@"%@  viewDidAppear",self.vcTitle);
}

- (void)viewWillDisappear:(BOOL)animated
{
    Log(@"%@  viewWillDisappear",self.vcTitle);
}

#pragma mark - vc要显示
- (void)vcDidShow
{
    self.tableView.scrollsToTop = YES;
}

- (void)vcDidHidden
{
    self.tableView.scrollsToTop = NO;
}

- (void)dealloc
{
    NSLog(@"%@ dealloc",self.vcTitle);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
