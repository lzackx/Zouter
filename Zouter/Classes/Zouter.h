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

+ (void)initializeWithScheme:(NSString *_Nonnull)scheme;
+ (instancetype _Nonnull )sharedRouter;

// targetActionURL: scheme://[target]/[action]?[params]
- (void)registerWithPattern:(NSString *_Nonnull)pattern
			targetActionURL:(NSString *_Nonnull)targetActionURL
			   synchronizly:(BOOL)synchronizly
				 willExcute:(void(^_Nullable)(void))willExcute
				  didExcute:(void(^_Nullable)(void))didExcute;

- (void)performURLString:(NSString * _Nullable)urlString;
- (void)performURL:(NSURL * _Nullable)url;

@end
