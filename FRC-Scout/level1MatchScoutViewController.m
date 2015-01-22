//
//  level1MatchScoutViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 11/26/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "level1MatchScoutViewController.h"
#import "kragerStepperView.h"

@interface level1MatchScoutViewController () {
    
    IBOutlet kragerStepperView *stackedTotesStepper;
    IBOutlet kragerStepperView *stackedCansStepper;
    IBOutlet kragerStepperView *maxStackStepper;
    IBOutlet kragerStepperView *numberOfStacksStepper;
    IBOutlet kragerStepperView *numberOfNoodlesStepper;
    IBOutlet UITextView *commentsTextView;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *matchTextField;
    IBOutlet UILabel *afterUploadMessageLabel;
    IBOutlet UIButton *nextToMatch;
}
@property (strong, nonatomic) IBOutlet UITextField *teamTextField;

@end
#define FONT_BEBAS_15 [UIFont fontWithName: @"Bebas Neue" size:15]
#define FONT_BEBAS_25 [UIFont fontWithName: @"Bebas Neue" size:25]
#define FONT_BEBAS_28 [UIFont fontWithName: @"Bebas Neue" size:28]

@implementation level1MatchScoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    commentsTextView.layer.cornerRadius = 5;
    commentsTextView.layer.borderWidth = 2;
    commentsTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    afterUploadMessageLabel.hidden=YES;
    [self teamTextField].placeholder = @"Team";
    matchTextField.placeholder = @"MatchNumber";
    
	// Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      FONT_BEBAS_28,
      NSFontAttributeName, nil]];
    self.tabBarController.title = @"Match Scout";
}

-(void)viewDidLayoutSubviews {
    scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, 320, self.view.frame.size.height - 102);
    scrollView.contentSize = CGSizeMake(320, 800);
    //[scrollView  setCenter:CGPointMake(scrollView.center.x, scrollView.center.y)];
    //[nextToMatch setFrame:CGRectMake(nextToMatch.frame.origin.x, self.view.frame.size.height - 40, nextToMatch.frame.size.width, nextToMatch.frame.size.height)];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)uploadButton:(UIButton *)sender {
    __block int status = -1;
    NSString *noteDataString = [NSString stringWithFormat:@"TEAM_NUMBER=%@&MATCH_NUMBER=%@&SHOTS_MADE=%ld&SHOTS_TAKEN=%ld&FOULS=%ld&TRUSS=%ld&COMMENTS=%@", self.teamTextField.text,matchTextField.text,(long)stackedCansStepper.getCurrentValue,(long)stackedTotesStepper.getCurrentValue,(long)maxStackStepper.getCurrentValue,numberOfStacksStepper.getCurrentValue,
        commentsTextView.text];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://mrflark.org/frcscout/ios-ms-upload.php"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setHTTPBody:[noteDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *dataRaw, NSURLResponse *header, NSError *error) {
    
        status = 1;
    }];
    
    [dataTask resume];
    
    if(status == -1) {
        afterUploadMessageLabel.text = @"No Server Connection";
    }else {
        afterUploadMessageLabel.text = @"Success";
    }
    afterUploadMessageLabel.hidden = NO;
}

@end
