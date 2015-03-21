//
//  level1AutonomousViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/19/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "Level1AutonomousViewController.h"
#import "Level1PitScoutViewController.h"
#import"KragerPickerView.h"
#import "CheckBoxLabel.h"
#import <Firebase/Firebase.h>
@interface Level1AutonomousViewController () {
    bool textFieldShouldEdit;
    UITextField *activeTextField;
    id activeAspect;
    IBOutlet UIScrollView* scrollView;

    
}
//Starting Pos

//checkBoxes
@property (strong, nonatomic) IBOutlet CheckBoxLabel *byLandFillCheckBox;
@property (strong, nonatomic) IBOutlet CheckBoxLabel *byYellowToteCheckBox;
@property (strong, nonatomic) IBOutlet CheckBoxLabel *immobileCheckBox;
@property (strong, nonatomic) IBOutlet CheckBoxLabel *otherPosCheckBox;
//Other
@property (strong, nonatomic) IBOutlet UITextField *otherPosTextField;

//AUTO GOALS
@property (strong, nonatomic) IBOutlet CheckBoxLabel *totesMovedCheckBox;
@property (strong, nonatomic) IBOutlet CheckBoxLabel *totesStackedCheckBox;
@property (strong, nonatomic) IBOutlet CheckBoxLabel *trashCanMovedCheckBox;
@property (strong, nonatomic) IBOutlet CheckBoxLabel *trashCansFromMiddleCheckBox;
@property (strong, nonatomic) IBOutlet CheckBoxLabel *otherGoalsCheckBox;
@property (strong, nonatomic) IBOutlet CheckBoxLabel *robotMovedCheckBox;
@property (strong, nonatomic) IBOutlet UITextField *otherGoalsTextField;

@property (strong, nonatomic) IBOutlet UITextField *totesMovedIntoZoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *trashCansMovedIntoZoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *canRecievedFromMiddleTextField;



@end
#define FONT_BEBAS_15 [UIFont fontWithName: @"Bebas Neue" size:15]
#define FONT_BEBAS_20 [UIFont fontWithName: @"Bebas Neue" size:20]
#define FONT_BEBAS_25 [UIFont fontWithName: @"Bebas Neue" size:25]
#define FONT_BEBAS_28 [UIFont fontWithName: @"Bebas Neue" size:28]
@implementation Level1AutonomousViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.title = @"Autonomous";
    [self setFonts];
    [self setDelegates];
    
}

-(void) viewDidLoad {
    [super viewDidLoad];

    
    self.totesMovedIntoZoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.trashCansMovedIntoZoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.canRecievedFromMiddleTextField.keyboardType = UIKeyboardTypeNumberPad;
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
    [[self otherPosTextField] setHidden:YES];
    [[self otherPosTextField] setPlaceholder:@"Other"];
    [[self otherGoalsTextField] setHidden:YES];
    [[self otherGoalsTextField] setPlaceholder:@"Other"];
    
    [[self byLandFillCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self byYellowToteCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self byLandFillCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self immobileCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self otherPosCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self totesMovedCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self totesStackedCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self trashCanMovedCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self trashCansFromMiddleCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self robotMovedCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
    [[self otherGoalsCheckBox] setTitle:@"\u2610" forState:UIControlStateNormal];
}


-(void) setData {
    [[self otherPosCheckBox] setHiddenObject:[self otherPosTextField]];
    [[self otherGoalsCheckBox] setHiddenObject:[self otherGoalsTextField]];
}

-(void) setDelegates {
    [self otherPosTextField].delegate = self;
    [self otherGoalsTextField].delegate = self;
    self.totesMovedIntoZoneTextField.delegate = self;
    self.trashCansMovedIntoZoneTextField.delegate = self;
    self.canRecievedFromMiddleTextField.delegate = self;
}



-(void) viewDidLayoutSubviews {
    scrollView.frame = CGRectMake(scrollView.frame.origin.x, 56, 320, self.view.frame.size.height);
    scrollView.contentSize = CGSizeMake(320, 900);
    //[scrollView  setCenter:CGPointMake(scrollView.center.x, scrollView.center.y - 62)];
    [self.view layoutSubviews];
    
}

-(void) singleTap: (UITapGestureRecognizer*)gesture {
    NSLog(@"TAP");
    [self turnOffActiveAspect];
}

- (void) turnOffActiveAspect {
    if([activeAspect isKindOfClass:[KragerPickerView class]]) {
        [activeAspect setHidden:YES];
    } else {
        [activeAspect resignFirstResponder];
    }
    
}

-(void) viewWillDisappear:(BOOL)animated {
    NSString* team = [[self.tabBarController.viewControllers objectAtIndex:0] getTeam];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    Firebase* ref = [[Firebase alloc] initWithUrl: [NSString stringWithFormat:@"https://friarscout.firebaseio.com/teams/%@/pit/auto/starting_locations",team]];
    
    //Starting Locations
    [dict setObject:[NSNumber numberWithBool:[self.byLandFillCheckBox getStatus]] forKey:@"by_landfill"];
    [dict setObject:[NSNumber numberWithBool:[self.byYellowToteCheckBox getStatus]] forKey:@"by_yellow_tote"];
    [dict setObject:[NSNumber numberWithBool:[self.immobileCheckBox getStatus]] forKey:@"immobile"];
    if([self.otherPosCheckBox getStatus]) {
         [dict setObject:self.otherPosTextField.text forKey:@"other"];
    }
    
    [ref updateChildValues:dict];
    dict = [[NSMutableDictionary alloc] init];
    
    //AUTO GOALS
    ref = [[Firebase alloc] initWithUrl: [NSString stringWithFormat:@"https://friarscout.firebaseio.com/teams/%@/pit/auto",team]];
    
    [dict setObject:[NSNumber numberWithBool:[self.robotMovedCheckBox getStatus]] forKey:@"robot_set"];
    
    if([self.totesMovedCheckBox getStatus]) {
        
        [dict setObject:[NSNumber numberWithInt:[self.totesMovedIntoZoneTextField.text intValue]] forKey:@"totes_in_zone"];
    }
    if([self.trashCanMovedCheckBox getStatus]) {
        [dict setObject:[NSNumber numberWithInt:[self.trashCansMovedIntoZoneTextField.text intValue]] forKey:@"cans_in_zone"];
    }

    if([self.trashCansFromMiddleCheckBox getStatus]) {
        [dict setObject:[NSNumber numberWithInt:[self.canRecievedFromMiddleTextField.text intValue]] forKey:@"step_cans"];

    }
    [dict setObject:[NSNumber numberWithBool:[self.totesStackedCheckBox getStatus]] forKey:@"tote_stack"];
    if([self.otherGoalsCheckBox getStatus]) {
        [dict setObject:self.otherGoalsTextField.text forKey:@"other"];
        
    }
    [ref updateChildValues:dict];
    
    
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
@end
