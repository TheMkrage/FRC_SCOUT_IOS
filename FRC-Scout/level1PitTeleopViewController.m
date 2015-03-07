//
//  level1PitTeleopViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/27/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "Level1PitTeleopViewController.h"
#import "KragerPickerView.h"
#import "CheckBoxLabel.h"

@interface Level1PitTeleopViewController () {
    IBOutlet UIScrollView *scrollView;
    bool textFieldShouldEdit;
    UITextField *activeTextField;
    id activeAspect;
}
@property (strong, nonatomic) IBOutlet UITextField *cooperationTextField;
@property (strong, nonatomic) IBOutlet KragerPickerView *cooperationPicker;
@property (strong, nonatomic) IBOutlet UITextField *preferredTextField;
@property (strong, nonatomic) IBOutlet KragerPickerView *preferredPicker;

@property (strong, nonatomic) IBOutlet UITextView *strategyTextView;
@property (strong, nonatomic) IBOutlet UIScrollView *humanPlayerBoyGirlSwitch;
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
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.enabled = YES;
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:singleTapGestureRecognizer];
    
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    [self setData];
    
    self.strategyTextView.layer.cornerRadius = 5;
    self.strategyTextView.layer.borderWidth = 2;
    self.strategyTextView.layer.borderColor = [[UIColor grayColor] CGColor];

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
    /*[[self cooperationPicker] setData:@[@"None",@"Stacked",@"Not Stacked"] textField:[self cooperationTextField] withController:self];
    [[self preferredPicker] setData:@[@"Totes",@"Cans",@"Noodles",@"Cooperation",@"Other"] textField:[self preferredTextField] withController:self];
    */
    [self cooperationTextField].placeholder = @"Cooperation";
    [self preferredTextField].placeholder = @"Preferred Scoring";
}

-(void) setDelegates {
    [self cooperationTextField].delegate = self;
    [self preferredTextField].delegate = self;
    [self strategyTextView].delegate = self;
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

- (void) setAllPickersHidden {
    self.cooperationPicker.hidden = YES;
    self.preferredPicker.hidden = YES;
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
    if(([self cooperationPicker].hidden == NO || [self preferredPicker].hidden == NO)) {
        activeAspect = NULL;
        if([self cooperationPicker].hidden == NO) {
            [[self cooperationPicker] setSelectedValueToTextField];
        }else if([self preferredPicker].hidden == NO) {
            [[self preferredPicker] setSelectedValueToTextField];
        }
        [self setAllPickersHidden];
    }
    
    if(activeTextField == [self cooperationTextField]){
        return [self textFieldShouldBeActive: self.cooperationPicker];
    }else if(activeTextField == [self preferredTextField]){
        return [self textFieldShouldBeActive: self.preferredPicker];
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

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if(!(textView == activeAspect)) {
        [self turnOffActiveAspect];
        activeAspect = textView;
    }
    [scrollView setContentOffset:CGPointMake(0, ((UITextView*)activeAspect).center.y - scrollView.frame.size.height/4) animated:YES];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
    NSLog(@"STOP");
    [textView resignFirstResponder];
    return YES;
}


@end
