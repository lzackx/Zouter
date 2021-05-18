//
//  Zouter.h
//  Zouter
//
//  Created by lzackx on 2018/4/20.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZouterCommand.h"

//! Project version number for Zouter.
FOUNDATION_EXPORT double ZouterVersionNumber;

//! Project version string for Zouter.
FOUNDATION_EXPORT const unsigned char ZouterVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Zouter/PublicHeader.h>


@interface Zouter : NSObject

+ (void)initializeWithScheme:(NSString *_Nonnull)scheme;
+ (instancetype _Nonnull )sharedRouter;

// Registration
- (void)registerCommand:(ZouterCommand *_Nonnull)command;

// Perform
- (void)performURLString:(NSString * _Nullable)urlString;
- (void)performURL:(NSURL * _Nullable)url;

@end
