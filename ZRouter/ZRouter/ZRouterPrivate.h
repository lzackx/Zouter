//
//  ZRouterPrivate.h
//  ZRouter
//
//  Created by lzackx on 2018/4/16.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#ifndef ZRouterManagerPrivate_h
#define ZRouterManagerPrivate_h

@interface ZRouter ()

@property (nonatomic, readonly, strong)NSString *scheme;
@property (nonatomic, strong)NSMutableDictionary *classObjects;

- (id)performClassMethodName:(NSString *)methodName ofClassName:(NSString *)className withParameters:(NSDictionary *)parameters;
- (id)performInstanceMethodName:(NSString *)methodName ofClassName:(NSString *)className withParameters:(NSDictionary *)parameters withRetainIdentifier:(NSString *)retainIdentifier;

@end

#endif /* ZRouterPrivate_h */
