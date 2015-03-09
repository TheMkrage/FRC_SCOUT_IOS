//
//  LeadScoutViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 3/8/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "LeadScoutViewController.h"

@interface LeadScoutViewController ()
@property (strong, nonatomic) IBOutlet UITextField *markMatchAsPlayedTextField;
@property (strong, nonatomic) IBOutlet UITextField *markMatchAsNotPlayedTextField;
@property (strong, nonatomic) IBOutlet UIButton *markMatchAsPlayedButton;
@property (strong, nonatomic) IBOutlet UIButton *markMatchAsNotPlayedButton;
@property (strong, nonatomic) UITextField* activeAspect;
@end

@implementation LeadScoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.markMatchAsNotPlayedTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.markMatchAsPlayedTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.enabled = YES;
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    
    /*self.markMatchAsNotPlayedTextField.delegate = self;
    self.markMatchAsPlayedTextField.delegate =self;*/
}
- (IBAction)markMatchAsPlayed:(id)sender {
    //WAS HERE
}

-(void) singleTap: (UITapGestureRecognizer*)gesture {
    NSLog(@"TAP");
    [self turnOffActiveAspect];
}
- (void) turnOffActiveAspect {
        [self.activeAspect resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.activeAspect = textField;
    return YES;
}
@end
