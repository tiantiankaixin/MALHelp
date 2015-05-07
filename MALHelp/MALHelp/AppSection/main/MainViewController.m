//
//  MainViewController.m
//  MALHelp
//
//  Created by wangtian on 15-3-6.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "MainViewController.h"
#import "RuntimeViewController.h"
#import "ProgressViewController.h"
#import "BlurViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *vcArray;

@end

@implementation MainViewController

- (NSMutableArray *)vcArray
{
    if (_vcArray == nil) {
        
        _vcArray = [[NSMutableArray alloc] init];
    }
    return _vcArray;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MainViewController";
    [self configueDataSource];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mainCell"];
}

#pragma mark - 配置数据
- (void)configueDataSource
{
    [self addARowWithTitle:@"runTime demo" andClass:[RuntimeViewController class]];
    [self addARowWithTitle:@"自定义进度条" andClass:[ProgressViewController class]];
    [self addARowWithTitle:@"模糊效果" andClass:[BlurViewController class]];
}

- (void)addARowWithTitle:(NSString *)title andClass:(Class)class
{
    [self.dataSource addObject:title];
    [self.vcArray addObject:class];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell"];
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetBackItem;
    [self.navigationController pushViewController:[[self.vcArray[indexPath.row] alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
