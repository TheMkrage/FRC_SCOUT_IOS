//
//  backNextView.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/18/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "BackNextView.h"
@interface BackNextView () {
    IBOutlet UIButton* nextButton;
    IBOutlet UIButton* backButton;
    id nextViewController;
    id backViewController;
    UINavigationController* navigationController;
}
@end
@implementation BackNextView

- (void) setBackButton:(bool) b {
    [backButton setHidden:b];
}
- (void) setNextButton:(bool) b {
    [nextButton setHidden:b];
}
- (void) setBackText:(NSString*) text {
    [backButton setTitle:text forState:UIControlStateNormal];
}
- (void) setNextText:(NSString*) text {
    [nextButton setTitle:text forState:UIControlStateNormal];
}

-(void) setNavigationController: (UINavigationController*)navController {
    navigationController = navController;
}
- (void) setBackViewController:(id) viewController {
    backViewController = viewController;
}
- (void) setNextViewController:(id) viewController {
    nextViewController = viewController;
}
- (IBAction)nextButton:(id)sender {
    
    [navigationController pushViewController:nextViewController animated:YES];
}
- (IBAction)backButton:(id)sender {
    [navigationController pushViewController:backViewController animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
