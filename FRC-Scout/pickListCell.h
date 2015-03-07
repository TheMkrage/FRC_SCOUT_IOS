//
//  pickListCell.h
//  FRC-Scout
//
//  Created by Matthew Krager on 12/23/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *robotImage;
@property (strong, nonatomic) IBOutlet UILabel *teamNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *AvgLabel;
@property (strong, nonatomic) IBOutlet UILabel *driveLabel;
@property (strong, nonatomic) IBOutlet UILabel *liftLabel;
@property (strong, nonatomic) IBOutlet UILabel *intakeLabel;

@end
