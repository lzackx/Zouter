//
//  ViewController+Zouter.m
//  ZouterDemo
//
//  Created by lzackx on 2018/4/25.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "ViewController+Zouter.h"

@implementation ViewController (Zouter)

+ (NSNumber *)zrTestZouterClasseMethodWithParameters:(NSDictionary *)parameters {
    
    NSNumber *hasParameters = @NO;
    if ([parameters count] > 0) {
        hasParameters = @YES;
        NSLog(@"%@", parameters);
    } else {
        NSLog(@"No parameters");
    }
    
    return hasParameters;
}

- (NSNumber *)zrTestZouterInstanceMethodWithParameters:(NSDictionary *)parameters {
    
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
