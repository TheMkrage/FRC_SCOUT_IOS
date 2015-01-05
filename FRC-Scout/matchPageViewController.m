//
//  matchPageViewController.m
//  FRC-Scout
//
//  Created by Matthew Krager on 1/4/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "matchPageViewController.h"
#import "level1MatchScoutViewController.h"
#import "matchAutonomousViewController.h"
@interface matchPageViewController ()
@property(strong,nonatomic)NSArray* controllerArray;
@end

@implementation matchPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    level1MatchScoutViewController *matchController = [self.storyboard instantiateViewControllerWithIdentifier:@"matchController"];
    matchController.location = 0;
    matchAutonomousViewController *autoController = [self.storyboard instantiateViewControllerWithIdentifier:@"autoController"];
    autoController.location = 1;
    self.controllerArray = @[matchController, autoController];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIViewController *)pageViewController viewControllerBeforeViewController:(matchViewController *)viewController
{
    NSInteger *index = viewController.location;
    
    if ((index == 0) || (index == nil)) {
        return nil;
    }
    
    index =index - 1;
    
    return [self.controllerArray objectAtIndex: (NSUInteger)index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(matchViewController *)viewController
{
    NSInteger *index = viewController.location;
    
    if (index == nil) {
        return nil;
    }
    
    index++;
    if ((NSUInteger)index == [self.controllerArray count] ) {
        return nil;
    }
    return [self.controllerArray objectAtIndex:(NSUInteger)index];
}
- (NSInteger)presentationCountForPageViewController:(matchViewController *)pageViewController
{
    return [self.controllerArray count];
}

- (NSInteger)presentationIndexForPageViewController:(matchViewController *)pageViewController
{
    return 0;
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
