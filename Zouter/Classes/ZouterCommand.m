//
//  ZouterCommand.m
//  Zouter
//
//  Created by lzackx on 2018/7/9.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "ZouterCommand.h"
#import "ZMediator.h"

@implementation ZouterCommand

- (void)run {
	NSURL *url = [self wrappedTargetActionURL];
	if (url == nil) {
		return;
	}
	if (self.willExcute) {
		self.willExcute(self);
	}
	typeof(self) wSelf = self;
	[[ZMediator sharedInstance] performActionWithUrl:url completion:^(NSDictionary * _Nullable info) {
		if (wSelf.didExcute) {
			wSelf.didExcute(self);
		}
	}];
}

// MARK: - Private Methods
- (NSURL *)wrappedTargetActionURL {
	NSURLComponents *urlComponents = [NSURLComponents componentsWithString:self.taURL];
	if (self.parameters != nil && [self.parameters count] > 0) {
		NSString *query = urlComponents.query;
		for (NSString *pk in self.parameters.allKeys) {
			if ([pk isEqualToString:kZMediatorParamsKeySwiftTargetModuleName]) {
				query = [self appendQuery:query withNewQuery:[self queryStringOfSwiftModuleName]];
			}
			else if ([pk isEqualToString:kZMediatorParamsKeyClassActionCalled]) {
				query = [self appendQuery:query withNewQuery:[self queryStringOfClassActionCalled]];
			}
		}
		urlComponents.query = query;
	}
	NSURL *url = [urlComponents URL];
	return url;
}

- (NSString *)appendQuery:(NSString *)query withNewQuery:(NSString *)newQuery {
	NSString *q = query;
	if (query.length > 0) {
		q = [NSString stringWithFormat:@"%@&%@", q, newQuery];
	} else {
		q = newQuery;
	}
	return q;
}

- (NSString *)queryStringOfSwiftModuleName {
	NSString *parameters = (NSString *)self.parameters[kZMediatorParamsKeySwiftTargetModuleName];
	NSString *queryString = [NSString stringWithFormat:@"%@=%@", kZMediatorParamsKeySwiftTargetModuleName, parameters];
	return queryString;
}

- (NSString *)queryStringOfClassActionCalled {
	NSNumber *parameters = (NSNumber *)self.parameters[kZMediatorParamsKeyClassActionCalled];
	NSString *queryString = [NSString stringWithFormat:@"%@=%@", kZMediatorParamsKeyClassActionCalled, parameters];
	return queryString;
}

@end
