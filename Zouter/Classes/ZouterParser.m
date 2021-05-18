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
- (void)parseURL:(NSURL *)url fromRouters:(ZouterCommandLinkedList *)routers; {
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
	if (self.delegate && [self.delegate respondsToSelector:@selector(parser:command:)]) {
#ifdef DEBUG
		NSLog(@"[ZouterParser]: <%@> => <%@> ", url, command.taURL);
#endif
		[self.delegate parser:self command:command];
	}
}

//- (NSDictionary *)parseQuery:(NSString *)query {
//
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    for (NSString *parameter in [query componentsSeparatedByString:@"&"]) {
//        NSArray<NSString *> *elements = [parameter componentsSeparatedByString:@"="];
//        if ([elements count] < 2) {
//            continue;
//        }
//        NSString *key = [elements firstObject];
//        NSObject *value = [elements lastObject];
//        if (key && value) {
//            [parameters setObject:value forKey:key];
//        }
//    }
//    return parameters;
//}

@end










