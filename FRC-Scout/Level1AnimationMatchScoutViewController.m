//
//  Level1AnimationMatchScoutViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 2/26/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "Level1AnimationMatchScoutViewController.h"
#import "ToteSwipeGestureRecognizer.h"
#import "ToteStack.h"
@interface Level1AnimationMatchScoutViewController () {
    bool firstTime;
    bool doneGoingRight;
}
@property (strong, nonatomic) IBOutlet UIImageView *canBoyImageView;
@property (strong, nonatomic) IBOutlet UIButton *addCanButton;
@property (strong, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UIImageView *Tote0;
@property (strong, nonatomic) IBOutlet UIImageView *Tote1;
@property (strong, nonatomic) IBOutlet UIImageView *Tote2;
@property (strong, nonatomic) IBOutlet UIImageView *Tote3;
@property (strong, nonatomic) IBOutlet UIImageView *Tote4;
@property (strong, nonatomic) IBOutlet UIImageView *Tote5;
@property (strong, nonatomic) NSMutableArray* toteStackArray;
@property (strong, nonatomic) NSTimer* goOffScreenTimer;
@property int numberOfTotes;
@property NSMutableArray* toteArray;
@property int stackNumber;
@end

@implementation Level1AnimationMatchScoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toteStackArray = [[NSMutableArray alloc]init];
    self.stackNumber = 0;
    firstTime = true;
    doneGoingRight = false;
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
    [self.Tote0 setImage:[UIImage imageNamed:@"Tote_Outline.png"]];
    [self.Tote1 setImage:[UIImage imageNamed:@"Tote_Outline.png"]];
    [self.Tote2 setImage:[UIImage imageNamed:@"Tote_Outline.png"]];
    [self.Tote3 setImage:[UIImage imageNamed:@"Tote_Outline.png"]];
    [self.Tote4 setImage:[UIImage imageNamed:@"Tote_Outline.png"]];
    [self.Tote5 setImage:[UIImage imageNamed:@"Tote_Outline.png"]];
    
    NSLog(@"%f", self.Tote5.frame.origin.x);
    NSLog(@"%f", self.Tote5.frame.origin.y);
    
    self.toteArray = [[NSMutableArray alloc]init];
    
    [self.toteArray addObject:self.Tote0];
    [self.toteArray addObject:self.Tote1];
    [self.toteArray addObject:self.Tote2];
    [self.toteArray addObject:self.Tote3];
    [self.toteArray addObject:self.Tote4];
    [self.toteArray addObject:self.Tote5];
    
    self.numberOfTotes = 1;
    NSLog(@"%lu", (unsigned long)self.toteArray.count);
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    
}

-(void)viewDidLayoutSubviews {
    [self.view layoutSubviews];
}


-(void) updateTotesWithX: (int) x Y: (int) y {
    if(firstTime) {
        self.numberOfTotes = 1;
        firstTime = false;
    }
    
    for(int i = 0; i < self.toteArray.count; i++) {
        
       
       // NSLog(@"THING%d",i);
        if(y < [[self.toteArray objectAtIndex:i] frame].origin.y) {
            //NSLog(@"MAKE IT VISIIVLE");
            
            if(x < self.view.frame
               .size.width - 68 && x > 68) {
                 NSLog(@"TOTES : %d", self.numberOfTotes);
                [[self.toteArray objectAtIndex:i] setImage:[UIImage imageNamed:@"Tote.png"]];
                                self.numberOfTotes = i + 1;
                [self.counterLabel setText:[NSString stringWithFormat:@"%d",self.numberOfTotes]];
            }
        }else {
            if([[[self.toteArray objectAtIndex:i] image] isEqual:[UIImage imageNamed:@"Tote.png"]]) {
                
               // NSLog(@"GOING DOWN");
                self.numberOfTotes = i + 1;
                [self.counterLabel setText:[NSString stringWithFormat:@"%d",self.numberOfTotes]];
                
            }
            
                
           [[self.toteArray objectAtIndex:i] setImage:[UIImage imageNamed:@"Tote_Outline.png"]];
            
        }
        [self.counterLabel setFrame:CGRectMake([self.counterLabel frame].origin.x, [[self.toteArray objectAtIndex:self.numberOfTotes - 1] frame].origin.y, [self.counterLabel  frame].size.width, [self.counterLabel frame].size.height)];
        NSLog(@"tap: %d", y);
        NSLog(@"%f", self.counterLabel.frame
              .origin.y);
        [self.canBoyImageView setFrame:CGRectMake(self.canBoyImageView.frame.origin.x, [[self.toteArray objectAtIndex:self.numberOfTotes - 1] frame].origin.y - self.canBoyImageView.frame.size.height, self.canBoyImageView.frame.size.width, self.canBoyImageView.frame.size.height)];

        
    }
}
- (IBAction)addCanMethod:(UIButton *)sender {
    NSLog(@"TESTING");
    NSLog(@"FDSAFSAD");
    if([sender.titleLabel.text isEqualToString: @"Add Can"])  {
        [self.canBoyImageView setHidden:NO];
        [sender setTitle: @"Remove Can" forState:UIControlStateNormal];
        NSLog(@"fdsafa");
    }else if([sender.titleLabel.text isEqualToString: @"Remove Can"]){
        NSLog(@"REMOVE CAN");
        [self.canBoyImageView setHidden:YES];
        [sender setTitle: @"Add Can" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextStackButton:(UIButton *)sender {
    
    self.goOffScreenTimer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(runNextToteAnimation) userInfo:nil repeats:YES];
    NSLog(@"ATTEMPT");
    
    [self prepareForNextStack];
}

-(void) prepareForNextStack {
    ToteStack* temp = [[ToteStack alloc] initWithTotes:[self isToteActivated] Can:self.numberOfTotes];
    [self.toteStackArray setObject:temp atIndexedSubscript:self.stackNumber];
    
}

//ints are bools in c
-(int) isToteActivated {
    if([self.addCanButton.titleLabel.text isEqualToString:@"Add Can"]) {
        return false;
    }
    return true;
}
-(void) runNextToteAnimation {
    NSLog(@"RUNNING");
    if(self.Tote0.frame.origin.x < self.view.frame.size. width + 50 && !doneGoingRight) {
        
        for(int i =0 ; i < self.toteArray.count; i++) {
        UIImageView* view = [self.toteArray objectAtIndex:i];
        [view setFrame:CGRectMake(view.frame.origin.x + 5, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
        }
        [self.canBoyImageView setFrame:CGRectMake(self.canBoyImageView.frame.origin.x + 5, self.canBoyImageView.frame.origin.y, self.canBoyImageView.frame.size.width, self.canBoyImageView.frame.size.height)];
    }else {
        if(!doneGoingRight) {
            doneGoingRight = true;
            for(int i =0 ; i < self.toteArray.count; i++) {
                UIImageView* view = [self.toteArray objectAtIndex:i];
                [view setFrame:CGRectMake(-80, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
            }
            [self.canBoyImageView setFrame:CGRectMake(-75, self.canBoyImageView.frame.origin.y, self.canBoyImageView.frame.size.width, self.canBoyImageView.frame.size.height)];
            self.stackNumber++;
            [self updateStackToStack: self.stackNumber];
        }
        
        if(self.Tote0.frame.origin.x < 123) {
            for(int i =0 ; i < self.toteArray.count; i++) {
                UIImageView* view = [self.toteArray objectAtIndex:i];
                [view setFrame:CGRectMake(view.frame.origin.x + 5, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
            }
            [self.canBoyImageView setFrame:CGRectMake(self.canBoyImageView.frame.origin.x + 5, self.canBoyImageView.frame.origin.y, self.canBoyImageView.frame.size.width, self.canBoyImageView.frame.size.height)];
        }else {
            [self.goOffScreenTimer invalidate];
            self.goOffScreenTimer = nil;
            self.numberOfTotes = 0;
            doneGoingRight = false;
            
        }
    }
}

-(void) updateStackToStack: (int) num {
    
}

-(void) resetImage {
    for(int i =0 ; i < self.toteArray.count; i++) {
        UIImageView* view = [self.toteArray objectAtIndex:i];
        [view setImage: [UIImage imageNamed:@"Tote_Outline.png"]];
    }
    [self.addCanButton setTitle:@"Add Can" forState:UIControlStateNormal];
    [self.canBoyImageView setHidden:YES];
    
    firstTime = true;

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
    if(point.x < self.view.frame
       .size.width - 68 && point.x > 68) {
        return YES;
    }
    return NO;
}
@end
