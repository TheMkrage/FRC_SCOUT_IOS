//
//  QueueManager.m
//  FRC-Scout
//
//  Created by Matthew Krager on 2/26/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "QueueManager.h"
@interface QueueManager () {
    
}

@property NSTimer* uploadTimer;
@property NSMutableArray* arrayOfRequests;
@end
@implementation QueueManager

+ (id)sharedManager {
    static QueueManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        self.uploadTimer = [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(tryToUpload) userInfo:nil repeats:YES];
        self.arrayOfRequests = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) tryToUpload {
    NSLog(@"IM TRYING BABE");
    [self performSelectorInBackground:@selector(saySomething) withObject:nil];
}

-(void) saySomething {
    while(true) {
        NSLog(@"dasf");
    }
}
@end
