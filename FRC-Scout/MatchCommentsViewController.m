//
//  MatchCommentsViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 3/12/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "MatchCommentsViewController.h"
#import "Level1MatchAutoViewController.h"
#import <Firebase/Firebase.h>

@interface MatchCommentsViewController ()
{
    NSString* team;
    NSString* match;
    NSString* matchID;
}
@property (strong, nonatomic) IBOutlet UITextView *commentsTextView;

@end

@implementation MatchCommentsViewController


-(void)viewWillDisappear:(BOOL)animated {
    Firebase* ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://friarscout.firebaseio.com/teams/%@/matches/%@", team, match]];
    NSMutableDictionary* dict = [[ NSMutableDictionary alloc]init];
    [dict setObject:self.commentsTextView.text forKey:@"notes"];
    [ref updateChildValues:dict
     ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    match =[[[self.tabBarController viewControllers] objectAtIndex:0] getMatch];
    matchID =[[[self.tabBarController viewControllers] objectAtIndex:0] getTeamID];
    team = [[[self.tabBarController viewControllers] objectAtIndex:0] getTeam];
    self.commentsTextView.delegate = self;
    self.commentsTextView.layer.cornerRadius = 5;
    self.commentsTextView.layer.borderWidth = 2;
    self.commentsTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    // Do any additional setup after loading the view.
    
    Firebase* ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://friarscout.firebaseio.com/teams/%@/matches/%@", team, match]];
    [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        self.commentsTextView.text = snapshot.value[@"notes"];
    }];
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.enabled = YES;
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
}
-(void) singleTap: (UITapGestureRecognizer*)gesture {
    NSLog(@"TAP");
    [self.commentsTextView resignFirstResponder];
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

-(void)textViewDidBeginEditing:(UITextView *)textView{
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    return TRUE;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
    }
-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
    NSLog(@"STOP");
    [textView resignFirstResponder];
    return YES;
}

@end
