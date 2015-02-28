//
//  ToteStack.m
//  FRC-Scout
//
//  Created by Matthew Krager on 2/27/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "ToteStack.h"
@interface ToteStack ()
@property int totes;
@property int can;
@property int stack;
@property(strong, nonatomic) NSMutableArray* toteArray;
@end
@implementation ToteStack

-(id) initWithTotes: (int) totes Can: (int) can stack: (int) stack{
    self = [super init];
    self.totes = totes;
    self.can = can;
    self.stack = stack;
    return self;
}




@end
