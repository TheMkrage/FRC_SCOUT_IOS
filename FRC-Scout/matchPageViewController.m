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
        
    NSArray *initialController = @[matchViewController];
    // Do any additional setup after loading the view.
    [self setViewControllers:initialController
                   direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self setDataSource:self];
    [self setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSUInteger)indexOfViewController:(matchViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return *(viewController.location);
}
#pragma mark - Page View Controller Data Source

/*- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(matchViewController *)viewController];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return self.controllerArray[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(matchViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.controllerArray count]) {
        return nil;
    }
    return self.controllerArray[index];
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
