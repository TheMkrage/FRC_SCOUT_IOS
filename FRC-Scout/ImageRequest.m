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
    
}
@end
