//
//  DataManager.m
//  FRC-Scout
//
//  Created by Matthew Krager on 3/2/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "DataManager.h"
#import "JSONObject.h"
@interface DataManager () {
    
}
@property (strong, nonatomic)NSMutableArray* pitScoutArray;
@property (strong, nonatomic) NSMutableArray* matchScoutArray;
@end
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

/*
 Each array is an array of json string.  The reason for this is so the data from multiple views can be sent all at once
 There are two arrays (at least when this was written there were.  Array # 0 is pit scout while Array # 1 is match scout.  In each of these, there is a code for each page.  Look as follows:
 Array #0 - pit scout
 0: Robot Specs
 1: Teleop
 2: Auto
 3: Misc
 Array #1 - match scout
 0: Auto
 1: Match
 */


-(void) addJSONObject: (JSONObject*) obj onArray:(int)arrayNum at:(int)spot{
    switch (arrayNum) {
        case 0:
            [self.pitScoutArray setObject:obj atIndexedSubscript:spot];
            break;
        case 1:
            [self.matchScoutArray setObject:obj atIndexedSubscript:spot];
            break;
        default:
            break;
    }
}

-(JSONObject*) getJSONObjectOnArray:(int) arrayNum spot: (int) spot {
    switch (arrayNum) {
        case 0:
            return [self.pitScoutArray objectAtIndex:spot];
            break;
        case 1:
            return [self.matchScoutArray objectAtIndex:spot];
            break;
        default:
            return [[JSONObject alloc] init];
            break;
    }
}

-(NSMutableArray*) getArrayNum: (int) arrayNum {
    switch (arrayNum) {
        case 0:
            return self.pitScoutArray;
            break;
        case 1:
            return self.matchScoutArray;
            break;
        default:
            return [[NSMutableArray alloc] init];
            break;
    }
    
}


//clears array with specified number
- (void) clearArray: (int) arrayNum {
    switch (arrayNum) {
        case 0:
            self.pitScoutArray = [[NSMutableArray alloc] init];
            break;
        case 1:
            self.matchScoutArray = [[NSMutableArray alloc] init];
            break;
        default:
            break;
    }
}


@end
