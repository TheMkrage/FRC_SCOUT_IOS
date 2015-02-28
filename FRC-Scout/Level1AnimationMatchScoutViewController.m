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
@property (strong, nonatomic) IBOutlet UIImageView *canBoyImageView;
@property (strong, nonatomic) IBOutlet UIButton *addCanButton;
@property (strong, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UIImageView *Tote0;
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
    
    [self setPicsHidden];
    
    
    ToteSwipeGestureRecognizer *recognizer;
    
    recognizer = [[ToteSwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:) controller:self];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer setDelegate:self];
    
    NSLog(@"PIC HIDDEN");
}

-(void) setPicsHidden {
    
    [self.canBoyImageView setHidden:YES];
    [self.Tote0 setImage:[UIImage imageNamed:@"ToteOutline.png"]];
    [self.Tote1 setImage:[UIImage imageNamed:@"ToteOutline.png"]];
    [self.Tote2 setImage:[UIImage imageNamed:@"ToteOutline.png"]];
    [self.Tote3 setImage:[UIImage imageNamed:@"ToteOutline.png"]];
    [self.Tote4 setImage:[UIImage imageNamed:@"ToteOutline.png"]];
    [self.Tote5 setImage:[UIImage imageNamed:@"ToteOutline.png"]];
    
    NSLog(@"%f", self.Tote5.frame.origin.x);
    NSLog(@"%f", self.Tote5.frame.origin.y);
    
    self.toteArray = [[NSMutableArray alloc]init];
    
    [self.toteArray addObject:self.Tote0];
    [self.toteArray addObject:self.Tote1];
    [self.toteArray addObject:self.Tote2];
    [self.toteArray addObject:self.Tote3];
    [self.toteArray addObject:self.Tote4];
    [self.toteArray addObject:self.Tote5];
    
    
    NSLog(@"%lu", (unsigned long)self.toteArray.count);
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    
}

-(void)viewDidLayoutSubviews {
    [self.view layoutSubviews];
}


-(void) updateTotesWithX: (int) x Y: (int) y {
    NSLog(@"UPDATING %lu", (unsigned long)self.toteArray.count)
    ;
    for(int i = 0; i < self.toteArray.count; i++) {
        NSLog(@"THING%d",i);
        if(y < [[self.toteArray objectAtIndex:i] frame].origin.y) {
            NSLog(@"MAKE IT VISIIVLE");
            if(x < self.view.frame.size.width/2) {
                [[self.toteArray objectAtIndex:i] setImage:[UIImage imageNamed:@"Tote.png"]];
                [self.counterLabel setFrame:CGRectMake([self.counterLabel frame].origin.x, [[self.toteArray objectAtIndex:i] frame].origin.y, [self.counterLabel  frame].size.width, [self.counterLabel frame].size.height)];
                [self.canBoyImageView setFrame:CGRectMake(self.canBoyImageView.frame.origin.x, [[self.toteArray objectAtIndex:i] frame].origin.y - self.canBoyImageView.frame.size.height, self.canBoyImageView.frame.size.width, self.canBoyImageView.frame.size.height)];
            }
        }else {
           [[self.toteArray objectAtIndex:i] setImage:[UIImage imageNamed:@"ToteOutline.png"]];
            //[self.counterLabel setFrame:CGRectMake([self.counterLabel frame].origin.x, [[self.toteArray objectAtIndex:i] frame].origin.y, [self.counterLabel  frame].size.width, [self.counterLabel frame].size.height)];

        }
    }
}
- (IBAction)addCanMethod:(UIButton *)sender {
    NSLog(@"FDSAFSAD");
    [self.canBoyImageView setHidden:NO];
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


#pragma mark tap delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // test if our control subview is on-screen
    CGPoint point = [touch locationInView:self.view];
    if(point.x < self.view.frame.size.width/2) {
        return YES;
    }
    return NO;
}
@end
