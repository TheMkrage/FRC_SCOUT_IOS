//
//  ToteStack.m
//  FRC-Scout
//
//  Created by Matthew Krager on 2/27/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "ToteStack.h"
@interface ToteStack ()
@property (nonatomic)  int totes;
@property (nonatomic)  int can;
@property(strong, nonatomic) NSMutableArray* toteArray;
@end
@implementation ToteStack

-(id) initWithTotes: (int) totes Can: (int) can {
    self = [super init];
    self.totes = totes;
    self.can = can;
    return self;
}

-(int) getTotes {
    return self.totes;
}

-(int) getCan {
    return self.can;
}

-(void) setCan:(int)can {
    self.can = can;
}

-(void) setTotes:(int)totes {
    self.totes = totes;
}

@end
