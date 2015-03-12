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
    int noodle;
}
@end
@implementation ToteStack

-(id) initWithTotes: (int) totes2 Can: (int) can2 Noodle: (int) noodle2{
    self = [super init];
    totes = totes2;
    can = can2;
    noodle = noodle2;
    return self;
}

-(int) getTotes {
    return totes;
}

-(int) getCan {
    return can;
}

-(int) getNoodle {
    return noodle;
}

-(void) setCan:(int)can1 {
    can = can1;
}

-(void) setTotes:(int)totes1 {
    totes = totes1;
}

-(void) setNoodle:(int) noodle1 {
    noodle = noodle1;
}

@end
