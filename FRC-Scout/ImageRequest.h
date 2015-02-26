//
//  ImageRequest.h
//  FRC-Scout
//
//  Created by Matthew Krager on 2/26/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageRequest : NSObject
-(void) upload;
-(id) initWithImage:(UIImage*)image;
@end
