//
//  TraceHandler.m
//  AopTestDemo
//
//  Created by ChenMan on 2018/4/25.
//  Copyright © 2018年 cimain. All rights reserved.
//

#import "TraceHandler.h"

@implementation TraceHandler

+ (void)statisticsWithEventName:(NSString *)eventName{
    NSLog(@"-----> %@",eventName);
}

@end
