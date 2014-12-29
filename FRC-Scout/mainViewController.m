//
//  mainViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 11/17/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "mainViewController.h"
#import "webConnector.h"
#import "textUIDelegate.h"
#import "level1MenuViewController.h"

@interface mainViewController () {
    IBOutlet UIScrollView *scrollView;
    NSMutableArray *usernames;
    NSMutableArray *passwords;
    webConnector *_webConnector;
    UITextField *activeTextField;
    NSArray *teamsData;
}
@property (strong, nonatomic) IBOutlet UILabel *deniedUSER;
@property (strong, nonatomic) IBOutlet UITextField *Username;
@property (strong, nonatomic) IBOutlet UITextField *Password;
@property (strong, nonatomic) IBOutlet UIButton *EnterPass;
@property (strong, nonatomic) IBOutlet UINavigationItem *titleNav;

@end

#define FONT_BEBAS_15 [UIFont fontWithName: @"Bebas Neue" size:15]
#define FONT_BEBAS_25 [UIFont fontWithName: @"Bebas Neue" size:25]
//#define FONT_APPLE [UIFont fontWithName: @"Helvetica Neue" size:15]

@implementation mainViewController
- (IBAction)Username:(id)sender {
    
}
- (IBAction)EnterPass:(id)sender {
    
    
    __block NSNumber *status = [[NSNumber alloc] initWithInteger:1];
    
    NSString *noteDataString = [NSString stringWithFormat:@"user=%@&password=%@", _Username.text, _Password.text];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://mrflark.org/frcscout/login.php"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setHTTPBody:[noteDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[NSUserDefaults standardUserDefaults] setObject:[self Username].text forKey:@"Username"];
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *dataRaw, NSURLResponse *header, NSError *error) {
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:dataRaw
                              options:kNilOptions error:&error];
        status = json[@"PLEVEL"];
        NSLog(@"json: %@",status);
        
        NSLog(@"HELL");
        NSLog(@"after: %@",status);
        NSLog(@"int: %d",[status intValue]);
        if([status intValue] == 1) {
            NSLog(@"HELLO");
            NSString * storyboardName = @"Main_iPhone";
            NSString * viewControllerID = @"level1";
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
            level1MenuViewController * controller = (level1MenuViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
            [self.navigationController pushViewController:controller animated:YES];
            
        }else {
            [_deniedUSER setHidden:NO];
        }
        
    }];
    
    [dataTask resume];
 
    
/*#warning delete following code, it is for testing purposes only
    
    NSString * storyboardName = @"Main_iPhone";
    NSString * viewControllerID = @"level1";
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    level1MenuViewController * controller = (level1MenuViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    [self.navigationController pushViewController:controller animated:YES];*/
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_deniedUSER setHidden:YES];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Bebas Neue" size:25],
      NSFontAttributeName, nil]];

    [self EnterPass].titleLabel.font = FONT_BEBAS_25;
    [self deniedUSER].font = FONT_BEBAS_25;
    
    [self Username].contentVerticalAlignment  =  UIControlContentVerticalAlignmentCenter;
    [self Password].contentVerticalAlignment  =  UIControlContentVerticalAlignmentCenter;
    
    [self Username].placeholder = @"Username";
    [self Password].placeholder = @"Password";
    
    [[self Username] setDelegate:self];
    [[self Password] setDelegate:self];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidLayoutSubviews {
    scrollView.contentSize = CGSizeMake(320, 600);
    [scrollView  setCenter:CGPointMake(scrollView.center.x, scrollView.center.y - 62)];
    
    [self.view layoutSubviews];
}

-(void) itemsDownload:(NSArray *)items {
    
    //usernames = [[NSMutableArray alloc] initWithArray:items[0]];
    NSNumber *PlevelInt = items[0];
    NSLog(@"%@",PlevelInt);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-------------


#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDedBeginEditing:(UITextField *)textField {
    activeTextField = textField;
}


@end
