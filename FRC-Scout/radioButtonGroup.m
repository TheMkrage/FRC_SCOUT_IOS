//
//  radioButtonGroup.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/30/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "radioButtonGroup.h"
#import "checkBoxLabel.h"
@interface radioButtonGroup () {

}
@property NSMutableArray *arrayOfChecks;
@end
@implementation radioButtonGroup

-(id)initWithCheckBoxes:(NSMutableArray*) array {
    self = [super init];
    self.arrayOfChecks = array;
    return self;
}
-(void)setEverythingOtherThan:(checkBoxLabel*) checkBox {
    
}
@end
