//
//  kragerPickerView.m
//  FRC-Scout
//
//  Created by Matthew Krager on 12/25/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "KragerPickerView.h"
#import "Level1PitScoutViewController.h"
#import <Firebase/Firebase.h>
@interface KragerPickerView()
{
    IBOutlet UIPickerView* picker;
    IBOutlet UIButton* doneButton;
    NSString* code;
    NSArray* pickerData;
    NSString* selectedItem;
    Level1PitScoutViewController* controller;
    
}
@property UITextField* linkedTextField;
@end

@implementation KragerPickerView

- (void) setData: (NSArray*) data textField: (UITextField*) textField withController: (UIViewController*) viewController withCode:(NSString*) code1{
    code = code1;
    selectedItem = pickerData[0];
    [picker setDataSource:self];
    [picker setDelegate:self];
    controller = (Level1PitScoutViewController*)viewController;
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
    [self updateCodeToServer];
    //NSLog(@"%hhd", [selectedItem containsString:@"Other"]);
}

-(void) updateCodeToServer {
    Firebase* ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://friarscout.firebaseio.com/teams/%@/pit/%@",[controller getTeam], code]];
    [ref setValue:selectedItem];
}






@end
