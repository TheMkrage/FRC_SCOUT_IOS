//
//  checkBoxLabel.h
//  FRC-Scout
//
//  Created by Matthew Krager on 1/23/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButtonGroup.h"

@interface CheckBoxLabel : UIButton
-(void) setHiddenObject: (id) hiddenObject;
-(void) setTicked;
-(void) setTickedToggle;
-(void) setUnticked;
-(void) setRadioGroup: (RadioButtonGroup*) group;
-(bool)getStatus;
@end
