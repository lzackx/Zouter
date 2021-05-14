//
//  Zouter.m
//  Zouter
//
//  Created by lzackx on 2018/4/16.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "Zouter.h"
//#import <UIKit/UIKit.h>
//#import <objc/objc.h>
//#import <objc/runtime.h>
#import "ZouterPrivate.h"

@interface Zouter () <ZouterParserDelegate>

@end

@implementation Zouter

// MARK: - Constructor
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
        _scheme = [scheme lowercaseString];
        _parser = [[ZouterParser alloc] init];
		_parser.delegate = self;
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

// MARK: - Registration
- (void)registerWithPattern:(NSString *)pattern
			targetActionURL:(NSString *)targetActionURL
			   synchronizly:(BOOL)synchronizly
				 willExcute:(ZouterCommandCallback)willExcute
				  didExcute:(ZouterCommandCallback)didExcute {
	
	ZouterCommand *command = [ZouterCommand new];
	command.taURL = targetActionURL;
	command.synchronizly = synchronizly;
	command.willExcute = willExcute;
	command.didExcute = didExcute;
	[self.routers setObject:command forKey:pattern];
}

// MARK: - Perform URL
- (void)performURLString:(NSString * _Nullable)urlString {
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	if (!url) {
		NSLog(@"[Zouter %@]: Invalid URL => %@", self.scheme, urlString);
		return;
	}
	[self performURL:url];
}

- (void)performURL:(NSURL * _Nullable)url {
	if (!url) {
		NSLog(@"[Zouter %@]: Invalid URL => %@", self.scheme, url);
		return;
	}
	[self.parser parseURL:url fromRouters:[self.routers copy]];
}

// MARK: - ZouterParserDelegate
- (void)parser:(ZouterParser *)parser command:(ZouterCommand *)command {
	[self.executor executeCommand:command];
}

@end










