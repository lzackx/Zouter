//
//  ViewController+ZRouter.m
//  ZRouterDemo
//
//  Created by lzackx on 2018/4/25.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "ViewController+ZRouter.h"

@implementation ViewController (ZRouter)

+ (NSNumber *)zrTestZRouterClasseMethodWithParameters:(NSDictionary *)parameters {
    
    NSNumber *hasParameters = @NO;
    if ([parameters count] > 0) {
        hasParameters = @YES;
        NSLog(@"%@", parameters);
    } else {
        NSLog(@"No parameters");
    }
    
    return hasParameters;
}

- (NSNumber *)zrTestZRouterInstanceMethodWithParameters:(NSDictionary *)parameters {
    
    NSNumber *hasParameters = @NO;
    if ([parameters count] > 0) {
        hasParameters = @YES;
        NSLog(@"%@", parameters);
    } else {
        NSLog(@"No parameters");
    }
    
    return hasParameters;
}

@end
