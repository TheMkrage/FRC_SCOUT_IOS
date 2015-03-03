//
//  DataManager.m
//  FRC-Scout
//
//  Created by Matthew Krager on 3/2/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
+ (id)sharedManager {
    static DataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}
@end
