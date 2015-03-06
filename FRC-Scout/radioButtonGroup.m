//
//  radioButtonGroup.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/30/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "RadioButtonGroup.h"
#import "CheckBoxLabel.h"
@interface RadioButtonGroup () {

}
@property NSMutableArray *arrayOfChecks;
@end
@implementation RadioButtonGroup

-(id)initWithCheckBoxes:(NSMutableArray*) array {
    self = [super init];
    self.arrayOfChecks = array;
    for(int i = 0; i < self.arrayOfChecks.count; i++) {
        [[[self arrayOfChecks] objectAtIndex:i] setRadioGroup: self];
        NSLog(@"%d",
              i);
    }
    return self;
}
-(void)setEverythingOtherThan:(CheckBoxLabel*) checkBox {
    NSLog(@"FDSAFA");
    for(int i = 0; i < [self arrayOfChecks].count; i ++) {
        if(checkBox == [[self arrayOfChecks] objectAtIndex:i])
            [[[self arrayOfChecks] objectAtIndex:i] setTickedToggle];
        else {
            [[[self arrayOfChecks] objectAtIndex:i] setUnticked];
        }
            
    }
}
@end
