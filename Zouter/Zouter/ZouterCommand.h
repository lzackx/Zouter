//
//  ZouterCommand.h
//  Zouter
//
//  Created by lzackx on 2018/7/9.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZouterCommand : NSObject

@property (nonatomic, readonly, copy) NSString *className;
@property (nonatomic, readonly, assign) NSNumber *identifier;
@property (nonatomic, readonly, copy) NSString *methodName;
@property (nonatomic, readonly, copy) NSDictionary *methodParameters;

- (instancetype)initWithClassName:(NSString *)className
                       identifier:(NSNumber *)identifier
                       methodName:(NSString *)methodName
                 methodParameters:(NSDictionary *)methodParameters;

@end

NS_ASSUME_NONNULL_END
