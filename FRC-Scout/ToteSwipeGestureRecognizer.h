//
//  ToteSwipeGestureRecognizer.h
//  FRC-Scout
//
//  Created by Matthew Krager on 2/26/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ToteSwipeGestureRecognizer : UISwipeGestureRecognizer
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event;
@end
