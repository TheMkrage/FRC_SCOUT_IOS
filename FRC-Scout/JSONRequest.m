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
@property(nonatomic, strong) NSDictionary* mainDictionary;

@end

@implementation JSONRequest

-(id) initWithString: (NSDictionary*)string {
    self = [super init];
    self.mainDictionary = string;
    return self;
}
-(id) initWithJSONObject: (JSONObject*)object {
    self = [super init];
    self.mainDictionary = [object getDictionary];
    return self;
}
-(void) upload {
    if (self.mainDictionary == nil) {
        return;
    }
    CFReadStreamRef rstream;
    CFWriteStreamRef wstream;
    
    //connect to server
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"mrflark.org", 3309, &rstream, &wstream);
    NSLog(@"connected to server");
    
    //init i/o with server
    NSInputStream* is = objc_unretainedObject(rstream);
    [is scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [is open];
    
    NSOutputStream* os = objc_unretainedObject(wstream);
    
    
    
    [os scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [os open];

    //NSMutableData* data = [NSMutableData dataWithData:[self.mainDictionary dataUsingEncoding:NSUTF8StringEncoding]];
    //const uint8_t* bytesString = (const uint8_t*)[data bytes];
    //[os write:bytesString maxLength:[data length]];
    
    [os close];
}
@end
