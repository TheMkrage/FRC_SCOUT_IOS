//
//  QueueManager.m
//  FRC-Scout
//
//  Created by Matthew Krager on 2/26/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "QueueManager.h"
#import "JSONRequest.h"
#import "ImageRequest.h"
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
    if(self.arrayOfRequests.count != 0)
        [self performSelectorInBackground:@selector(uploadObjectZero) withObject:nil];
}

-(void) uploadObjectZero {
    
    if([[self.arrayOfRequests objectAtIndex:0] isKindOfClass: [JSONRequest class]]) {
        [[self.arrayOfRequests objectAtIndex:0] upload];
    }else if ([[self.arrayOfRequests objectAtIndex:0] isKindOfClass: [ImageRequest class]]) {
        [[self.arrayOfRequests objectAtIndex:0] upload];
    }
    for(int i = 1; i < self.arrayOfRequests.count; i++) {
        id temp = [self.arrayOfRequests objectAtIndex:1];
        [self.arrayOfRequests removeObjectAtIndex:i];
        [self.arrayOfRequests replaceObjectAtIndex:i-1 withObject:temp];
    }
}

-(void) addRequestObject: (id) object {
    [self.arrayOfRequests addObject:object];
}
@end
