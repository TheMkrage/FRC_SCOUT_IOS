//
//  ImageRequest.m
//  FRC-Scout
//
//  Created by Matthew Krager on 2/26/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "ImageRequest.h"
@interface ImageRequest() {
    
}
@property(strong, nonatomic) UIImage* image;
@end
@implementation ImageRequest
-(id) initWithImage:(UIImage*)image {
    self = [super init];
    self.image = image;
    return self;
}
-(void) upload {
    if (self.image == nil) {
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
    
    NSMutableData* data = [NSMutableData dataWithData:UIImagePNGRepresentation(self.image)];
    
    NSUInteger len = [data length];
    Byte* byteData = (Byte*)malloc(len);
    [data getBytes:byteData length:len];
    
    //[os write:byteData maxLength:len];
    NSUInteger byteIndex = 0;
    //worked last time
    while(byteIndex < [data length]) {
        uint8_t *readBytes = (uint8_t *)[data mutableBytes];
        readBytes += byteIndex; // instance variable to move pointer
        NSUInteger data_len = [data length];
        len = ((data_len - byteIndex >= 1024) ?
                             1024 : (data_len-byteIndex));
        uint8_t buf[len];
        (void)memcpy(buf, readBytes, len);
        len = [(NSOutputStream*)os write:(const uint8_t *)buf maxLength:len];
        byteIndex += len;
    }
    
    NSLog(@"loading image...");
    NSLog(@"image loaded");
    NSLog(@"sent data");
    
    [is close];
    [os close];
    
}
@end
