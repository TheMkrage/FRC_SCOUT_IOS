//
//  radioButtonGroup.h
//  FRC-Scout
//
//  Created by Matthew Krager on 1/30/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CheckBoxLabel;
@interface RadioButtonGroup : NSObject
-(void)setEverythingOtherThan:(CheckBoxLabel*) checkBox;
-(id)initWithCheckBoxes:(NSMutableArray*) array;
@end
