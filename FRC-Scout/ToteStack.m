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

-(id) init {
    self = [super init];
    UIImageView* tote0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Tote.png"]];
    [tote0 setFrame:CGRectMake([self getCorrectX], [self getCorrectYForTote: 0] * 2, 30, 20)];
    self.toteArray = [[NSMutableArray alloc]init];
    
    return self;
}

-(int) getCorrectX {
    if(self.stack == 1) {
        return 32;
    }else if(self.stack == 2) {
        return 432;
    }else if(self.stack == 3) {
        return 600;
    }else if(self.stack == 4) {
        return 800;
    }else if(self.stack == 5) {
        return 990;
    }else {
        return 0;
    }
}

-(int) getCorrectYForTote: (int) toteNum {
    if(toteNum == 0) {
        
    }
    return 0;
}




@end
