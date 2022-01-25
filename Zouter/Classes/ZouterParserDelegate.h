//
//  ZouterParserDelegate.h
//  Zouter
//
//  Created by lzackx on 2021/5/14.
//

#import <Foundation/Foundation.h>
#import "ZouterCommand.h"


@class ZouterParser;
@class ZouterCommand;

NS_ASSUME_NONNULL_BEGIN

@protocol ZouterParserDelegate <NSObject>

- (void)parser:(ZouterParser *)parser
       command:(ZouterCommand *)command
    parameters:(NSDictionary *)parameters
completedCallback:(ZouterCommandCompledCallback _Nullable)completedCallback;

@end

NS_ASSUME_NONNULL_END
