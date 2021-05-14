//
//  ZouterCommand.m
//  Zouter
//
//  Created by lzackx on 2018/7/9.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "ZouterCommand.h"
#import <CTMediator/CTMediator.h>

@implementation ZouterCommand

- (void)run {
	NSURL *url = [NSURL URLWithString:self.taURL];
	if (url == nil) {
		return;
	}
	if (self.willExcute) {
		self.willExcute();
	}
	typeof(self) wSelf = self;
	[[CTMediator sharedInstance] performActionWithUrl:url completion:^(NSDictionary * _Nullable info) {
		if (wSelf.didExcute) {
			wSelf.didExcute();
		}
	}];
}

@end
