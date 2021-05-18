//
//  ZouterCommandLinkedNode.h
//  Zouter
//
//  Created by lzackx on 2021/5/17.
//

#import <Foundation/Foundation.h>
#import "ZouterCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZouterCommandLinkNode : NSObject

@property (nonatomic, readwrite, strong) ZouterCommand * _Nullable command;
@property (nonatomic, readwrite, strong) ZouterCommandLinkNode * _Nullable next;

@end

NS_ASSUME_NONNULL_END
