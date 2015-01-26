//
//  level1AutonomousViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/19/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "level1AutonomousViewController.h"
#import"kragerPickerView.h"
#import "checkBoxLabel.h"
@interface level1AutonomousViewController () {
    bool textFieldShouldEdit;
    UITextField *activeTextField;
    id activeAspect;
    IBOutlet UIScrollView* scrollView;
    IBOutlet checkBoxLabel *checkBox;

    
}
//Starting Pos

//checkBoxes
@property (strong, nonatomic) IBOutlet checkBoxLabel *byLandFillCheckBox;
@property (strong, nonatomic) IBOutlet checkBoxLabel *byYellowToteCheckBox;
@property (strong, nonatomic) IBOutlet checkBoxLabel *ImmobileCheckBox;
@property (strong, nonatomic) IBOutlet checkBoxLabel *otherCheckBox;
//Other
@property (strong, nonatomic) IBOutlet UITextField *otherTextField;




@end
#define FONT_BEBAS_15 [UIFont fontWithName: @"Bebas Neue" size:15]
#define FONT_BEBAS_20 [UIFont fontWithName: @"Bebas Neue" size:20]
#define FONT_BEBAS_25 [UIFont fontWithName: @"Bebas Neue" size:25]
#define FONT_BEBAS_28 [UIFont fontWithName: @"Bebas Neue" size:28]
@implementation level1AutonomousViewController


-(void)viewWillAppear:(BOOL)animated {
    self.tabBarController.title = @"Autonomous";
    [self setFonts];
}

-(void) setFonts {
    //the box will show up when user clicks checkbox
    [[self otherTextField] setHidden:YES];
    
}

-(void) setData {
   
}

-(void) setDelegates {
    [self otherTextField].delegate = self;
}


-(void) viewDidLayoutSubviews {
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 720);
}

- (void) turnOffActiveAspect {
    if([activeAspect isKindOfClass:[kragerPickerView class]]) {
        [activeAspect setHidden:YES];
    } else {
        [activeAspect resignFirstResponder];
    }
    
}

#pragma mark - UITextFieldDelegate
-(BOOL) textFieldShouldBeActive: (kragerPickerView*) picker {
    //[picker setCenter:CGPointMake(self.drivePicker.center.x, self.view.frame.size.height - 150)];
    [picker setBackgroundColor:[UIColor whiteColor]];
    
    //[scrollView setScrollEnabled:NO];
    activeAspect = picker;
    picker.hidden = NO;
    return NO;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self turnOffActiveAspect];
    activeTextField = textField;
    activeAspect = textField;
    [scrollView setContentOffset:CGPointMake(0, activeTextField.center.y - scrollView.frame.size.height/4) animated:YES];
    if(textFieldShouldEdit) {
        textFieldShouldEdit= NO;
        return YES;
    }
#warning GET RID OF THIS
    return NO;
    /*if(([self drivePicker].hidden == NO || [self intakePicker].hidden == NO || [self liftPicker].hidden == NO || [self cimPicker].hidden == NO || [self frameStrengthPicker].hidden == NO)) {
        activeAspect = NULL;
        if([self drivePicker].hidden == NO) {
            [[self drivePicker] setSelectedValueToTextField];
        }else if(![self intakePicker].isHidden) {
            [[self intakePicker] setSelectedValueToTextField];
        }else if(![self liftPicker].isHidden) {
            [[self liftPicker] setSelectedValueToTextField];
        }else if(![self frameStrengthPicker].isHidden) {
            [[self frameStrengthPicker] setSelectedValueToTextField];
        }else if(![self cimPicker].isHidden) {
            [[self cimPicker] setSelectedValueToTextField];
        }
        NSLog(@"%hhd",[self liftPicker].hidden);
        [self setAllPickersHidden];
        
     
    }
    if(activeTextField == [self driveTextField]){
        return [self textFieldShouldBeActive: self.drivePicker];
    }else if(activeTextField == [self intakeTextField]) {
        return [self textFieldShouldBeActive: self.intakePicker];
    }else if(activeTextField == [self liftTextField]) {
        return [self textFieldShouldBeActive: self.liftPicker];
    }else if(activeTextField == [self cimTextField]) {
        return [self textFieldShouldBeActive: self.cimPicker];
    }else if(activeTextField == [self frameStrengthTextField]) {
        return [self textFieldShouldBeActive: self.frameStrengthPicker];
    }
    
    return YES;
*/
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"fds");
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"ENDED");
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"SELECTED");
    
    activeTextField = textField;
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)checkBoxButton:(id)sender {
}
@end
