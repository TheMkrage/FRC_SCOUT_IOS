//
//  ToteStack.m
//  FRC-Scout
//
//  Created by Matthew Krager on 2/27/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "ToteStack.h"
@interface ToteStack () {
    int totes;
    int can;
}
@end
@implementation ToteStack

-(id) initWithTotes: (int) totes2 Can: (int) can2 {
    self = [super init];
    totes = totes2;
    can = can2;
    return self;
}

-(int) getTotes {
    return totes;
}

-(int) getCan {
    return can;
}

-(void) setCan:(int)can1 {
    can = can1;
}

-(void) setTotes:(int)totes1 {
    totes = totes1;
}

@end
