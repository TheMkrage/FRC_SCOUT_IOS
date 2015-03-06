//
//  kragerPickerView.h
//  FRC-Scout
//
//  Created by Matthew Krager on 12/25/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KragerPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

-(void) setData: (NSArray*) data textField: (UITextField*) textField withController: (UIViewController*) viewController withCode:(NSString*) code1;
- (NSString*)getSelectedItem;
-(void) setSelectedValueToTextField;
@end
