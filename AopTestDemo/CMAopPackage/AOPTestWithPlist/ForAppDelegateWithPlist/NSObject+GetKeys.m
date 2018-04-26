//
//  NSObject+GetKeys.m
//  iOSSwizzlingDemo
//
//  Created by zhuchenglong on 2016/12/3.
//  Copyright © 2016年 Weng-Zilin. All rights reserved.
//

#import "NSObject+GetKeys.h"
#import <objc/runtime.h>
@implementation NSObject (GetKeys)
/* 获取对象的所有属性和属性内容 */
-(NSDictionary *)getAllPropertiesAndVaules{
    NSMutableDictionary *propsDic = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    for ( int i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {
            [propsDic setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return propsDic;
}
@end
