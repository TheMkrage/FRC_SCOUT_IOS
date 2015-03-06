//
//  level1ProfilesViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 11/26/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "Level1ProfilesViewController.h"
#import "MatchScoutTableCell.h"
#import "PitScoutView.h"
@interface Level1ProfilesViewController (){
    
    IBOutlet UITableView *matchScoutTable;
    IBOutlet UIScrollView *scrollView;
    IBOutlet PitScoutView *pitScoutView;
    NSMutableArray *quals;
}

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
    
    quals = [[NSMutableArray alloc]initWithArray:@[@"Q1",@"Q12",@"Q123",@"Q01",@"Q001",@"Q1",@"Q12",@"Q123",@"Q01",@"Q001"]]
    ;
    [matchScoutTable setDataSource:self];
    [matchScoutTable setDelegate:self];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



@end
