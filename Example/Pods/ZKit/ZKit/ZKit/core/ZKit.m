//
//  ZKit.m
//  ZKit
//
//  Created by lzackx on 2018/7/2.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "ZKit.h"
#import "ZKitPrivate.h"


@implementation ZKit

// MARK: Singleton
static id z = nil;
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (z == nil) {
            z = [ZKit new];
        }
    });
}
+ (instancetype)sharedZ {
    
    @synchronized(self) {
        if (z == nil) {
            z = [ZKit new];
        }
    }
    return z;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    @synchronized(self) {
        if (z == nil) {
            z = [super allocWithZone:zone];
            return z;
        }
    }
    return z;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _configurations = [NSMutableDictionary dictionary];
    }
    return self;
}

// MARK: Configurations
- (id)configurationValueForKey:(NSString *)key {
    id value = [self.configurations valueForKey:key];
    if (self.configurations[key]) {
        return value;
    }
    return [NSNull null];
}

- (void)setConfigurationValue:(id)value forKey:(NSString *)key {
    [self.configurations setValue:value forKey:key];
}

@end










