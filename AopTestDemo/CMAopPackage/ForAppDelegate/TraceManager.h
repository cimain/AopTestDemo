//
//  TraceManager.h
//  AopTestDemo
//
//  Created by ChenMan on 2018/4/25.
//  Copyright © 2018年 cimain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Aspects.h"

@interface TraceManager : NSObject

+ (void)setUpWithConfig:(NSDictionary *)configDic;

@end
