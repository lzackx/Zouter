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

static const void *ZouterIdentifier = "ZouterIdentifier";

// MARK: Constructor
static id instance = nil;

+ (void)initializeWithScheme:(NSString *)scheme {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[Zouter alloc] initWithScheme: scheme];
        }
    });
}

+ (instancetype)sharedInstance {
    
    @synchronized(self) {
        if (instance == nil) {
            NSDictionary *infoDictionary = [NSBundle mainBundle].infoDictionary;
            NSString *scheme = infoDictionary[@"CFBundleName"];
            if (scheme != nil || [scheme stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
                instance = [[Zouter alloc] initWithScheme: [scheme lowercaseString]];
            } else {
                NSAssert(NO, @"Zouter has not been initialized or CFBundleName has not been set as the default scheme of Zouter");
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

/// URL Format: scheme://class:ZouterMode/method?keys=values
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
        case ZouterClassMode:
            result = [self performClassMethodName:methodName ofClassName:className withParameters:parameters];
            break;
        case ZouterInstanceMode:
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

/// URL Format: scheme://class:ZouterMode/method?keys=values
- (id)openURL:(NSURL *)url withRetainIdentifier:(NSString *)retainIdentifier {
    return [self openURL:url withRetainIdentifier:retainIdentifier completion:nil];
}

/// URL Format: scheme://class:ZouterMode/method?keys=values
- (id)openURL:(NSURL *)url completion:(void(^)(id))completion {
    return [self openURL:url withRetainIdentifier:nil completion:completion];
}

/// URL Format: scheme://class:ZouterMode/method?keys=values
- (id)openURLString:(NSString *)urlString withRetainIdentifier:(NSString *)retainIdentifier completion:(void(^)(id))completion {
    NSURL *url = [NSURL URLWithString:urlString];
    return [self openURL:url withRetainIdentifier:retainIdentifier completion:completion];
}

/// URL Format: scheme://class:ZouterMode/method?keys=values
- (id)openURLString:(NSString *)urlString withRetainIdentifier:(NSString *)retainIdentifier {
    return [self openURLString:urlString withRetainIdentifier:retainIdentifier completion:nil];
}

/// URL Format: scheme://class:ZouterMode/method?keys=values
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
        identifier = [self identifierOfClassName:className retainIdentifier:retainIdentifier];
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
        objc_setAssociatedObject(object, ZouterIdentifier, identifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

- (NSString *)identifierOfClassName:(NSString *)className retainIdentifier:(NSString *)retainIdentifier {
    
    NSData *encodingData = [[NSString stringWithFormat:@"%@:%@", className, retainIdentifier] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *identifier = [encodingData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    return identifier;
}

- (void)releaseObjectOfClassName:(NSString *)className retainIdentifier:(NSString *)retainIdentifier {
    
    NSString *identifier = [self identifierOfClassName:className retainIdentifier:retainIdentifier];
    [self.classObjects removeObjectForKey:identifier];
}

@end










