//
//  level1PitScoutViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 11/26/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "level1PitScoutViewController.h"
#import "kragerPickerView.h"
#import "JSONObject.h"
@interface level1PitScoutViewController ()
{
    id activeAspect;
    UIImage *teamsImage;
    UITextField *activeTextField;
    IBOutlet UIImageView *teamImageView;
    IBOutlet UIScrollView *scrollView;
    Boolean pictureSelected;
    IBOutlet UIButton *imagePicker;
    IBOutlet UIButton * imageTaker;
    
    IBOutlet UITextView *commentsTextView;
    IBOutlet UILabel *commentLabel;
    
    IBOutlet UIButton *addTeamButton;
    bool textFieldShouldEdit;
    UIImage *chooseImage;
    
    NSMutableData* data;
    NSUInteger byteIndex;
    }

//ROBOT SPECS
@property (strong, nonatomic) IBOutlet UILabel *robotSpecsLabel;
@property (strong, nonatomic) IBOutlet UITextField *weightTextField;
@property (strong, nonatomic) IBOutlet UITextField *heightTextField;


//DRIVE TRAIN
@property (strong, nonatomic) IBOutlet UILabel *driveTrainLabel;
@property (strong, nonatomic) IBOutlet UITextField *driveTextField;
@property (strong, nonatomic) IBOutlet kragerPickerView *drivePicker;
@property (strong, nonatomic) IBOutlet kragerPickerView * cimPicker;
@property (strong, nonatomic) IBOutlet kragerPickerView *frameStrengthPicker;
@property (strong, nonatomic) IBOutlet UISwitch *twoSpeedSlider;
@property (strong, nonatomic) IBOutlet UILabel *oneSpeedLabel;
@property (strong, nonatomic) IBOutlet UILabel *twoSpeedLabel;
@property (strong, nonatomic) IBOutlet UITextField *cimTextField;
@property (strong, nonatomic) IBOutlet UITextField *maxSpeedTextField;
@property (strong, nonatomic) IBOutlet UITextField *frameStrengthTextField;


//LIFT SYSTEM
@property (strong, nonatomic) IBOutlet kragerPickerView *liftPicker;
@property (strong, nonatomic) IBOutlet UITextField *liftTextField;
@property (strong, nonatomic) IBOutlet UITextField *maxTotesAtOneTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *maxToteHeightTextField;
@property (strong, nonatomic) IBOutlet UITextField *maxCanHeightTextField;
@property (strong, nonatomic) IBOutlet UILabel *liftSystemLabel;
@property (strong, nonatomic) IBOutlet UILabel *internalLabel;
@property (strong, nonatomic) IBOutlet UILabel *externalLabel;


//INTAKE SYSTEM
@property (strong, nonatomic) IBOutlet kragerPickerView *intakePicker;
@property (strong, nonatomic) IBOutlet UITextField *intakeTextField;
@property (strong, nonatomic) IBOutlet UILabel *intakeSystemLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *noYesLabels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *intakeLabels;




//MISC
@property (strong, nonatomic) IBOutlet UITextField *teamTextField;


@end

#define FONT_BEBAS_15 [UIFont fontWithName: @"Bebas Neue" size:15]
#define FONT_BEBAS_20 [UIFont fontWithName: @"Bebas Neue" size:20]
#define FONT_BEBAS_25 [UIFont fontWithName: @"Bebas Neue" size:25]
#define FONT_BEBAS_28 [UIFont fontWithName: @"Bebas Neue" size:28]
static level1PitScoutViewController* instance;

@implementation level1PitScoutViewController

+ (level1PitScoutViewController*)getInstance {
    return instance;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        instance = self;
    }
    return self;
}
- (IBAction)imageTaker:(id)sender {
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}
- (IBAction)imagePicker:(id)sender {
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

//DO THESE WHEN ADDING NEW PICKER
- (void) setAllPickersHidden {
    self.drivePicker.hidden = YES;
    self.intakePicker.hidden = YES;
    self.liftPicker.hidden = YES;
    self.cimPicker.hidden = YES;
    self.frameStrengthPicker.hidden = YES;
}
-(void) addDataToPickers {
    // Connect data
    [self.drivePicker setData:@[@"Swerve", @"Tank", @"Slide", @"Mecanum", @"Butterfly", @"Octanum", @"Nonum", @"Holonomic", @"Other"] textField: self.driveTextField withController:self];
    [self.intakePicker setData:@[@"intake", @"Item 2", @"Item 3", @"Item 4", @"Item 5", @"Other"] textField:self.intakeTextField withController:self];
    [self.liftPicker setData:@[@"lift", @"Item 2", @"Item 3", @"Item 4", @"Item 5", @"Other"] textField:self.liftTextField withController:self];
    [self.cimPicker setData:@[@"2CIM", @"3CIM", @"4IM"] textField:[self cimTextField] withController:self];
    [self.frameStrengthPicker setData:@[@"1",@"2",@"3",@"4"] textField: self.frameStrengthTextField withController:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.enabled = YES;
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:singleTapGestureRecognizer];
    
    textFieldShouldEdit = false;
    
    
    
    [self setAllPickersHidden];
    [self addDataToPickers];
 
    commentsTextView.layer.cornerRadius = 5;
    commentsTextView.layer.borderWidth = 2;
    commentsTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    
    pictureSelected = false;
    
    [self teamTextField].placeholder = @"Team";
    [self driveTextField].placeholder = @"Drive";
    [self intakeTextField].placeholder = @"Intake";
    [self liftTextField].placeholder = @"Lift";
    [self cimTextField].placeholder = @"CIM";
    [self heightTextField].placeholder = @"Height";
    [self weightTextField].placeholder = @"Weight";
    [self maxSpeedTextField].placeholder = @"Max Speed";
    [self frameStrengthTextField].placeholder = @"Frame Strength";
    [self maxCanHeightTextField].placeholder = @"Can Stack Height";
    [self maxToteHeightTextField].placeholder = @"Tote Stack Height";
    [self maxTotesAtOneTimeTextField].placeholder = @"Max Tote";
    
    
    /*[commentsTextView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeInteractive];
    commentsTextView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;*/
    
    [self teamTextField].keyboardType = UIKeyboardTypeNumberPad;
    [self weightTextField].keyboardType = UIKeyboardTypeNumberPad;
    [self heightTextField].keyboardType = UIKeyboardTypeNumberPad;
    [self maxSpeedTextField].keyboardType = UIKeyboardTypeNumberPad;
    [[self maxTotesAtOneTimeTextField]setKeyboardType:UIKeyboardTypeNumberPad];
    [self maxToteHeightTextField].keyboardType = UIKeyboardTypeNumberPad;
    [self maxCanHeightTextField].keyboardType = UIKeyboardTypeNumberPad;
    
    [self teamTextField].delegate = self;
    [self driveTextField].delegate = self;
    [self intakeTextField].delegate = self;
    [self liftTextField].delegate = self;
    [self cimTextField].delegate = self;
    [self heightTextField].delegate = self;
    [self weightTextField].delegate = self;
    [self maxSpeedTextField].delegate = self;
    [self maxToteHeightTextField].delegate = self;
    [self maxTotesAtOneTimeTextField].delegate = self;
    [self maxCanHeightTextField].delegate = self;
    [self frameStrengthTextField].delegate = self;
    commentsTextView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    NSLog(@"VIEW WILL DIS");
    [self setAllPickersHidden];
}

-(void) viewWillAppear:(BOOL)animated {
    NSLog(@"VIEW WILL APP");
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      FONT_BEBAS_28,
      NSFontAttributeName, nil]];
    self.tabBarController.title = @"Robot Specs";
    
    [self setFonts];
    }

-(void)viewDidLayoutSubviews {
    NSLog(@"LAYED OUT");
    scrollView.frame = CGRectMake(scrollView.frame.origin.x, 0, 320, self.view.frame.size.height);
    scrollView.contentSize = CGSizeMake(320, 1600);
    //[scrollView  setCenter:CGPointMake(scrollView.center.x, scrollView.center.y - 62)];
    [self.view layoutSubviews];
    
}

-(void) setFonts {
    addTeamButton.titleLabel.font = FONT_BEBAS_25;
    commentLabel.font = FONT_BEBAS_25;
    imagePicker.titleLabel.font = FONT_BEBAS_25;
    imageTaker.titleLabel.font = FONT_BEBAS_25;
    [self liftSystemLabel].font = FONT_BEBAS_28;
    [self teamTextField].font = FONT_BEBAS_20;
    [self intakeTextField].font = FONT_BEBAS_20;
    [self liftTextField].font = FONT_BEBAS_20;
    [self driveTextField].font = FONT_BEBAS_20;
    [self cimTextField].font = FONT_BEBAS_20;
    [self weightTextField].font = FONT_BEBAS_20;
    [self heightTextField].font = FONT_BEBAS_20;
    [self maxSpeedTextField].font = FONT_BEBAS_20;
    [self frameStrengthTextField].font = FONT_BEBAS_20;
    [self driveTrainLabel].font = FONT_BEBAS_28;
    [self robotSpecsLabel].font = FONT_BEBAS_28;
    [self oneSpeedLabel].font = FONT_BEBAS_20;
    [self twoSpeedLabel].font = FONT_BEBAS_20;
    [self maxCanHeightTextField].font
    = FONT_BEBAS_20;
    [self maxToteHeightTextField].font = FONT_BEBAS_20;
    [self maxTotesAtOneTimeTextField].font = FONT_BEBAS_20;
    [self internalLabel].font = FONT_BEBAS_20;
    [self externalLabel].font = FONT_BEBAS_20;
    [self intakeSystemLabel].font =
    FONT_BEBAS_28;
    for(int i = 0; i < [self noYesLabels].count; i++) {
        NSLog(@"%d", i);
        NSLog(@"%lu", (unsigned long)[self noYesLabels].count);
        [[[self noYesLabels] objectAtIndex: i] setFont : FONT_BEBAS_20];
    }
    for(int i = 0; i < [self intakeLabels].count; i++) {
        [[[self intakeLabels] objectAtIndex:i] setFont: FONT_BEBAS_25];
    }
    commentsTextView.font = FONT_BEBAS_20;
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
- (IBAction)addTeamButton:(id)sender {
    
    CFReadStreamRef rstream;
    CFWriteStreamRef wstream;
    
    //connect to server
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"mrflark.org", 3309, &rstream, &wstream);
    NSLog(@"connected to server");
    
    //init i/o with server
    NSInputStream* is = objc_unretainedObject(rstream);
    [is scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [is open];
    
    NSOutputStream* os = objc_unretainedObject(wstream);
    
    
    
    [os scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [os open];
    
 
    NSLog(@"%lu",(unsigned long)[UIImagePNGRepresentation(chooseImage) length]);
    
    //[data appendData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
#warning DID NOT COMPLETE SWITCHES, THE FIRST MAX SPEED SHOULD BE ONE SPEED, TWO SPEED
    //NSString *toSend = [NSString stringWithFormat:@"{status:2,cmd:\"add team\",team_number:%@,weight:%@,height:%@,speed:%@,cim:\"%@\",drivetrain:\"%@\",lift:\"%@\",max_speed:%@,frame_strength:%@,max_tote:%@,tote_stack_height:%@,can:%@,image_size:%lu}", [self teamTextField].text, [self weightTextField].text, [self heightTextField].text, [self maxSpeedTextField].text, [self cimTextField].text, [self driveTextField].text, [self liftTextField].text, [self maxSpeedTextField].text, [self frameStrengthTextField].text, [self maxTotesAtOneTimeTextField].text, [self maxToteHeightTextField].text, [self maxCanHeightTextField].text, (unsigned long)[UIImagePNGRepresentation(chooseImage) length]];
    JSONObject *sendingData = [[JSONObject alloc] init];
    [sendingData addObject:[NSNumber numberWithInt:2] forKey:@"status"];
    [sendingData addObject:@"add team" forKey:@"cmd"];
    [sendingData addObject:self.teamTextField.text forKey:@"team_number"];
    [sendingData addObject:self.weightTextField.text forKey:@"weight"];
    [sendingData addObject:self.heightTextField.text forKey:@"height"];
    [sendingData addObject:self.maxSpeedTextField.text forKey:@"speed"];
    [sendingData addObject:self.cimTextField.text forKey:@"cim"];
    [sendingData addObject:self.driveTextField.text forKey:@"drivetrain"];
    [sendingData addObject:self.liftTextField.text forKey:@"lift"];
#warning boolean using nsnumber value
    [sendingData addObject:[NSNumber numberWithBool:[self.twoSpeedSlider isOn]]  forKey:@"max_speed"];
    [sendingData addObject:self.frameStrengthTextField.text forKey:@"frame_strength"];
    [sendingData addObject:self.maxTotesAtOneTimeTextField.text forKey:@"max_tote"];
    [sendingData addObject:self.maxToteHeightTextField.text forKey:@"tote_stack_height"];
    [sendingData addObject:self.maxCanHeightTextField.text forKey:@"can"];
    [sendingData addObject:[NSNumber numberWithLong: [UIImagePNGRepresentation(chooseImage) length]] forKey:@"image_size"];
    
    NSString* toSend = [sendingData getJSONString];
    NSLog(@"%@",toSend);
    
    // NSString *toSend = [NSString stringWithFormat:@"]
    
    data = [NSMutableData dataWithData:[toSend dataUsingEncoding:NSUTF8StringEncoding]];
    const uint8_t* bytesString = (const uint8_t*)[data bytes];
    [os write:bytesString maxLength:[data length]];
    
    data = [NSMutableData dataWithData:UIImagePNGRepresentation(chooseImage)];
    
    NSUInteger len = [data length];
    Byte* byteData = (Byte*)malloc(len);
    [data getBytes:byteData length:len];
    
    //[os write:byteData maxLength:len];
    byteIndex = 0;
    //worked last time
    while(byteIndex < [data length]) {
        uint8_t *readBytes = (uint8_t *)[data mutableBytes];
        readBytes += byteIndex; // instance variable to move pointer
        NSUInteger data_len = [data length];
        unsigned long len = ((data_len - byteIndex >= 1024) ?
                            1024 : (data_len-byteIndex));
        uint8_t buf[len];
        (void)memcpy(buf, readBytes, len);
        len = [(NSOutputStream*)os write:(const uint8_t *)buf maxLength:len];
        byteIndex += len;

    }
    
    NSLog(@"loading image...");
    NSLog(@"image loaded");
    NSLog(@"sent data");
    
    [is close];
    [os close];
   
}

-(void)textFieldShouldBeEditable: (UITextField*)field {
    textFieldShouldEdit = true;
    
    
    [field becomeFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationController

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSLog(@"Runnin");
    chooseImage = info[UIImagePickerControllerEditedImage];
    
    teamsImage = chooseImage;
    teamImageView.image = chooseImage;
    
    
    //do button later
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
    if(([self drivePicker].hidden == NO || [self intakePicker].hidden == NO || [self liftPicker].hidden == NO || [self cimPicker].hidden == NO || [self frameStrengthPicker].hidden == NO)) {
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
        [commentsTextView resignFirstResponder];
        
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


