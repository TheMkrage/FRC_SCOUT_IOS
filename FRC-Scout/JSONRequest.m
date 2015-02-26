//
//  JSONRequest.m
//  FRC-Scout
//
//  Created by Matthew Krager on 2/26/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "JSONRequest.h"
#import "JSONObject.h"
@interface JSONRequest ()
@property(nonatomic, strong) NSString* mainString;

@end

@implementation JSONRequest

-(id) initWithString: (NSString*)string {
    self = [super init];
    self.mainString = string;
    return self;
}
-(id) initWithJSONObject: (JSONObject*)object {
    self = [super init];
    self.mainString = [object getJSONString];
    return self;
}
-(void) upload {
    
}
@end
