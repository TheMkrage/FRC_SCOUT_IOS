//
//  ToteSwipeGestureRecognizer.m
//  FRC-Scout
//
//  Created by Matthew Krager on 2/26/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "ToteSwipeGestureRecognizer.h"
#import "Level1AnimationMatchScoutViewController.h"
#import <UIKit/UIKit.h>
@interface ToteSwipeGestureRecognizer () {
    
}
@property(nonatomic, strong) Level1AnimationMatchScoutViewController* controller;
@end
@implementation ToteSwipeGestureRecognizer

-(id) initWithTarget:(id)target action:(SEL)action controller: (Level1AnimationMatchScoutViewController*) controller {
    self = [super initWithTarget:target action:action];
    self.controller = controller;
    
    return self;
}
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event {
   }

- (void)touchesMoved:(NSSet *)touches
           withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.controller.view];
        [self.controller updateTotesWithX:point.x Y:point.y];
}
@end
