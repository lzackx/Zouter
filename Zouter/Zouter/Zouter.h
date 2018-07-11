//
//  Zouter.h
//  Zouter
//
//  Created by lzackx on 2018/4/20.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for Zouter.
FOUNDATION_EXPORT double ZouterVersionNumber;

//! Project version string for Zouter.
FOUNDATION_EXPORT const unsigned char ZouterVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Zouter/PublicHeader.h>


@interface Zouter : NSObject

+ (void)initializeWithScheme:(NSString *)scheme;
+ (instancetype)sharedRouter;

- (void)openURL:(NSURL * _Nonnull)url completion:(void(^)(void))completion;
- (void)openURLString:(NSString * _Nonnull)urlString completion:(void(^)(void))completion;
- (void)openInSync:(BOOL)sync withURL:(NSURL * _Nonnull)url completion:(void(^)(void))completion;
- (void)openInSync:(BOOL)sync withURLString:(NSString * _Nonnull)urlString completion:(void(^)(void))completion;


@end
