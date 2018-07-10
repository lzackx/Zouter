//
//  ViewController+Zouter.m
//  ZouterDemo
//
//  Created by lzackx on 2018/4/25.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "ViewController+Zouter.h"

@implementation ViewController (Zouter)

+ (void)zrTestZouterClasseMethodWithParameters:(NSDictionary *)parameters {
    
    NSNumber *hasParameters = @NO;
    if ([parameters count] > 0) {
        hasParameters = @YES;
        NSLog(@"%@", parameters);
    } else {
        NSLog(@"No parameters");
    }
}

- (void)zrTestZouterInstanceMethodWithParameters:(NSString *)parameter {
    
    if (parameter) {
        NSLog(@"%@", parameter);
    } else {
        NSLog(@"No parameters");
    }
}

@end
