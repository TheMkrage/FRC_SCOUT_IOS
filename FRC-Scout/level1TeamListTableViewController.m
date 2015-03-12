//
//  level1PickListTableViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 12/20/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "Level1TeamListTableViewController.h"
#import "Level1ProfilesViewController.h"
#import "PickListCell.h"
#import <Firebase/Firebase.h>
@interface Level1TeamListTableViewController ()

@property NSMutableArray *teamArray;
@property NSMutableArray *avgArray;
@property NSMutableArray *driveArray;
@property NSMutableArray *liftArray;
@property NSMutableArray *intakeArray;
@end

#define FONT_BEBAS_15 [UIFont fontWithName: @"Bebas Neue" size:15]
#define FONT_BEBAS_25 [UIFont fontWithName: @"Bebas Neue" size:25]
#define FONT_BEBAS_28 [UIFont fontWithName: @"Bebas Neue" size:28]

@implementation Level1TeamListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      FONT_BEBAS_28,
      NSFontAttributeName, nil]];
    
    self.title = @"Team List";
}
- (void) viewWillLoad {
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    
    self.teamArray = [[NSMutableArray alloc] init];
    self.avgArray = [[NSMutableArray alloc] init];
    self.intakeArray = [[NSMutableArray alloc] init];
    self.liftArray = [[NSMutableArray alloc] init];
    self.driveArray = [[NSMutableArray alloc] init];
    Firebase* ref = [[Firebase alloc] initWithUrl:@"https://friarscout.firebaseio.com/teams"];
    [[ref queryOrderedByValue] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [self.teamArray addObject:snapshot.key];
        if(snapshot.value[@"avg"] == nil) {
        }else{
            [self.avgArray addObject:snapshot.value[@"avg"]];
        }
        
        
        Firebase* ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat: @"https://friarscout.firebaseio.com/teams/%@/pit", snapshot.value[@"number"]]];
        [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            
                //NSLog(@"%@", snapshot.value[@"drivetrain"]);
                @try {
                    [self.driveArray addObject:snapshot.value[@"drivetrain"]];
                }
                @catch (NSException *exception) {
                    [self.driveArray addObject:@"none"];
                }
                
            
            
            @try {
                [self.liftArray addObject:snapshot.value[@"lift"]];
            }
            @catch (NSException *exception) {
                [self.liftArray addObject:@"none"];
            }
            
            @try {
                [self.intakeArray addObject:snapshot.value[@"intake"]];
            }
            @catch (NSException *exception) {
                [self.intakeArray addObject:@"none"];
            }
            
            
            
            NSLog(@"The %@ dinosaur's score is %@", snapshot.key, snapshot.value);
            
            [self.tableView reloadData];
        }];
        
        
        NSLog(@"FDASFDSAFDSA");
        
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_teamArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"teamCell";
    PickListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    long row = [indexPath row];
    cell.teamNumLabel.text = [_teamArray objectAtIndex:row];
    
    if(self.avgArray.count > row) {
        cell.AvgLabel.text = [NSString stringWithFormat:@"Avg: %@",[self.avgArray objectAtIndex:row]];
    }
    
    if(self.driveArray.count > row) {
        cell.driveLabel.text = [NSString stringWithFormat:@"Drive: %@",[self.driveArray objectAtIndex:row]];
    }
    
    if(self.liftArray.count > row) {
        cell.liftLabel.text = [NSString stringWithFormat:@"Lift: %@",[self.liftArray objectAtIndex:row]];
    }

    if(self.intakeArray.count > row){
        cell.intakeLabel.text = [NSString stringWithFormat:@"Intake: %@",[self.intakeArray objectAtIndex:row]];
    }
    
    
    
    //[self.driveTrainArray objectAtIndex: row];
    // Configure the cell...
    
    return cell;
}

- (void)tableView: (UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * storyboardName = @"Main_iPhone";
    NSString * viewControllerID = @"level1Profile";
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    Level1ProfilesViewController* controller = (Level1ProfilesViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    //NSLog(@"fdasf: %ld",(long)  [indexPath row]);
    [controller setTeam:[self.teamArray objectAtIndex:[indexPath row]]];
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end
