//
//  JSONRequest.h
//  FRC-Scout
//
//  Created by Matthew Krager on 2/26/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "JSONObject.h"
#import <Foundation/Foundation.h>

@interface JSONRequest : NSObject
-(id) initWithJSONObject: (JSONObject*)object;
-(id) initWithString: (NSString*)string;
-(void) upload;
@end
