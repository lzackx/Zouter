//
//  ZouterParser.m
//  Zouter
//
//  Created by lzackx on 2018/7/9.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "ZouterParser.h"
#import "ZouterCommandLinkedList.h"

@implementation ZouterParser

//  MARK:  Parse
- (void)parseURL:(NSURL *)url
     fromRouters:(ZouterCommandLinkedList *)routers
completedCallback:(ZouterCommandCompledCallback _Nullable)completedCallback {
	__block ZouterCommand *command = nil;	
	[routers enumberateWithBlock:^(ZouterCommandLinkNode * _Nonnull node) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", node.command.pattern];
		if ([predicate evaluateWithObject:url.absoluteString]) {
			command = node.command;
			return YES;
		}
		return NO;
	}];
	if (command == nil) {
#ifdef DEBUG
		NSLog(@"[ZouterParser]: %@ not matched", url);
#endif
		return;
	}
    if (self.delegate && [self.delegate respondsToSelector:@selector(parser:command:parameters:completedCallback:)]) {
#ifdef DEBUG
		NSLog(@"[ZouterParser]: <%@> => <%@> ", url, command.taURL);
#endif
		NSDictionary *query = [self parseQueryWithURL:url];
		[self.delegate
         parser:self
         command:command
         parameters:query
         completedCallback:completedCallback];
	}
}

- (NSDictionary *)parseQueryWithURL:(NSURL *)url {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
	for (NSURLQueryItem *qi in urlComponents.queryItems) {
		[parameters setObject:qi.value forKey:qi.name];
	}
    return parameters;
}

@end










