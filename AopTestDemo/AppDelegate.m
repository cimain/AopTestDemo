//
//  AppDelegate.m
//  AopTestDemo
//
//  Created by ChenMan on 2018/4/25.
//  Copyright © 2018年 cimain. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Trace.h"
#import "AspectMananer.h"

#import <CocoaLumberjack/CocoaLumberjack.h>
#import <CocoaLumberjack.h>

#import "Test1ViewController.h"


#define testFlag 2

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    UINavigationController *nvi = [[UINavigationController alloc]initWithRootViewController:[Test1ViewController new]];
    self.window.rootViewController = nvi;
    
    [self loadForDDLog];
    
#if testFlag==0
//method swizzle && AOP with one selector
//放开UIViewController+Trace.m的注释
    
#elif testFlag==1
//AOP with Dict
//放开AppDelegate+Trace.m的注释
    [AppDelegate setupLogging];
    
#elif testFlag==2
// AOP with Plist
    [AspectMananer trackAspectHooks];
#endif
    return YES;
}

- (void)loadForDDLog{
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
//    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];// 启用颜色区分
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogLevelDebug];// 可以修改你想要的颜色
    
//    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
//    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
//    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
//    [DDLog addLogger:fileLogger];
    
//    DDLogError(@"错误信息"); // 红色
//    DDLogWarn(@"警告%@",@"asd"); // 橙色
//    DDLogInfo(@"提示信息:%@",@"嘎嘎"); // 默认是黑色
//    DDLogVerbose(@"详细信息error:%d",1016); // 默认是黑色
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
