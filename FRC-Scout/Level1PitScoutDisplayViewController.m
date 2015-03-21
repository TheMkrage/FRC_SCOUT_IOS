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

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
//LITTS
@property (strong, nonatomic) IBOutlet UILabel *LiftLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxToteLabel;

@property (strong, nonatomic) IBOutlet UILabel *ToteStackHeightLabel;
@property (strong, nonatomic) IBOutlet UILabel *InternalExternalLabel;
@property (strong, nonatomic) IBOutlet UILabel *CanStackHeightLabel;

//INTAKE
@property (strong, nonatomic) IBOutlet UILabel *intakeLabel;
@property (strong, nonatomic) IBOutlet UILabel *invertedLabel;
@property (strong, nonatomic) IBOutlet UILabel *changeOrientationLabel;
@property (strong, nonatomic) IBOutlet UILabel *containerOffGroundLabel;
@property (strong, nonatomic) IBOutlet UILabel *poolNoodlesLabel;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation Level1PitScoutDisplayViewController

-(void)setTeam:(NSNumber *)num {
    team = num;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addDataToLabels];
    
    Firebase* ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat: @"https://friarscout.firebaseio.com/teams/%@", team]];
    [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:snapshot.value[@"image"]]]];
        self.imageView.image = image;
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidLayoutSubviews {
    self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, 0, 320, self.view.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
    //[scrollView  setCenter:CGPointMake(scrollView.center.x, scrollView.center.y - 62)];
    [self.view layoutSubviews];
}

- (void) addDataToLabels {
    Firebase* ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat: @"https://friarscout.firebaseio.com/teams/%@/pit", team]];
    [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        [self addDataThatNeedsManual:snapshot];
        
        [self addString: snapshot.value[@"cim"] toLabel: self.CIMLabel];
        [self addString: snapshot.value[@"drive"] toLabel: self.DriveLabel];
        [self addString: snapshot.value[@"lift"] toLabel: self.LiftLabel];
        [self addString: snapshot.value[@"tote_max_carried"] toLabel: self.maxToteLabel];
        [self addString: snapshot.value[@"tote_stack_height"] toLabel: self.ToteStackHeightLabel];
        [self addString: snapshot.value[@"max_can_height"] toLabel: self.CanStackHeightLabel];
        [self addString: snapshot.value[@"intake"] toLabel: self.intakeLabel];
        [self addBool: snapshot.value[@"inverted_totes"] toLabel: self.invertedLabel];
        [self addBool: snapshot.value[@"tote_orientation_change"] toLabel: self.changeOrientationLabel];
        [self addBool: snapshot.value[@"can_off_ground"] toLabel: self.containerOffGroundLabel];
        [self addBool: snapshot.value[@"pool_noodles"] toLabel: self.poolNoodlesLabel];
        
        
        
        
    }];
    
}

-(void) addDataThatNeedsManual: (FDataSnapshot*) snapshot {
    @try {
        
        self.weightLabel.text = [NSString stringWithFormat:@"%@ %@ lb",self.weightLabel.text, snapshot.value[@"weight"]];
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"LOL NOPE");
    }
    
    @try {
        self.heightLabel.text = [NSString stringWithFormat:@"%@ %@ ft",self.heightLabel.text, snapshot.value[@"height"]];
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"LOL NOPE");
    }
    
}

- (void) addString: (id)string toLabel: (UILabel*) label {
    NSLog(@"STRING: %@", string);
    @try {
        if(![string isEqualToString:@""]) {
            label.text = [NSString stringWithFormat:@"%@ %@",label.text, string];
            NSLog(@"LABEL: %@",label.text );
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"LOL NOPE");
    }
    
    
    
}

- (void) addBool: (NSNumber*)string toLabel: (UILabel*) label {
    bool b = [string boolValue];
    NSLog(@"STRING: %@", string);
    @try {
        
        label.text = [NSString stringWithFormat:@"%@ %s",label.text, b ? "true" : "false"];
        NSLog(@"LABEL: %@",label.text );
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"LOL NOPE");
    }
    
    
    
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
