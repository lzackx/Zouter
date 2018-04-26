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

- (id)openURL:(NSURL *)url withRetainIdentifier:(NSString *)retainIdentifier completion:(void(^)(id))completion;
- (id)openURL:(NSURL *)url withRetainIdentifier:(NSString *)retainIdentifier;
- (id)openURL:(NSString *)url completion:(void(^)(id))completion;
- (id)openURLString:(NSString *)urlString withRetainIdentifier:(NSString *)retainIdentifier completion:(void(^)(id))completion;
- (id)openURLString:(NSString *)urlString withRetainIdentifier:(NSString *)retainIdentifier;
- (id)openURLString:(NSString *)urlString completion:(void(^)(id))completion;

@end
