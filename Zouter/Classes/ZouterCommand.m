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
	[self runWithParameters:@{}];
}

- (void)runWithParameters:(NSDictionary *)parameters {
	NSURL *url = [self wrappedTargetActionURLWithParameters:parameters];
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
- (NSURL *)wrappedTargetActionURLWithParameters:(NSDictionary *)parameters {
	NSURLComponents *urlComponents = [NSURLComponents componentsWithString:self.taURL];
	NSMutableDictionary *queries = [NSMutableDictionary dictionary];
	[queries addEntriesFromDictionary:self.parameters];
	[queries addEntriesFromDictionary:parameters];
	NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray array];
	if (queries != nil && [queries.allKeys count] > 0) {
		for (NSString *qk in queries.allKeys) {
			NSURLQueryItem *qi = [NSURLQueryItem queryItemWithName:qk
															 value:[NSString stringWithFormat:@"%@", queries[qk]]];
			[queryItems addObject:qi];
		}
		urlComponents.queryItems = queryItems;
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
