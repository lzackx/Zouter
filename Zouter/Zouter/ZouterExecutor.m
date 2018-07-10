//
//  ZouterExecutor.m
//  Zouter
//
//  Created by lzackx on 2018/7/9.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "ZouterExecutor.h"

@interface ZouterExecutor ()

@property (nonatomic, readwrite, strong) NSOperationQueue *operationQueue;

@end

@implementation ZouterExecutor

static NSMutableDictionary *objects = nil;

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue setName:@"com.zouter.operation"];
        [queue setMaxConcurrentOperationCount:1];
        _operationQueue = queue;
        objects = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)executeCommand:(ZouterCommand *)command completion:(void(^)(void))completion  {
    
    NSOperation *operation = nil;
    if ([command.identifier integerValue] >= 0) {
        operation = [ZouterExecutor instanceOperationForCommand:command];
    } else {
        operation = [ZouterExecutor classOperationForCommand:command];
    }
    if (operation) {
        if (completion) {
            // if command is going to call instance method, the instance should release itself
            if ([command.identifier integerValue] >= 0) {
                void (^instanceCompletion)(void) = ^() {
                    if (completion) {
                        completion();
                    }
                    if ([objects objectForKey:command.identifier]) {
                        [objects removeObjectForKey:command.identifier];
                    }
                };
                [operation setCompletionBlock:instanceCompletion];
            } else {
                [operation setCompletionBlock:completion];
            }
        }
        [self.operationQueue addOperation:operation];
    }
}

// MARK: Perform Class Method
+ (NSOperation *)classOperationForCommand:(ZouterCommand *)command {
    
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        Class cls = NSClassFromString(command.className);
        SEL selector = NSSelectorFromString(command.methodName);
        if ([cls respondsToSelector:selector]) {
            IMP imp = [cls methodForSelector:selector];
            void (*classMethod)(id, SEL, id) = (void *)imp;
            classMethod(cls, selector, command.methodParameters);
        }
    }];
    return operation;
}

// MARK: Perform Instance Method
+ (NSOperation *)instanceOperationForCommand:(ZouterCommand *)command {
    
    Class cls = NSClassFromString(command.className);
    SEL selector = NSSelectorFromString(command.methodName);
    NSMethodSignature *methodSignature = [cls instanceMethodSignatureForSelector:selector];
    if (![cls instancesRespondToSelector:selector] || methodSignature == nil) {
        return nil;
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    // init a new instance and retain it until the end of operation
    NSObject *object = [NSClassFromString(command.className) new];
    [objects setObject:object forKey:command.identifier];
    // set the invocation
    [invocation setTarget: object];
    [invocation setSelector:NSSelectorFromString(command.methodName)];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    for (NSString *key in command.methodParameters.keyEnumerator) {
        NSNumber *index = [formatter numberFromString:key];
        if (index == nil || [index integerValue] <= 1) {
            continue;
        }
        NSObject *argument = [command.methodParameters objectForKey:key];
        [invocation setArgument:&argument atIndex:[index integerValue]];
    }
    NSOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:invocation];
    return operation;
}

@end
