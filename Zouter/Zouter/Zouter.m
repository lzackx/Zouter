//
//  Zouter.m
//  Zouter
//
//  Created by lzackx on 2018/4/16.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "Zouter.h"
#import <UIKit/UIKit.h>
#import <objc/objc.h>
#import <objc/runtime.h>
#import "ZouterPrivate.h"

@implementation Zouter

// MARK: Constructor
static id zouter = nil;

+ (void)initializeWithScheme:(NSString *)scheme {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (zouter == nil) {
            zouter = [[Zouter alloc] initWithScheme: scheme];
        }
    });
}

+ (instancetype)sharedRouter {
    
    @synchronized(self) {
        if (zouter == nil) {
            NSDictionary *infoDictionary = [NSBundle mainBundle].infoDictionary;
            NSString *scheme = infoDictionary[@"CFBundleName"];
            if (scheme != nil || [scheme stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
                zouter = [[Zouter alloc] initWithScheme: [scheme lowercaseString]];
            } else {
                NSAssert(NO, @"Zouter has not been initialized or CFBundleName has not been set as the default scheme of Zouter");
            }
        }
    }
    return zouter;
}

- (instancetype)initWithScheme:(NSString *)scheme {
    
    self = [super init];
    if (self) {
        _scheme = scheme;
        _parser = [[ZouterParser alloc] init];
        _executor = [[ZouterExecutor alloc] init];
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    @synchronized(self) {
        if (zouter == nil) {
            zouter = [super allocWithZone:zone];
            return zouter;
        }
    }
    return zouter;
}

// MARK: Open URL
- (void)openURL:(NSURL *)url completion:(void(^)(void))completion {
    [self openInSync:NO withURL:url completion:completion];
}

- (void)openURLString:(NSString * _Nonnull)urlString completion:(void(^)(void))completion {
    [self openInSync:NO withURLString:urlString completion:completion];
}

- (void)openInSync:(BOOL)sync withURL:(NSURL * _Nonnull)url completion:(void(^)(void))completion {
    
    // scheme
    NSString *scheme = [url.scheme lowercaseString];
    if (![self.scheme isEqualToString:scheme]) {
        return;
    }
    ZouterCommand *command = [self.parser parseCommand:url];
    [self.executor executeInSync:sync withCommand:command completion:completion];
}

- (void)openInSync:(BOOL)sync withURLString:(NSString * _Nonnull)urlString completion:(void(^)(void))completion  {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    if (!url) {
        NSLog(@"[Zouter %@]: Invalid URL => %@", self.scheme, urlString);
        return;
    }
    [self openInSync:(BOOL)sync withURL:url completion:completion];
}

@end










