//
//  webConnector.m
//  FRC-Scout
//
//  Created by Matthew Krager on 11/17/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "webConnector.h"

@interface webConnector() {
    NSMutableData *_downloadedData;
}

@end

@implementation webConnector


- (void)downloadItems{
    //downloads the json for you
    NSURL *jsonFileURL = [NSURL URLWithString:@"http://mrflark.org/scouting-api/login.php"];
    
    //Request is made
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:jsonFileURL];
    
    NSString *noteDataString = [NSString stringWithFormat:@"name=%@&password=%@", @"HELLO", @"JOEY"];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setHTTPBody:[noteDataString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *dataRaw, NSURLResponse *header, NSError *error) {
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:dataRaw
                              options:kNilOptions error:&error];
        NSString *status = json[@"status"];
        
        if([status isEqual:@"1"]){
            NSLog(@"HELLO");
            
        } else {
            NSLog(@"ERROR");
            
        }
    }];
    
    [dataTask resume];
    
    //Creat the Connection Baby
    //[NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods
//Protocol methods for NSURLConnectionDataPRotocol
-(void) connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response {
    //make where data is stored from JSON
    _downloadedData = [[NSMutableData alloc] init];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@",error);
}
-(void)connection:(NSURLConnection*) connection didReceiveData:(NSData *)data {
    [_downloadedData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //array to temporaily store the info
    //NSMutableArray *_usernames = [[NSMutableArray alloc] init];
    //NSMutableArray *_password = [[NSMutableArray alloc] init];
    NSNumber *PlevelInt = [[NSNumber alloc] init];
    
    //parse JSON
    NSError *error;
    
    NSArray *jsonStuff = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    //loop through each object
    for(int i = 0; i <jsonStuff.count; i++){
        
        //make the element
        NSDictionary *jsonElement = jsonStuff[i];
        //set the user and pass equal to profiles
        //[_usernames addObject:jsonElement[@"USERNAME"]];
        //[_password addObject:jsonElement[@"PASSWORD"]];
        PlevelInt = jsonElement[@"PLEVEL"];
        
        
    }
    
    if(self.delegate) {
        NSLog(@"%@", PlevelInt);
        [self.delegate itemsDownload:@[PlevelInt]];
        
    }
    
}
@end
