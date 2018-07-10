//
//  ZouterParser.h
//  Zouter
//
//  Created by lzackx on 2018/7/9.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZouterCommand.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZouterParser : NSObject

- (instancetype)init;
- (ZouterCommand *)parseCommand:(NSURL *)command;

@end

NS_ASSUME_NONNULL_END
