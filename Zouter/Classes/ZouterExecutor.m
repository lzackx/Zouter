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

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue setName:@"com.lzackx.zouter.operation"];
        [queue setMaxConcurrentOperationCount:1];
        _operationQueue = queue;
    }
    return self;
}

- (void)executeCommand:(ZouterCommand *)command {
	
	NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
		[command run];
	}];
	if (command.synchronizly) {
		[operation start];
	} else {
		[self.operationQueue addOperation:operation];
	}
}

@end
