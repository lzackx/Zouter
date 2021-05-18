//
//  ZouterParser.h
//  Zouter
//
//  Created by lzackx on 2018/7/9.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZouterParserDelegate.h"

@class ZouterCommandLinkedList;

NS_ASSUME_NONNULL_BEGIN

@interface ZouterParser : NSObject

@property (nonatomic, readwrite, weak) id<ZouterParserDelegate> delegate;

- (void)parseURL:(NSURL *)url fromRouters:(ZouterCommandLinkedList *)routers;

@end

NS_ASSUME_NONNULL_END
