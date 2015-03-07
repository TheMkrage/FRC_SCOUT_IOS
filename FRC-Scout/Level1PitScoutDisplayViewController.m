//
//  Level1PitScoutDisplayViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 3/6/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "Level1PitScoutDisplayViewController.h"
#import <Firebase/Firebase.h>
@interface Level1PitScoutDisplayViewController () {
    NSNumber* team;
}

//SPECS:
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightLabel;

//DRIVE TRAIN
@property (strong, nonatomic) IBOutlet UILabel *CIMLabel;
@property (strong, nonatomic) IBOutlet UILabel *MaxSpeedLabel;
@property (strong, nonatomic) IBOutlet UILabel *DriveLabel;
@property (strong, nonatomic) IBOutlet UILabel *speedLabel;

//LITTS
@property (strong, nonatomic) IBOutlet UILabel *LiftLabel;
@property (strong, nonatomic) IBOutlet UILabel *MaxSpeedLabe;
@property (strong, nonatomic) IBOutlet UILabel *ToteStackHeightLabel;
@property (strong, nonatomic) IBOutlet UILabel *InternalExternalLabel;
@property (strong, nonatomic) IBOutlet UILabel *CanStackHeightLabel;


@end

@implementation Level1PitScoutDisplayViewController

-(void)setTeam:(NSNumber *)num {
    team = num;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addDataToLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addDataToLabels {
    Firebase* ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat: @"https://friarscout.firebaseio.com/teams/%@/pit", team]];
    [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        
            }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
