//
//  ZouterParserDelegate.h
//  Zouter
//
//  Created by lzackx on 2021/5/14.
//

#import <Foundation/Foundation.h>


@class ZouterParser;
@class ZouterCommand;

NS_ASSUME_NONNULL_BEGIN

@protocol ZouterParserDelegate <NSObject>

- (void)parser:(ZouterParser *)parser command:(ZouterCommand *)command;

@end

NS_ASSUME_NONNULL_END
