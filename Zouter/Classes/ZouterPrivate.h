//
//  ZouterPrivate.h
//  Zouter
//
//  Created by lzackx on 2018/4/16.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#ifndef ZouterManagerPrivate_h
#define ZouterManagerPrivate_h

#import "ZouterParser.h"
#import "ZouterExecutor.h"
#import "ZouterCommand.h"
#import "ZouterCommandLinkedList.h"

@interface Zouter ()

@property (nonatomic, readonly, copy) NSString *scheme;
@property (nonatomic, readwrite, strong) ZouterParser *parser;
@property (nonatomic, readwrite, strong) ZouterExecutor *executor;
@property (nonatomic, readwrite, strong) ZouterCommandLinkedList *routers;

@end

#endif /* ZouterPrivate_h */
