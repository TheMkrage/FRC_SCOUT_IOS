//
//  level1PitTeleopViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/27/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "level1PitTeleopViewController.h"
#import "kragerPickerView.h"
#import "checkBoxLabel.h"

@interface level1PitTeleopViewController () {
    IBOutlet UIScrollView *scrollView;
    bool textFieldShouldEdit;
    UITextField *activeTextField;
    id activeAspect;
}
@property (strong, nonatomic) IBOutlet UITextField *cooperationTextField;
@property (strong, nonatomic) IBOutlet kragerPickerView *cooperationPicker;

@property (strong, nonatomic) IBOutlet UITextView *strategyTextView;


@end

@implementation level1PitTeleopViewController

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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    NSLog(@"LAYED OUT");
    scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, 320, self.view.frame.size.height);
    scrollView.contentSize = CGSizeMake(320, 1600);
   
    [self.view layoutSubviews];
    
}

-(void) setFonts {
    
}

-(void) setData {
    [[self cooperationPicker] setData:@[@"None",@"Stacked",@"Not Stacked"] textField:[self cooperationTextField] withController:self];
    
    [self cooperationTextField].placeholder = @"Cooperation";
}

-(void) setDelegates {
    [self cooperationTextField].delegate = self;
}

-(void) singleTap:(UITapGestureRecognizer*)gesture {
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

- (void) setAllPickersHidden {
    self.cooperationPicker.hidden = YES;
}

#pragma mark - UITextFieldDelegate
-(BOOL) textFieldShouldBeActive: (kragerPickerView*) picker {
    [picker setCenter:CGPointMake(picker.frame.origin.x + picker.frame.size.width/2, self.view.frame.size.height - 150)];
    [picker setBackgroundColor:[UIColor whiteColor]];
    NSLog(@":ACTIVEFADSFASDFASDFADS");
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
    if(([self cooperationPicker].hidden == NO)) {
        activeAspect = NULL;
        if([self cooperationPicker].hidden == NO) {
            [[self cooperationPicker] setSelectedValueToTextField];
        }
        [self setAllPickersHidden];
        
        
    }
    if(activeTextField == [self cooperationTextField]){
        return [self textFieldShouldBeActive: self.cooperationPicker];
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



@end
