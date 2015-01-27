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
@property (strong, nonatomic) IBOutlet checkBoxLabel *immobileCheckBox;
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
    [super viewWillAppear:animated];
    self.tabBarController.title = @"Autonomous";
    [self setFonts];
    [self setDelegates];
    
}

-(void) viewDidLoad {
    [super viewDidLoad];

    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.enabled = YES;
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:singleTapGestureRecognizer];
    
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    [self setData];
}

-(void) setFonts {
    //the box will show up when user clicks checkbox
    [[self otherTextField] setHidden:YES];
    [[self otherTextField] setPlaceholder:@"Other"];
    
    [[self byLandFillCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self byYellowToteCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self byLandFillCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self immobileCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self otherCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];


}


-(void) setData {
    [[self otherCheckBox] setHiddenObject:[self otherTextField]];
}

-(void) setDelegates {
    [self otherTextField].delegate = self;
}



-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 720);
}

-(void) singleTap: (UITapGestureRecognizer*)gesture {
    NSLog(@"TAP");
    [self turnOffActiveAspect];
}

- (void) turnOffActiveAspect {
    if([activeAspect isKindOfClass:[kragerPickerView class]]) {
        [activeAspect setHidden:YES];
    } else {
        [activeAspect resignFirstResponder];
    }
    
}

#pragma mark - UITextFieldDelegate

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
    return YES;
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
