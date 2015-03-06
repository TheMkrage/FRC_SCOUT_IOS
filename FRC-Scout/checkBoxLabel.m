//
//  checkBoxLabel.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/23/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "CheckBoxLabel.h"
#import "RadioButtonGroup.h"
@interface CheckBoxLabel() {
    id hiddenObj;
    RadioButtonGroup *radioGroup;
}
@end


@implementation CheckBoxLabel

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
        [self setUnticked];
    }
    else
    {
        [self setTicked];
    }
    
}
-(void) setTickedToggle {
    NSString *untickedBoxStr = @"\u2610";
    NSString *tickedBoxStr = @"\u2611";
    [self setTitle:tickedBoxStr forState:UIControlStateNormal];
    
    if(hiddenObj!= nil)
        [hiddenObj setHidden:NO];

}

-(void) setTicked {
    NSString *untickedBoxStr = @"\u2610";
    NSString *tickedBoxStr = @"\u2611";
    [self setTitle:tickedBoxStr forState:UIControlStateNormal];
    NSLog(@"TICK");
    if(radioGroup != nil) {
        [radioGroup setEverythingOtherThan:self];
    }
    if(hiddenObj!= nil)
        [hiddenObj setHidden:NO];
}

-(void) setUnticked {
    NSString *untickedBoxStr = @"\u2610";
    NSString *tickedBoxStr = @"\u2611";
    [self setTitle:untickedBoxStr forState:UIControlStateNormal];
    if(hiddenObj!= nil)
        [hiddenObj setHidden:YES];
}

-(void) setHiddenObject: (id) hiddenObject2 {
    hiddenObj = hiddenObject2;
    return;
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

-(void) setRadioGroup: (RadioButtonGroup*) group {
    radioGroup = group;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
