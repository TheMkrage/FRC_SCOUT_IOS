//
//  ToteSwipeGestureRecognizer.h
//  FRC-Scout
//
//  Created by Matthew Krager on 2/26/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Level1AnimationMatchScoutViewController.h"

@interface ToteSwipeGestureRecognizer : UISwipeGestureRecognizer
-(id) initWithTarget:(id)target action:(SEL)action controller: (Level1AnimationMatchScoutViewController*) controller;
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event;
@end
