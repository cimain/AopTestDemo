//
//  UIViewController+Trace.m
//  AopTestDemo
//
//  Created by ChenMan on 2018/4/25.
//  Copyright © 2018年 cimain. All rights reserved.
//

#import "UIViewController+Trace.h"
#import "TraceHandler.h"
#import <objc/runtime.h>
#import <objc/objc.h>
#import "Aspects.h"


@implementation UIViewController (Trace)

#pragma mark - 1.自定义实现方法
//+ (void)load{
//    swizzleMethod([self class], @selector(viewDidAppear:), @selector(swizzled_viewDidAppear:));
//}
//
//- (void)swizzled_viewDidAppear:(BOOL)animated{
//    // call original implementation
//    [self swizzled_viewDidAppear:animated];
//    // Begin statistics Event
//    [statistics statisticsWithEventName:@"UIViewController"];
//}
//
//void swizzleMethod(Class class,SEL originalSelector,SEL swizzledSelector){
//    // the method might not exist in the class, but in its superclass
//    Method originalMethod = class_getInstanceMethod(class, originalSelector);
//    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//
//    // class_addMethod will fail if original method already exists
//    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//
//    // the method doesn’t exist and we just added one
//    if (didAddMethod) {
//        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//    }
//    else {
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
//}

#pragma mark - 2.使用Aspects框架
+ (void)load{
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo>aspectInfo){
                                   NSString *className = NSStringFromClass([[aspectInfo instance] class]);;
                                   [TraceHandler statisticsWithEventName:className];
                               } error:nil];
}

@end
