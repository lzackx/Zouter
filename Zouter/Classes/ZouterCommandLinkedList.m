//
//  ZouterCommandLinkedList.m
//  Zouter
//
//  Created by lzackx on 2021/5/17.
//

#import "ZouterCommandLinkedList.h"

@interface ZouterCommandLinkedList ()

@property (nonatomic, readwrite, strong) ZouterCommandLinkNode *headNode;

@end

@implementation ZouterCommandLinkedList

- (BOOL)isEmpty {
	return self.headNode == nil;
}

- (NSInteger)length {
	ZouterCommandLinkNode *currentNode = self.headNode;
	NSInteger count = 0;
	while (currentNode) {
		count++;
		currentNode = currentNode.next;
	}
	return count;
}

- (void)enumberateWithBlock:(BOOL(^)(ZouterCommandLinkNode *node))block {
	if ([self isEmpty]) return;
	ZouterCommandLinkNode *currentNode = self.headNode;
	while (currentNode) {
		if (block) {
			NSLog(@"%@",currentNode.command.pattern);
			BOOL shouldStop = block(currentNode);
			if (shouldStop) {
				break;
			}
		}
		currentNode = currentNode.next;
	}
}

- (NSInteger)indexOf:(ZouterCommand *)command {
	NSInteger index = 0;
	ZouterCommandLinkNode *current = self.headNode;
	while (current) {
		if (current.command == command) {
			return index;
		}
		else {
			current = current.next;
			index++;
		}
	}
	
	return NSNotFound;
}

- (void)insertNode:(ZouterCommandLinkNode *)node {
	// 0
	if (self.headNode == nil) {
		self.headNode = node;
		return;
	}
	// == 1
	if (self.headNode.command.priority <= node.command.priority) {
		node.next = self.headNode;
		self.headNode = node;
		return;
	}
	// > 1
	ZouterCommandLinkNode *currentNode = self.headNode;
	while (currentNode.next) {
		if (currentNode.next.command.priority <= node.command.priority) {
				break;
		}
		currentNode = currentNode.next;
	}
	node.next = currentNode.next;
	currentNode.next = node;
}

@end
