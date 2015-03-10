//
//  level1AutonomousViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/19/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "Level1MatchAutoViewController.h"
#import"KragerPickerView.h"
#import "CheckBoxLabel.h"
#import "KragerSwitchView.h"
#import <Firebase/Firebase.h>
@interface Level1MatchAutoViewController () {
    bool textFieldShouldEdit;
    UITextField *activeTextField;
    id activeAspect;
    IBOutlet UIScrollView* scrollView;
    NSString* team;
    NSString* matchNum;
    __block bool foundFirstUnplayedMatch;
    __block int match;
}
//Starting Pos
@property (strong, nonatomic) IBOutlet UITextField *teamTextField;
//checkBoxes
@property (strong, nonatomic) IBOutlet UITextField *matchNumTextField;
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

@property (strong, nonatomic) IBOutlet KragerPickerView *autoPicker;


@end
#define FONT_BEBAS_15 [UIFont fontWithName: @"Bebas Neue" size:15]
#define FONT_BEBAS_20 [UIFont fontWithName: @"Bebas Neue" size:20]
#define FONT_BEBAS_25 [UIFont fontWithName: @"Bebas Neue" size:25]
#define FONT_BEBAS_28 [UIFont fontWithName: @"Bebas Neue" size:28]
@implementation Level1MatchAutoViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.title = @"Autonomous";
    [self setFonts];
    [self setDelegates];
    foundFirstUnplayedMatch = false;
    match = 1;
    
}

-(void) viewDidLoad {
    [super viewDidLoad];
    
    [[self autoPicker] setHidden:YES];
    [[self autoPicker] setCenter:CGPointMake(self.autoPicker.frame.origin.x + self.autoPicker.frame.size.width/2, self.view.frame.size.height - 150)];
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.enabled = YES;
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:singleTapGestureRecognizer];
    
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    [self setData];
    
    [self fetchTeamAndMatch];
    team = self.teamTextField.text;
    matchNum = self.matchNumTextField.text;
}

-(void) fetchTeamAndMatch {
    
    
    
    //while(!foundFirstUnplayedMatch) {
        Firebase *ref = [[Firebase alloc]initWithUrl:
                         [NSString stringWithFormat:@"https://friarscout.firebaseio.com/matches" ]];
        
        [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            //NSLog(@"TEST %@", snapshot.value[@"played"]);
            //NSLog(@"CAN WE DO THIS? %@", snapshot.value[@"played"]);
            //false
            NSLog(@"HE %@", [snapshot childSnapshotForPath:@"1"].value[@"played"]);
            /*@try {
                if(![snapshot.value[@"played"] boolValue] && !foundFirstUnplayedMatch) {
                    int curMatch = i;
                    foundFirstUnplayedMatch = true;
                    self.matchNumTextField.text = [NSString stringWithFormat:@"d %d", curMatch];
                    
                    foundFirstUnplayedMatch = true;
                    //i = 205;
                }
            }@catch(NSException* e) {
                if(!foundFirstUnplayedMatch) {
                    int curMatch = i;
                    foundFirstUnplayedMatch = true;
                    self.matchNumTextField.text = [NSString stringWithFormat:@"d %d", curMatch];
                    
                    foundFirstUnplayedMatch = true;
                    //i = 205;
                    
                }
            }*/
        }];
   // }
    //}
}
-(void) viewWillDisappear:(BOOL)animated {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    Firebase* ref = [[Firebase alloc] initWithUrl: [NSString stringWithFormat:@"https://friarscout.firebaseio.com/teams/%@/match/%@/auto", team, matchNum]];
    
    //Starting Locations
    if([self.byLandFillCheckBox getStatus]) {
        [dict setObject:@"By Landfill" forKey:@"starting_location"];
    }
    if([self.byYellowToteCheckBox getStatus]) {
        [dict setObject:@"By Yellow Totes" forKey:@"starting_location"];
    }
    if([self.immobileCheckBox getStatus]) {
        [dict setObject:@"Immobile" forKey:@"starting_location"];
    }
    if([self.otherPosCheckBox getStatus]) {
        [dict setObject:self.otherPosTextField.text forKey:@"starting_location"];
    }
    
    //GOALS
    [dict setObject:[NSNumber numberWithBool:[self.robotMovedCheckBox getStatus]] forKey:@"robot set"];
    
    if([self.totesMovedCheckBox getStatus]) {
        
        [dict setObject:[NSNumber numberWithInt:[[self.autoPicker getSelectedItem] intValue]] forKey:@"totes_in_zone"];
    }
    if([self.trashCanMovedCheckBox getStatus]) {
        [dict setObject:[NSNumber numberWithInt:[[self.autoPicker getSelectedItem] intValue]] forKey:@"cans_in_zone"];
    }
    
    if([self.trashCansFromMiddleCheckBox getStatus]) {
        [dict setObject:[NSNumber numberWithInt:[[self.autoPicker getSelectedItem] intValue]] forKey:@"step_cans"];
        
    }
    if([self.totesStackedCheckBox getStatus]) {
        [dict setObject:[NSNumber numberWithInt:[[self.autoPicker getSelectedItem] intValue]] forKey:@"tote_stack"];
        
    }
    
    if([self.otherGoalsCheckBox getStatus]) {
        [dict setObject:self.otherGoalsTextField.text forKey:@"other"];
        
    }
    [ref updateChildValues:dict];
    
    
}
-(void) setFonts {
    //the box will show up when user clicks checkbox
    [[self otherPosTextField] setHidden:YES];
    [[self otherPosTextField] setPlaceholder:@"Other"];
    [[self otherGoalsTextField] setHidden:YES];
    [[self otherGoalsTextField] setPlaceholder:@"Other"];
    self.teamTextField.placeholder = @"Team";
    [self.matchNumTextField setPlaceholder:@"MatchNum"];
    
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
    
    [[self totesStackedCheckBox] setHiddenObject:[self autoPicker]];
    [[self totesMovedCheckBox] setHiddenObject:[self autoPicker]];
    [[self trashCansFromMiddleCheckBox] setHiddenObject:[self autoPicker]];
    [[self trashCanMovedCheckBox] setHiddenObject:[self autoPicker]];
}


-(void) setData {
    [[self otherPosCheckBox] setHiddenObject:[self otherPosTextField]];
    [[self otherGoalsCheckBox] setHiddenObject:[self otherGoalsTextField]];
    [[self autoPicker] setData:@[@"1",@"2",@"3",@"4",@"5"] textField:nil withController:self withCode:@"auto_number"];
    NSMutableArray *startPosArray = [NSMutableArray arrayWithArray:@[self.byLandFillCheckBox, self.byYellowToteCheckBox, self.immobileCheckBox, self.otherPosCheckBox]];
    RadioButtonGroup *startingPosRadioGroup =
    [[RadioButtonGroup alloc] initWithCheckBoxes:startPosArray];
    NSMutableArray *autoOptions = [NSMutableArray arrayWithArray:@[self.robotMovedCheckBox, self.totesMovedCheckBox, self.trashCanMovedCheckBox, self.trashCansFromMiddleCheckBox, self.totesStackedCheckBox, self.otherGoalsCheckBox]];
    RadioButtonGroup *autoOptionsRadioGroup = [[RadioButtonGroup alloc] initWithCheckBoxes:autoOptions];
}

-(void) setDelegates {
    [self otherPosTextField].delegate = self;
    [self otherGoalsTextField].delegate = self;
}
- (IBAction)accomplishSwitch:(KragerSwitchView *)sender {
    
}

-(void) viewDidLayoutSubviews {
    scrollView.frame = CGRectMake(scrollView.frame.origin.x, 63, 320, self.view.frame.size.height);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
    //[scrollView  setCenter:CGPointMake(scrollView.center.x, scrollView.center.y - 62)];
    [self.view layoutSubviews];
}
- (IBAction)totesMovedCheckBox:(id)sender {
    [self pickerSetTo: (CheckBoxLabel*) self.totesMovedCheckBox];
}
- (IBAction)trashCansMovedCheckBox:(id)sender {
    [self pickerSetTo: (CheckBoxLabel*) self.trashCanMovedCheckBox];
}
- (IBAction)trashCansFromMiddleCheckBox:(id)sender {
    [self pickerSetTo: (CheckBoxLabel*) self.trashCansFromMiddleCheckBox];
}

- (void) pickerSetTo:(CheckBoxLabel*) checkBox {
    [self.autoPicker setHidden:NO];
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
    return YES;
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
