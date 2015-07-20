//
//  AppDelegate.m
//  MALHelp
//
//  Created by wangtian on 15-3-5.
//  Copyright (c) 2015年 wangtian. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "UIViewController+MALNavigation.h"
#import "NSString+MALNSString.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self doSomethingForTest];
    [self setUpMainViewController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setUpMainViewController
{
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    //[UIViewController setNavigationBarBgImage:na andBgImage:[[UIImage imageNamed:@"About"] resizableImageWithCapInsets:UIEdgeInsetsMake(40, 0, 0, 0)]];
    [UIViewController setBackItemTextColor:na itemColor:[UIColor redColor]];
    self.window.rootViewController = na;
}

#pragma mark - 做一些测试
- (void)doSomethingForTest
{
    //注：dispatch_after 是在一定时间后将任务提交给主线程，但是不一定是立即执行的
    MGCDAfter(2.0f, ^{
    
        Log(@"dispatch_after 延时提交任务测试");
    });
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
