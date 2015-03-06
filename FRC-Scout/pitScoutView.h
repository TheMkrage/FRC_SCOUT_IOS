//
//  pitScoutView.h
//  FRC-Scout
//
//  Created by Matthew Krager on 12/22/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PitScoutView : UIView
@property(strong, nonatomic)IBOutlet UILabel* driver;
@property(strong, nonatomic)IBOutlet UILabel* shooter;
@property(strong, nonatomic)IBOutlet UILabel* intake;
@property(strong, nonatomic)IBOutlet UILabel* comments;

@end
