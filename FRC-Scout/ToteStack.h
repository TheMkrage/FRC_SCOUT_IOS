//
//  ToteStack.h
//  FRC-Scout
//
//  Created by Matthew Krager on 2/27/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToteStack : NSObject
-(id) initWithTotes: (int) totes2 Can: (int) can2 Noodle: (int) noodle2;
-(void) setCan:(int)can;
-(void) setTotes:(int)totes;
-(int) getCan;
-(int) getTotes;
-(int) getNoodle;
-(void) setNoodle:(int) noodle1;
@end
