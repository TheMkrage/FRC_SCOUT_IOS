//
//  Level1AnimationMatchScoutViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 2/26/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "Level1AnimationMatchScoutViewController.h"
#import "ToteSwipeGestureRecognizer.h"
@interface Level1AnimationMatchScoutViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *Tote0;
@property (strong, nonatomic) IBOutlet UIImageView *Tote1;
@property (strong, nonatomic) IBOutlet UIImageView *Tote2;
@property (strong, nonatomic) IBOutlet UIImageView *Tote3;
@property (strong, nonatomic) IBOutlet UIImageView *Tote4;
@property (strong, nonatomic) IBOutlet UIImageView *Tote5;
@property NSMutableArray* toteArray;
@end

@implementation Level1AnimationMatchScoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ToteSwipeGestureRecognizer *recognizer;
    
    recognizer = [[ToteSwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:recognizer];
   
}

-(void) setPicsHidden {
    [self.Tote0 setHidden:YES];
    [self.Tote1 setHidden:YES];
    [self.Tote2 setHidden:YES];
    [self.Tote3 setHidden:YES];
    [self.Tote4 setHidden:YES];
    [self.Tote5 setHidden:YES];
    
    [self.toteArray addObject:self.Tote0];
    [self.toteArray addObject:self.Tote1];
    [self.toteArray addObject:self.Tote2];
    [self.toteArray addObject:self.Tote3];
    [self.toteArray addObject:self.Tote4];
    [self.toteArray addObject:self.Tote5];
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    for(int i = 0; i < self.toteArray.count; i++) {
    }
        
    
    NSLog((@"SWIPE"));
    NSLog(@"%f,%f", [recognizer locationInView:[recognizer view]].x,[recognizer locationInView:[recognizer view]].y);
    NSLog(@"With 1: %f,%f", [recognizer locationOfTouch:1 inView:[recognizer view]].x,[recognizer locationOfTouch:1 inView:[recognizer view]].y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    return YES;
}
@end
