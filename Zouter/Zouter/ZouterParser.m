//
//  ZouterParser.m
//  Zouter
//
//  Created by lzackx on 2018/7/9.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "ZouterParser.h"

@implementation ZouterParser

- (instancetype)init {
    
    self = [super init];
    if (self) {
    }
    return self;
}
//  MARK:  Parse
//! Sample: zouter://classname:identifier/methodname?methodparameters
- (ZouterCommand *)parseCommand:(NSURL *)command {
    
    NSString *className = command.host;
    if (!className || className.length <= 0) {
        return nil;
    }
    NSNumber *identifier = command.port;
    if (!identifier || identifier < 0) {
        identifier = @-1;
    }
    NSString *methodName = command.lastPathComponent;
    if (!methodName || methodName.length <= 0 || [methodName isEqualToString:@"/"]) {
        return nil;
    }
    NSDictionary *parameters = [self parseQuery:[command query]];
    
    return [[ZouterCommand alloc] initWithClassName:className
                                         identifier:identifier
                                         methodName:methodName
                                   methodParameters:parameters];
}

- (NSDictionary *)parseQuery:(NSString *)query {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    for (NSString *parameter in [query componentsSeparatedByString:@"&"]) {
        NSArray<NSString *> *elements = [parameter componentsSeparatedByString:@"="];
        if ([elements count] < 2) {
            continue;
        }
        NSString *key = [elements firstObject];
        NSObject *value = [elements lastObject];
        if (key && value) {
            [parameters setObject:value forKey:key];
        }
    }
    return parameters;
}

@end










