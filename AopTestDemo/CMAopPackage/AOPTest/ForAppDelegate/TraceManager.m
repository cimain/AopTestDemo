//
//  TraceManager.m
//  AopTestDemo
//
//  Created by ChenMan on 2018/4/25.
//  Copyright © 2018年 cimain. All rights reserved.
//

#import "TraceManager.h"

@import UIKit;

typedef void (^AspectHandlerBlock)(id<AspectInfo> aspectInfo);

@implementation TraceManager

+ (void)setUpWithConfig:(NSDictionary *)configDic{
    // hook 所有页面的viewDidAppear事件
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo){
                                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                       NSString *className = NSStringFromClass([[aspectInfo instance] class]);
                                       NSString *des = configDic[className][@"des"];
                                       if (des) {
                                           NSLog(@"%@",des);
                                       }
                                   });
                               } error:NULL];
    
    for (NSString *className in configDic) {
        Class clazz = NSClassFromString(className);
        NSDictionary *config = configDic[className];
        
        if (config[@"TrackEvents"]) {
            for (NSDictionary *event in config[@"TrackEvents"]) {
                SEL selekor = NSSelectorFromString(event[@"EventSelectorName"]);
                AspectHandlerBlock block = event[@"block"];
                
                [clazz aspect_hookSelector:selekor
                               withOptions:AspectPositionAfter
                                usingBlock:^(id<AspectInfo> aspectInfo){
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                        block(aspectInfo);
                                    });
                                }error:NULL];
            }
        }
    }
}

@end
