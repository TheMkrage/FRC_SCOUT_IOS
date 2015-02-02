//
//  checkBoxLabel.h
//  FRC-Scout
//
//  Created by Matthew Krager on 1/23/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "radioButtonGroup.h"

@interface checkBoxLabel : UIButton
-(void) setHiddenObject: (id) hiddenObject;
-(void) setTicked;
-(void) setUnticked;
-(void) setRadioGroup: (radioButtonGroup*) group;
@end
