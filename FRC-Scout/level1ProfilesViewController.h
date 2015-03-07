//
//  level1ProfilesViewController.h
//  FRC-Scout
//
//  Created by Matthew Krager on 11/26/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Level1ProfilesViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

-(void)setTeam:(NSNumber*)num;
@end
