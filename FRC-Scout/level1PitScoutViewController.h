//
//  level1PitScoutViewController.h
//  FRC-Scout
//
//  Created by Matthew Krager on 11/26/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface level1PitScoutViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, NSStreamDelegate>

+ (level1PitScoutViewController*)getInstance;
- (void)textFieldShouldBeEditable: (UITextField*)field ;
@end
