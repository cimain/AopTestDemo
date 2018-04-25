//
//  AppDelegate+Trace.m
//  AopTestDemo
//
//  Created by ChenMan on 2018/4/25.
//  Copyright © 2018年 cimain. All rights reserved.
//

#import "AppDelegate+Trace.h"
#import "TraceManager.h"

@implementation AppDelegate (Trace)

+ (void)setupLogging{
    NSDictionary *configDic = @{
                                @"ViewController":@{
                                        @"des":@"show ViewController",
                                        },
                                @"Test1ViewController":@{
                                        @"des":@"show Test1ViewController",
                                        @"TrackEvents":@[@{
                                                             @"EventDes":@"click action1",
                                                             @"EventSelectorName":@"action1",
                                                             @"block":^(id<AspectInfo>aspectInfo){
                                                                 NSLog(@"统计 Test1ViewController action1 点击事件");
                                                             },
                                                             },
                                                         @{
                                                             @"EventDes":@"click action2",
                                                             @"EventSelectorName":@"action2",
                                                             @"block":^(id<AspectInfo>aspectInfo){
                                                                 NSLog(@"统计 Test1ViewController action2 点击事件");
                                                             },
                                                             }],
                                        },
                                @"Test2ViewController":@{
                                        @"des":@"show Test2ViewController",
                                        }
                                };
    
    [TraceManager setUpWithConfig:configDic];
}

@end
