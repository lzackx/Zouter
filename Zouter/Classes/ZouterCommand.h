//
//  ZouterCommand.h
//  Zouter
//
//  Created by lzackx on 2018/7/9.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZouterCommandPriority) {
	ZouterCommandPriorityDefault = 0,
	ZouterCommandPriorityLowest = -999,
	ZouterCommandPriorityHighest = 999,
};

@class ZouterCommand;

typedef void(^ZouterCommandWillExcuteCallback)(ZouterCommand *command);
typedef void(^ZouterCommandDidExcuteCallback)(ZouterCommand *command, NSDictionary * _Nullable info);
typedef void(^ZouterCommandCompledCallback)(ZouterCommand *command, NSDictionary * _Nullable info);

@interface ZouterCommand : NSObject

//  scheme://[target]/[action]?[params]
@property (nonatomic, readwrite, copy) NSString *pattern;
@property (nonatomic, readwrite, copy) NSString *taURL; // Target Action URL
@property (nonatomic, readwrite, assign) BOOL synchronizly;
@property (nonatomic, readwrite, assign) ZouterCommandPriority priority;
@property (nonatomic, readwrite, copy) __nullable ZouterCommandWillExcuteCallback willExcute;
@property (nonatomic, readwrite, copy) __nullable ZouterCommandDidExcuteCallback didExcute;
@property (nonatomic, readwrite, copy)  NSDictionary<NSString *, NSObject *> * _Nullable parameters;

- (void)run;
- (void)runWithParameters:(NSDictionary *)parameters
        completedCallback:(ZouterCommandCompledCallback _Nullable)completedCallback;

@end

NS_ASSUME_NONNULL_END
