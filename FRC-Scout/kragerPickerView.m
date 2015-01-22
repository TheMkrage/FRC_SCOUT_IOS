//
//  kragerPickerView.m
//  FRC-Scout
//
//  Created by Matthew Krager on 12/25/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "kragerPickerView.h"
#import "level1PitScoutViewController.h"
@interface kragerPickerView()
{
    IBOutlet UIPickerView* picker;
    IBOutlet UIButton* doneButton;
    NSArray* pickerData;
    NSString* selectedItem;
    level1PitScoutViewController* controller;
    
}
@property UITextField* linkedTextField;
@end

@implementation kragerPickerView

- (void) setData: (NSArray*) data textField: (UITextField*) textField withController: (UIViewController*) viewController{
    selectedItem = pickerData[0];
    [picker setDataSource:self];
    [picker setDelegate:self];
    controller = (level1PitScoutViewController*)viewController;
    //[self setFrame:CGRectMake(0, 0, 320, 225)];
    pickerData = data;
    _linkedTextField = textField;
    selectedItem = pickerData[0];
    
}

- (IBAction)doneButton:(id)sender {
    [self setHidden:YES];
    [self setSelectedValueToTextField];
        
    
    
}

-(void) setSelectedValueToTextField {
    if([[self getSelectedItem] rangeOfString:@"Other"].length != 0) {
        [self otherIsSelected];
    }else {
    [_linkedTextField setText:[self getSelectedItem]];
    }
}
-(void) otherIsSelected {
    [_linkedTextField setText:@""];
    [_linkedTextField setPlaceholder:[self getSelectedItem]];
    [controller textFieldShouldBeEditable: self.linkedTextField];
    [self setHidden:YES];
}
-(NSString*)getSelectedItem {
    return selectedItem;
}

#pragma mark-  UIPickerViewDelegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return pickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"picked: %@",pickerData[row]);
    selectedItem = pickerData[row];
    [self setSelectedValueToTextField];
    //NSLog(@"%hhd", [selectedItem containsString:@"Other"]);
}






@end
