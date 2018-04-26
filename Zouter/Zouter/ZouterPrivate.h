//
//  ZouterPrivate.h
//  Zouter
//
//  Created by lzackx on 2018/4/16.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#ifndef ZouterManagerPrivate_h
#define ZouterManagerPrivate_h

@interface Zouter ()

@property (nonatomic, readonly, strong)NSString *scheme;
@property (nonatomic, strong)NSMutableDictionary *classObjects;

- (id)performClassMethodName:(NSString *)methodName ofClassName:(NSString *)className withParameters:(NSDictionary *)parameters;
- (id)performInstanceMethodName:(NSString *)methodName ofClassName:(NSString *)className withParameters:(NSDictionary *)parameters withRetainIdentifier:(NSString *)retainIdentifier;

@end

#endif /* ZouterPrivate_h */
