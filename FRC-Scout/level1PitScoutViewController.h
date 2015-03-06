//
//  level1PitScoutViewController.h
//  FRC-Scout
//
//  Created by Matthew Krager on 11/26/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Level1PitScoutViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate>
-(NSString*)getTeam;
+ (Level1PitScoutViewController*)getInstance;
- (void)textFieldShouldBeEditable: (UITextField*)field ;
@end
