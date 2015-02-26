//
//  QueueManager.m
//  FRC-Scout
//
//  Created by Matthew Krager on 2/26/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "QueueManager.h"

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
        //someProperty = @"Default Property Value";
    }
    return self;
}
@end
