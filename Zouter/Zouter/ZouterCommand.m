//
//  ZouterCommand.m
//  Zouter
//
//  Created by lzackx on 2018/7/9.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import "ZouterCommand.h"

@implementation ZouterCommand

- (instancetype)initWithClassName:(NSString *)className
                       identifier:(NSNumber *)identifier
                       methodName:(NSString *)methodName
                 methodParameters:(NSDictionary *)methodParameters {
    
    self = [super init];
    if (self) {
        _className = className;
        _identifier = identifier;
        _methodName = methodName;
        _methodParameters = methodParameters;
    }
    return self;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@:\nClass: %@\nIdentifier: %@\nMethod: %@\nParameters: %@",
            [super debugDescription],
            self.className,
            self.identifier,
            self.methodName,
            self.methodParameters];
}

@end
