//
//  level1PitMiscViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/29/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "level1PitMiscViewController.h"
#import "kragerPickerView.h"

@interface level1PitMiscViewController ()
{
    id activeAspect;
    IBOutlet UIScrollView *scrollView;
    
}
@property (strong, nonatomic) IBOutlet UITextView *commentsTextView;

@end

@implementation level1PitMiscViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.enabled = YES;
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:singleTapGestureRecognizer];

    
    [self commentsTextView].delegate = self;
    self.commentsTextView.layer.cornerRadius = 5;
    self.commentsTextView.layer.borderWidth = 2;
    self.commentsTextView.layer.borderColor = [[UIColor grayColor] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    NSLog(@"LAYED OUT");
    scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, 320, self.view.frame.size.height);
    scrollView.contentSize = CGSizeMake(320, 800);
    //[scrollView  setCenter:CGPointMake(scrollView.center.x, scrollView.center.y - 62)];
    [self.view layoutSubviews];
    
}

-(void) singleTap: (UITapGestureRecognizer*)gesture {
    NSLog(@"TAP");
    [self turnOffActiveAspect];
}
- (void) turnOffActiveAspect {
    if([activeAspect isKindOfClass:[kragerPickerView class]]) {
        [activeAspect setHidden:YES];
    } else {
        NSLog(@"STOP");
        [activeAspect resignFirstResponder];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
