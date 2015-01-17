//
//  level1PitScoutViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 11/26/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "level1PitScoutViewController.h"
#import "kragerPickerView.h"
@interface level1PitScoutViewController ()
{
    UIImage *teamsImage;
    UITextField *activeTextField;
    IBOutlet UIImageView *teamImageView;
    IBOutlet UIScrollView *scrollView;
    Boolean pictureSelected;
    IBOutlet UIButton *imagePicker;
    
    IBOutlet UITextView *commentsTextView;
    IBOutlet UILabel *commentLabel;
    
    IBOutlet UIButton *addTeamButton;
}
@property (strong, nonatomic) IBOutlet kragerPickerView *drivePicker;
@property (strong, nonatomic) IBOutlet kragerPickerView *liftPicker;
@property (strong, nonatomic) IBOutlet kragerPickerView *intakePicker;


@property (strong, nonatomic) IBOutlet UITextField *teamTextField;
@property (strong, nonatomic) IBOutlet UITextField *driveTextField;
@property (strong, nonatomic) IBOutlet UITextField *liftTextField;
@property (strong, nonatomic) IBOutlet UITextField *intakeTextField;

@end

#define FONT_BEBAS_15 [UIFont fontWithName: @"Bebas Neue" size:15]
#define FONT_BEBAS_20 [UIFont fontWithName: @"Bebas Neue" size:20]
#define FONT_BEBAS_25 [UIFont fontWithName: @"Bebas Neue" size:25]
#define FONT_BEBAS_28 [UIFont fontWithName: @"Bebas Neue" size:28]

@implementation level1PitScoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)imagePicker:(id)sender {
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Connect data
    [self.drivePicker setData:@[@"4 Wheel", @"6 Cim", @"Holonomic", @"Tread", @"Swerve", @"Omni", @"Mechanum", @"Other"] textField: self.driveTextField];
    [self.intakePicker setData:@[@"lift", @"Item 2", @"Item 3", @"Item 4", @"Item 5", @"Other"] textField:self.intakeTextField];
    [self.liftPicker setData:@[@"shooter", @"Item 2", @"Item 3", @"Item 4", @"Item 5", @"Other"] textField:self.liftTextField];
    
    self.drivePicker.hidden = YES;
    self.intakePicker.hidden = YES;
    self.liftPicker.hidden = YES;
 
    commentsTextView.layer.cornerRadius = 5;
    commentsTextView.layer.borderWidth = 2;
    commentsTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    
    pictureSelected = false;
    
    [self teamTextField].placeholder = @"Team";
    [self driveTextField].placeholder = @"Drive";
    [self intakeTextField].placeholder = @"Lift";
    [self liftTextField].placeholder = @"Shooter";
    
    
    [self teamTextField].delegate = self;
    [self driveTextField].delegate = self;
    [self intakeTextField].delegate = self;
    [self liftTextField].delegate = self;
}

-(void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      FONT_BEBAS_28,
      NSFontAttributeName, nil]];
    self.title = @"Pit Scout";
    
    addTeamButton.titleLabel.font = FONT_BEBAS_25;
    commentLabel.font = FONT_BEBAS_25;
    imagePicker.titleLabel.font = FONT_BEBAS_25;
    [self teamTextField].font = FONT_BEBAS_20;
    [self intakeTextField].font = FONT_BEBAS_20;
    [self liftTextField].font = FONT_BEBAS_20;
    [self driveTextField].font = FONT_BEBAS_20;
    commentsTextView.font = FONT_BEBAS_20;
}

-(void)viewDidLayoutSubviews {
    
    scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, 320, self.view.frame.size.height);
    scrollView.contentSize = CGSizeMake(320, 700);
    [scrollView  setCenter:CGPointMake(scrollView.center.x, scrollView.center.y - 62)];
    
    
    
    [self.view layoutSubviews];
    
}

- (IBAction)addTeamButton:(id)sender {
    
    
    double filename = [[NSDate date] timeIntervalSince1970];
    NSNumber *myDoubleNumber = [NSNumber numberWithDouble:filename];
    NSString *stringOfFilename = [myDoubleNumber stringValue];
    
    NSString *lastFiveDigits = [stringOfFilename substringWithRange: NSMakeRange( stringOfFilename.length - 6, 5)];
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mrflark.org/frcscout/image-upload.php?filename=%@%@", lastFiveDigits, @".jpg"]];
    
    NSMutableData* data = [[NSMutableData alloc] init];
    
    UIImage* image = [UIImage imageNamed: @"mileymelon.jpg"];
    
    //NSString *noteDataString = [NSString stringWithFormat:@"filename="];
    //[data appendData: [noteDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    [data appendData:imageData];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setHTTPBody:imageData];
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *dataRaw, NSURLResponse *header, NSError *error) {
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:dataRaw
                              options:kNilOptions error:&error];
        
    }];
    
    [dataTask resume];
    
    //____________________________________________
    [self uploadTextWithImage: lastFiveDigits];
   

}
-(void) uploadTextWithImage:(NSString*) picFileName{
    NSString *picLocation = [NSString stringWithFormat:@"pictures/%@%@,",picFileName,@".jpg"];
    
    
    NSString *noteDataString = [NSString stringWithFormat:@"NUMBER=%@&PIC_LOC=&%@DRIVE=%@&SHOOTER=%@&INTAKE=%@&COMMENTS=%@", [self teamTextField].text, picLocation, self.driveTextField.text,self.liftTextField.text,self.intakeTextField.text,commentsTextView.text];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://mrflark.org/frcscout/ios-ps-upload.php"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setHTTPBody:[noteDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *dataRaw, NSURLResponse *header, NSError *error) {
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:dataRaw
                              options:kNilOptions error:&error];
        
    }];
    
    [dataTask resume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationController

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chooseImage = info[UIImagePickerControllerEditedImage];
    
    teamsImage = chooseImage;
    teamImageView.image = chooseImage;
    
    //do button later
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    activeTextField = textField;
    [scrollView setContentOffset:CGPointMake(activeTextField.center.x - scrollView.frame.size.width/2, activeTextField.center.y - scrollView.frame.size.height/4) animated:NO];
    if(activeTextField == [self driveTextField]){
        NSLog(@"x: %f",self.drivePicker.frame.origin.x);
        NSLog(@"y: %f",self.drivePicker.frame.origin.y);
        [self.drivePicker setCenter:CGPointMake(self.drivePicker.center.x, self.view.frame.size.height - 100)];
        [self.drivePicker setBackgroundColor:[UIColor whiteColor]];
        
        //[scrollView setScrollEnabled:NO];
        self.drivePicker.hidden = NO;
        NSLog(@"x: %f",self.drivePicker.frame.origin.x);
        NSLog(@"y: %f",self.drivePicker.frame.origin.y);
    }else if(activeTextField == [self intakeTextField]) {
        [self.intakePicker setCenter:CGPointMake(self.intakePicker.center.x, self.view.frame.size.height - 100)];
        [self.intakePicker setBackgroundColor:[UIColor whiteColor]];
        
        //[scrollView setScrollEnabled:NO];
        self.intakePicker.hidden = NO;
    }else if(activeTextField == [self liftTextField]) {
        [self.liftPicker setCenter:CGPointMake(self.liftPicker.center.x, self.view.frame.size.height - 100)];
        [self.liftPicker setBackgroundColor:[UIColor whiteColor]];
        
        //[scrollView setScrollEnabled:NO];
        self.liftPicker.hidden = NO;
    }
    return NO;
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
    activeTextField = textField;
    [scrollView setContentOffset:CGPointMake(activeTextField.center.x - scrollView.frame.size.width/2, activeTextField.center.y - scrollView.frame.size.height/4) animated:NO];
    
}
/*- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"g");
    activeTextField = textField;
    [scrollView setContentOffset:CGPointMake(activeTextField.center.x - scrollView.frame.size.width/2, activeTextField.center.y - scrollView.frame.size.height/4) animated:NO];
}*/




@end
