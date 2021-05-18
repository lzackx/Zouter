//
//  ZouterCommandLinkedList.h
//  Zouter
//
//  Created by lzackx on 2021/5/17.
//

#import <Foundation/Foundation.h>
#import "ZouterCommandLinkedNode.h"

NS_ASSUME_NONNULL_BEGIN


@interface ZouterCommandLinkedList : NSObject

- (BOOL)isEmpty;
- (NSInteger)length;
- (void)enumberateWithBlock:(BOOL(^ __nullable )(ZouterCommandLinkNode *node))block;
- (NSInteger)indexOf:(ZouterCommand *)command;
- (void)insertNode:(ZouterCommandLinkNode *)node;

@end


NS_ASSUME_NONNULL_END
