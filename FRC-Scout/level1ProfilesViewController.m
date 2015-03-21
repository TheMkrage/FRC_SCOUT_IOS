//
//  level1ProfilesViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 11/26/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "Level1ProfilesViewController.h"
#import "Level1PitScoutDisplayViewController.h"
#import "MatchScoutTableCell.h"
#import "PitScoutView.h"
#import <Firebase/Firebase.h>
@interface Level1ProfilesViewController (){
    
    IBOutlet UITableView *matchScoutTable;
    IBOutlet UIScrollView *scrollView;
    IBOutlet PitScoutView *pitScoutView;
    NSMutableArray *quals;
    NSNumber* team;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation Level1ProfilesViewController

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
    
    self.title = [NSString stringWithFormat:@"%@",team];
    
   
    quals = [[NSMutableArray alloc]initWithArray:@[@"Q1",@"Q12",@"Q123",@"Q01",@"Q001",@"Q1",@"Q12",@"Q123",@"Q01",@"Q001"]]
    ;
    [matchScoutTable setDataSource:self];
    [matchScoutTable setDelegate:self];
    
     Firebase* ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat: @"https://friarscout.firebaseio.com/teams/%@", team]];
    [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:snapshot.value[@"image"]]]];
        self.imageView.image = image;
    }];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidLayoutSubviews {
    scrollView.frame = CGRectMake(scrollView.frame.origin.x, 0, 320, self.view.frame.size.height);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 63);
    //[scrollView  setCenter:CGPointMake(scrollView.center.x, scrollView.center.y - 62)];
    [self.view layoutSubviews];
}

-(void)setTeam:(NSNumber*)num {
   team = num;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"HEell");
    return quals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchScoutTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"matchCell" forIndexPath:indexPath];
    cell.matchNumberLabel.text = [quals objectAtIndex:[indexPath row]];
    //NSLog(@"HEell");
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (IBAction)OpenPitScoutButton:(UIButton *)sender {
    
    NSString * storyboardName = @"Main_iPhone";
    NSString * viewControllerID = @"Level1PitDisplay";
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    Level1PitScoutDisplayViewController* controller = (Level1PitScoutDisplayViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    //NSLog(@"fdasf: %ld",(long)  [indexPath row]);
    [controller setTeam:team];
    [self.navigationController pushViewController:controller animated:YES];
}



@end
