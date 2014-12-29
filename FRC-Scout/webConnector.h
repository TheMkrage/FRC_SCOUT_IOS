//
//  webConnector.h
//  FRC-Scout
//
//  Created by Matthew Krager on 11/17/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol webProtocol <NSObject>

- (void)itemsDownload: (NSArray*)items;

@end
@interface webConnector : NSObject <NSURLConnectionDataDelegate>
@property (nonatomic,weak)id<webProtocol> delegate;

-(void)downloadItems;

@end
