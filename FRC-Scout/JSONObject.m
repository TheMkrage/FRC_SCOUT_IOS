//
//  JSONObject.m
//  FRC-Scout
//
//  Created by Matthew Krager on 2/23/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "JSONObject.h"

@interface JSONObject ()
@property NSMutableDictionary* dictionary;

@end

@implementation JSONObject

-(id) init {
    self.dictionary = [[NSMutableDictionary alloc]init];
    self = [super init];
    return self;
}

-(NSString*) getJSONString {
    NSError *error = nil;
    NSData *json;
    
    // Dictionary convertable to JSON ?
    if ([NSJSONSerialization isValidJSONObject:self.dictionary])
    {
        // Serialize the dictionary
        json = [NSJSONSerialization dataWithJSONObject:self.dictionary options:NSJSONWritingPrettyPrinted error:&error];
        
        // If no errors, let's view the JSON
        if (json != nil && error == nil)
        {
            NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            
            NSLog(@"JSON: %@", jsonString);
            return jsonString;
        }
    }
    return @"";
}


@end
