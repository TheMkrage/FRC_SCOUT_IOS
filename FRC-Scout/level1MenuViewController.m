//
//  level1MenuViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 11/24/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "level1MenuViewController.h"

#define FONT_BEBAS_15 [UIFont fontWithName: @"Bebas Neue" size:15]
#define FONT_BEBAS_25 [UIFont fontWithName: @"Bebas Neue" size:25]
#define FONT_BEBAS_28 [UIFont fontWithName: @"Bebas Neue" size:28]
#define FONT_CALIBRI_25 [UIFont fontWithName: @"Calibri Italic" size:25]

@interface level1MenuViewController (){
    
    IBOutlet UIButton *PitScoutButton;
    IBOutlet UIButton *MatchScoutButton;
    IBOutlet UIButton *ProfilesButton;
    IBOutlet UIButton *TeamListButton;
    IBOutlet UIButton *RankingButton;
}
@end

@implementation level1MenuViewController

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

    PitScoutButton.titleLabel.font = FONT_BEBAS_25;
    MatchScoutButton.titleLabel.font = FONT_BEBAS_25;
    ProfilesButton.titleLabel.font = FONT_BEBAS_25;
    TeamListButton.titleLabel.font = FONT_BEBAS_25;
    RankingButton.titleLabel.font = FONT_BEBAS_25;
}

- (void) viewDidAppear:(BOOL)animated {
    
}
-(void) viewWillAppear:(BOOL)animated {
    NSString *username = [[ NSString alloc] initWithString:[[NSUserDefaults standardUserDefaults]stringForKey:@"Username"]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      FONT_BEBAS_28,
      NSFontAttributeName, nil]];
    
    
    NSString *temp =[[NSString alloc] initWithFormat:@"Hello %@", (username)];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    self.title = temp;
    self.navigationItem.title = temp;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
}

@end
