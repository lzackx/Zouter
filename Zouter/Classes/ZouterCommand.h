//
//  ZouterCommand.h
//  Zouter
//
//  Created by lzackx on 2018/7/9.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZouterCommandCallback)(void);

@interface ZouterCommand : NSObject

//  scheme://[target]/[action]?[params]
@property (nonatomic, readwrite, copy) NSString *taURL; // Target Action URL
@property (nonatomic, readwrite, assign) BOOL synchronizly;
@property (nonatomic, readwrite, copy) ZouterCommandCallback willExcute;
@property (nonatomic, readwrite, copy) ZouterCommandCallback didExcute;

- (void)run;

@end

NS_ASSUME_NONNULL_END
