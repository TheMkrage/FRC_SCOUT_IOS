//
//  checkBoxLabel.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/23/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "checkBoxLabel.h"
@interface checkBoxLabel() {
    
}
@property (strong,nonatomic) id hiddenObject;
@end
@implementation checkBoxLabel
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (CGRectContainsPoint([self frame], [touch locationInView:self.superview]))
    {
        [self togglePaidStatus];
        
        
    }
}

-(void) togglePaidStatus
{
    NSString *untickedBoxStr = @"\u2610";
    NSString *tickedBoxStr = @"\u2611";
    
    if ([[self titleLabel].text isEqualToString:tickedBoxStr])
    {
        [self setTitle:untickedBoxStr forState:UIControlStateNormal];
        if(self.hiddenObject!= nil)
            [[self hiddenObject] setHidden:YES];
    }
    else
    {
        [self setTitle:tickedBoxStr forState:UIControlStateNormal];
        if(self.hiddenObject!= nil)
            [[self hiddenObject] setHidden:NO];
    }
    
}

-(void) setHiddenObject: (id) hiddenObject{
    self.hiddenObject = hiddenObject;
}

-(bool) getStatus {

    NSString *tickedBoxStr = @"\u2611";
    
    if ([[self titleLabel].text isEqualToString:tickedBoxStr])
    {
        return YES;
    }
    else
    {
        return NO;
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
