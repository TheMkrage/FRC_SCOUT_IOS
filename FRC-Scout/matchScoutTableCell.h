//
//  matchScoutTableCell.h
//  FRC-Scout
//
//  Created by Matthew Krager on 12/21/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchScoutTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *matchNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *redScore;
@property (strong, nonatomic) IBOutlet UILabel *BlueScore;

@end
