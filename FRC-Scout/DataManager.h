//
//  DataManager.h
//  FRC-Scout
//
//  Created by Matthew Krager on 3/2/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObject.h"

@interface DataManager : NSObject

+ (id)sharedManager;
-(void) addJSONObject: (JSONObject*) obj onArray:(int)arrayNum at:(int)spot;
-(JSONObject*) getJSONObjectOnArray:(int) arrayNum spot: (int) spot ;
-(NSMutableArray*) getArrayNum: (int) arrayNum ;
- (void) clearArray: (int) arrayNum;
@end
