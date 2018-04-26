//
//  AspectMananer.m
//  AopTestDemo
//
//  Created by ChenMan on 2018/4/26.
//  Copyright © 2018年 cimain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AspectMananer.h"
#import <objc/runtime.h>
#import <objc/objc.h>
#import <Aspects/Aspects.h>

#import "Test3ViewController.h"
#import "Test4ViewController.h"


@implementation AspectMananer

+(void)trackAspectHooks{
    
    [AspectMananer trackViewAppear];
    [AspectMananer trackBttonEvent];
}


#pragma mark -- 监控统计用户进入此界面的时长，频率等信息
+ (void)trackViewAppear{
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> info){
                                   
                                   //用户统计代码写在此处
                                   DDLogDebug(@"[打点统计]:%@ viewWillAppear",NSStringFromClass([info.instance class]));
//                                   NSString *className = NSStringFromClass([info.instance class]);
//                                   DDLogDebug(@"className-->%@",className);
//                                   [MobClick beginLogPageView:className];//(className为页面名称
                                   
                               }
                                    error:NULL];
    
    
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> info){
                                   
                                   //用户统计代码写在此处
                                   DDLogDebug(@"[打点统计]:%@ viewWillDisappear",NSStringFromClass([info.instance class]));
//                                   NSString *className = NSStringFromClass([info.instance class]);
//                                   DDLogDebug(@"className-->%@",className);
//                                   [MobClick endLogPageView:className];
                                   
                               }
                                    error:NULL];
    
    //other hooks ... goes here
    //...
}

#pragma mark --- 监控button的点击事件
+ (void)trackBttonEvent{
    
    __weak typeof(self) ws = self;
    
    //设置事件统计
    //放到异步线程去执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //读取配置文件，获取需要统计的事件列表
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EventList" ofType:@"plist"];
        NSDictionary *eventStatisticsDict = [[NSDictionary alloc] initWithContentsOfFile:path];
        for (NSString *classNameString in eventStatisticsDict.allKeys) {
            //使用运行时创建类对象
            const char * className = [classNameString UTF8String];
            //从一个字串返回一个类
            Class newClass = objc_getClass(className);
            
            NSArray *pageEventList = [eventStatisticsDict objectForKey:classNameString];
            for (NSDictionary *eventDict in pageEventList) {
                //事件方法名称
                NSString *eventMethodName = eventDict[@"MethodName"];
                SEL seletor = NSSelectorFromString(eventMethodName);
                NSString *eventId = eventDict[@"EventId"];
                
                [ws trackEventWithClass:newClass selector:seletor eventID:eventId];
                [ws trackTableViewEventWithClass:newClass selector:seletor eventID:eventId];
                [ws trackParameterEventWithClass:newClass selector:seletor eventID:eventId];
            }
        }
    });
}



#pragma mark -- 1.监控button和tap点击事件(不带参数)
+ (void)trackEventWithClass:(Class)klass selector:(SEL)selector eventID:(NSString*)eventID{
    
    [klass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        
        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        NSLog(@"className--->%@",className);
        NSLog(@"event----->%@",eventID);
        if ([eventID isEqualToString:@"xxx"]) {
//            [EJServiceUserInfo isLogin]?[MobClick event:eventID]:[MobClick event:@"???"];
        }else{
//            [MobClick event:eventID];
        }
    } error:NULL];
}


#pragma mark -- 2.监控button和tap点击事件（带参数）
+ (void)trackParameterEventWithClass:(Class)klass selector:(SEL)selector eventID:(NSString*)eventID{
    
    [klass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,UIButton *button) {
        
        NSLog(@"button---->%@",button);
        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        NSLog(@"className--->%@",className);
        NSLog(@"event----->%@",eventID);
        
    } error:NULL];
}


#pragma mark -- 3.监控tableView的点击事件
+ (void)trackTableViewEventWithClass:(Class)klass selector:(SEL)selector eventID:(NSString*)eventID{
    
    [klass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,NSSet *touches, UIEvent *event) {
        
        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        NSLog(@"className--->%@",className);
        NSLog(@"event----->%@",eventID);
        NSLog(@"section---->%@",[event valueForKeyPath:@"section"]);
        NSLog(@"row---->%@",[event valueForKeyPath:@"row"]);
        NSInteger section = [[event valueForKeyPath:@"section"]integerValue];
        NSInteger row = [[event valueForKeyPath:@"row"]integerValue];
        
        //统计事件
        if (section == 0 && row == 1) {
//            [MobClick event:eventID];
        }
        
    } error:NULL];
}
@end
