//
//  level1PitTeleopViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/27/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "Level1PitTeleopViewController.h"
#import "KragerPickerView.h"
#import "Level1PitScoutViewController.h"
#import "CheckBoxLabel.h"
#import <Firebase/Firebase.h>

@interface Level1PitTeleopViewController () {
    IBOutlet UIScrollView *scrollView;
    bool textFieldShouldEdit;
    UITextField *activeTextField;
    id activeAspect;
    NSString* team;
}
@property (strong, nonatomic) IBOutlet UITextField *cooperationTextField;
@property (strong, nonatomic) IBOutlet UITextField *preferredTextField;
@property (strong, nonatomic) IBOutlet UISwitch *humanPlayerNoodlesSwitch;


@end

@implementation Level1PitTeleopViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.title = @"Teleop";
    [self setFonts];
    [self setDelegates];
    [self setAllPickersHidden];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    team = [[self.tabBarController.viewControllers objectAtIndex:0] getTeam];
    NSLog(@"%@", team);
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.enabled = YES;
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:singleTapGestureRecognizer];
    
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    [self setData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidLayoutSubviews {
    scrollView.frame = CGRectMake(scrollView.frame.origin.x, 63, 320, self.view.frame.size.height);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 63);
    //[scrollView  setCenter:CGPointMake(scrollView.center.x, scrollView.center.y - 62)];
    [self.view layoutSubviews];
}

-(void) setFonts {
    
}

-(void) setData {
    Firebase* ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://friarscout.firebaseio.com/teams/%@/pit/teleop",team]];
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        @try {
            self.preferredTextField.text = snapshot.value[@"preferred_scoring"];
            self.cooperationTextField.text = snapshot.value[@"coop"];
            [self.humanPlayerNoodlesSwitch setOn:[snapshot.value[@"hp_throw_noodles"] boolValue] animated:YES];
        }@catch (NSException* e) {
            
        }
    }];
    [self cooperationTextField].placeholder = @"Cooperation";
    [self preferredTextField].placeholder = @"Preferred Scoring";
}

-(void) setDelegates {
    [self cooperationTextField].delegate = self;
    [self preferredTextField].delegate = self;
}

-(void) singleTap:(UITapGestureRecognizer*)gesture {
    
    [self turnOffActiveAspect];
}

- (void) turnOffActiveAspect {
    if([activeAspect isKindOfClass:[KragerPickerView class]]) {
        [activeAspect setHidden:YES];
    } else {
        [activeAspect resignFirstResponder];
        NSLog(@"TAP");
    }
}
- (IBAction)humanPlayerSwitch:(UISwitch *)sender {
    NSLog(@"DSGA %hhd", sender.isOn);
    Firebase* ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://friarscout.firebaseio.com/teams/%@/pit/teleop/hp_throw_noodles", team]];
    [ref setValue:[NSNumber numberWithBool:sender.isOn]];
        
}

- (void) setAllPickersHidden {
}
-(void)textFieldShouldBeEditable: (UITextField*)field {
    textFieldShouldEdit = true;
    [field becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate

-(BOOL) textFieldShouldBeActive: (KragerPickerView*) picker {
    [picker setCenter:CGPointMake(picker.frame.origin.x + picker.frame.size.width/2, self.view.frame.size.height - 150)];
    [picker setBackgroundColor:[UIColor whiteColor]];
    //NSLog(@":ACTIVEFADSFASDFASDFADS");
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
    NSLog(@"GFD");
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"fds");
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSLog(@"ENDED");
    if(textField == self.cooperationTextField) {
        Firebase* ref = [[Firebase alloc]initWithUrl:[NSString stringWithFormat:@"https://friarscout.firebaseio.com/teams/%@/pit/teleop/coop", team]];
        [ref setValue:self.cooperationTextField.text];
    }else if(textField == self.preferredTextField) {
        Firebase* ref = [[Firebase alloc]initWithUrl:[NSString stringWithFormat:@"https://friarscout.firebaseio.com/teams/%@/pit/teleop/preferred_scoring", team]];
        [ref setValue:self.preferredTextField.text];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"SELECTED");
    
    activeTextField = textField;
}


@end
