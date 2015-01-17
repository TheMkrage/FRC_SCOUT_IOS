//
//  kragerPickerView.m
//  FRC-Scout
//
//  Created by Matthew Krager on 12/25/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "kragerPickerView.h"
@interface kragerPickerView()
{
    IBOutlet UIPickerView* picker;
    IBOutlet UIButton* doneButton;
    NSArray* pickerData;
    NSString* selectedItem;
    
}
@property UITextField* linkedTextField;
@end

@implementation kragerPickerView

- (void) setData: (NSArray*) data textField: (UITextField*) textField{
    [picker setDataSource:self];
    [picker setDelegate:self];
    //[self setFrame:CGRectMake(0, 0, 320, 225)];
    pickerData = data;
    _linkedTextField = textField;
    
}

- (IBAction)doneButton:(id)sender {
    [_linkedTextField setText:[self getSelectedItem]];
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
    NSLog(@"%@",pickerData[row]);
    selectedItem = pickerData[row];
}






@end
