//
//  pickListCell.m
//  FRC-Scout
//
//  Created by Matthew Krager on 12/23/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "PickListCell.h"

@implementation PickListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
