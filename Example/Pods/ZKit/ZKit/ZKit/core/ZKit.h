//
//  ZKit.h
//  ZKit
//
//  Created by lzackx on 2018/4/18.
//  Copyright © 2018年 lzackx. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for ZKit.
FOUNDATION_EXPORT double ZKitVersionNumber;

//! Project version string for ZKit.
FOUNDATION_EXPORT const unsigned char ZKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZKit/PublicHeader.h>

// MARK: Log
#ifdef DEBUG
#define ZLog(format, ...) NSLog((@"%s %s [Line %d]: " format), __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ZLog(...)
#endif

// MARK: ZKit class
@interface ZKit: NSObject

// MARK: Singleton
+ (instancetype)sharedZ;

// MARK: Configuration
//! get configuration value for key
- (id)configurationValueForKey:(NSString *)key;

//! set configuration value for key
- (void)setConfigurationValue:(id)value forKey:(NSString *)key;

@end
