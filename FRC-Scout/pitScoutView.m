//
//  pitScoutView.m
//  FRC-Scout
//
//  Created by Matthew Krager on 12/22/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "PitScoutView.h"
@interface PitScoutView()

@end

@implementation PitScoutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"h");
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"dsh");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
