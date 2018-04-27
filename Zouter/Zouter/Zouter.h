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

typedef NS_OPTIONS(NSUInteger, ZouterMode) {
    ZouterClassMode = 0,
    ZouterInstanceMode = 1,
};

@interface Zouter : NSObject

+ (void)initializeWithScheme:(NSString *)scheme;
+ (instancetype)sharedInstance;

- (id)openURL:(NSURL * _Nonnull)url withRetainIdentifier:(NSString * _Nullable)retainIdentifier completion:( void(^ _Nullable)(id))completion;
- (id)openURL:(NSURL * _Nonnull)url withRetainIdentifier:(NSString * _Nullable)retainIdentifier;
- (id)openURL:(NSString * _Nonnull)url completion:(void(^_Nullable)(id))completion;
- (id)openURLString:(NSString * _Nonnull)urlString withRetainIdentifier:(NSString * _Nullable)retainIdentifier completion:(void(^_Nullable)(id))completion;
- (id)openURLString:(NSString * _Nonnull)urlString withRetainIdentifier:(NSString * _Nullable)retainIdentifier;
- (id)openURLString:(NSString * _Nonnull)urlString completion:(void(^_Nullable)(id))completion;

- (void)releaseObjectOfClassName:(NSString * _Nonnull)className retainIdentifier:(NSString * _Nonnull)retainIdentifier;

@end
