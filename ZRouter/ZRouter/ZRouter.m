//
//  ZRouter.m
//  ZRouter
//
//  Created by lzackx on 2018/4/16.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "ZRouter.h"
#import <UIKit/UIKit.h>
#import <objc/objc.h>
#import <objc/runtime.h>
#import "ZRouterPrivate.h"

@implementation ZRouter

static const void *ZRouterIdentifier = "ZRouterIdentifier";

// MARK: Constructor
static id instance = nil;

+ (void)initializeWithScheme:(NSString *)scheme {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[ZRouter alloc] initWithScheme: scheme];
        }
    });
}

+ (instancetype)sharedInstance {
    
    @synchronized(self) {
        if (instance == nil) {
            NSDictionary *infoDictionary = [NSBundle mainBundle].infoDictionary;
            NSString *scheme = infoDictionary[@"CFBundleName"];
            if (scheme != nil || [scheme stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
                instance = [[ZRouter alloc] initWithScheme: [scheme lowercaseString]];
            } else {
                NSAssert(NO, @"ZRouter has not been initialized or CFBundleName has not been set as the default scheme of ZRouter");
            }
        }
    }
    return instance;
}

- (instancetype)initWithScheme:(NSString *)scheme {
    
    self = [super init];
    if (self) {
        _scheme = scheme;
        _classObjects = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    @synchronized(self) {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return instance;
}

// MARK: Open URL

- (NSDictionary *)parseQuery:(NSString *)query {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    for (NSString *parameter in [query componentsSeparatedByString:@"&"]) {
        NSArray *elements = [parameter componentsSeparatedByString:@"="];
        if ([elements count] < 2) {
            continue;
        }
        id key = [elements firstObject];
        id value = [elements lastObject];
        if (key && value) {
            [parameters setObject:value forKey:key];
        }
    }
    return parameters;
}

/// URL Format: scheme://class:ZRouterMode/method?keys=values
- (id)openURL:(NSURL *)url withRetainIdentifier:(NSString *)retainIdentifier completion:(void(^)(id))completion {
    
    id result = nil;
    // scheme
    NSString *scheme = [url.scheme lowercaseString];
    if (![self.scheme isEqualToString:scheme]) {
        return result;
    }
    
    // class & method
    NSString *className = url.host;
    NSString *methodName = url.lastPathComponent;
    if (![methodName hasPrefix:@"zr"]) {
        return result;
    }
    
    // query
    NSString *query = [url query];
    NSDictionary *parameters = [self parseQuery:query];
    
    // mode
    NSUInteger mode = [url.port unsignedIntegerValue];
    switch (mode) {
        case ZRouterClassMode:
            result = [self performClassMethodName:methodName ofClassName:className withParameters:parameters];
            break;
        case ZRouterInstanceMode:
            result = [self performInstanceMethodName:methodName ofClassName:className withParameters:parameters withRetainIdentifier:(NSString *)retainIdentifier];
            break;
        default:
            break;
    }
    
    if (completion) {
        completion(result);
    }
    return result;
}

/// URL Format: scheme://class:ZRouterMode/method?keys=values
- (id)openURL:(NSURL *)url withRetainIdentifier:(NSString *)retainIdentifier {
    return [self openURL:url withRetainIdentifier:retainIdentifier completion:nil];
}

/// URL Format: scheme://class:ZRouterMode/method?keys=values
- (id)openURL:(NSURL *)url completion:(void(^)(id))completion {
    return [self openURL:url withRetainIdentifier:nil completion:completion];
}

/// URL Format: scheme://class:ZRouterMode/method?keys=values
- (id)openURLString:(NSString *)urlString withRetainIdentifier:(NSString *)retainIdentifier completion:(void(^)(id))completion {
    NSURL *url = [NSURL URLWithString:urlString];
    return [self openURL:url withRetainIdentifier:retainIdentifier completion:completion];
}

/// URL Format: scheme://class:ZRouterMode/method?keys=values
- (id)openURLString:(NSString *)urlString withRetainIdentifier:(NSString *)retainIdentifier {
    return [self openURLString:urlString withRetainIdentifier:retainIdentifier completion:nil];
}

/// URL Format: scheme://class:ZRouterMode/method?keys=values
- (id)openURLString:(NSString *)urlString completion:(void(^)(id))completion {
    NSURL *url = [NSURL URLWithString:urlString];
    return [self openURL:url withRetainIdentifier:nil completion:completion];
}

// MARK: Perform
/// Class Method
- (id)performClassMethodName:(NSString *)methodName ofClassName:(NSString *)className withParameters:(NSDictionary *)parameters {
    
    id result = nil;
    Class cls = NSClassFromString(className);
    SEL selector = NSSelectorFromString(methodName);
    if (![cls respondsToSelector:selector]) {
        return nil;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([parameters count] > 0) {
        result = [cls performSelector:selector withObject:parameters];
    } else {
        result = [cls performSelector:selector];
    }
#pragma clang diagnostic pop
    
    return result;
}
/// Instance Method
- (id)performInstanceMethodName:(NSString *)methodName ofClassName:(NSString *)className withParameters:(NSDictionary *)parameters withRetainIdentifier:(NSString *)retainIdentifier {
    
    id result = nil;
    Class cls = NSClassFromString(className);
    NSObject *object = nil;
    NSString *identifier = nil;
    if (retainIdentifier) {
        NSData *encodingData = [[NSString stringWithFormat:@"%@:%@", className, retainIdentifier] dataUsingEncoding:NSUTF8StringEncoding];
        identifier = [encodingData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    }
    if (identifier) {
        object = self.classObjects[identifier];
    }
    if (object == nil) {
        object = [cls new];
    }
    SEL selector = NSSelectorFromString(methodName);
    if (![object respondsToSelector:selector]) {
        return nil;
    }
    if (identifier && self.classObjects[identifier] == nil) {
        [self.classObjects setObject:object forKey:identifier];
        objc_setAssociatedObject(object, ZRouterIdentifier, identifier, OBJC_ASSOCIATION_RETAIN);
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([parameters count] > 0) {
        result = [object performSelector:selector withObject:parameters];
    } else {
        result = [object performSelector:selector];
    }
#pragma clang diagnostic pop
    
    return result;
}

@end










