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
    
    IBOutlet kragerStepperView *shotTakenStepper;
    IBOutlet kragerStepperView *shotMadeStepper;
    IBOutlet kragerStepperView *foulsStepper;
    IBOutlet kragerStepperView *trussStepper;
    IBOutlet UITextView *commentsTextView;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *matchTextField;
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
    [self teamTextField].placeholder = @"Team";
    matchTextField.placeholder = @"MatchNumber";
    
	// Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      FONT_BEBAS_28,
      NSFontAttributeName, nil]];
    self.title = @"Match Scout";
}

-(void)viewDidLayoutSubviews {
    scrollView.contentSize = CGSizeMake(320, 600);
    [scrollView  setCenter:CGPointMake(scrollView.center.x, scrollView.center.y - 62)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)uploadButton:(UIButton *)sender {
    NSString *noteDataString = [NSString stringWithFormat:@"TEAM_NUMBER=%@&MATCH_NUMBER=%@&SHOTS_MADE=%ld&SHOTS_TAKEN=%ld&FOULS=%ld&TRUSS=%ld&COMMENTS=%@", self.teamTextField.text,matchTextField.text,(long)shotMadeStepper.getCurrentValue,(long)shotTakenStepper.getCurrentValue,(long)foulsStepper.getCurrentValue,trussStepper.getCurrentValue,
        commentsTextView.text];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://mrflark.org/frcscout/ios-ms-upload.php"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setHTTPBody:[noteDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *dataRaw, NSURLResponse *header, NSError *error) {
    
    }];
    
    [dataTask resume];
    
}

@end
