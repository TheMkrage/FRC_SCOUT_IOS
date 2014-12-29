//
//  kragerPickerView.h
//  FRC-Scout
//
//  Created by Matthew Krager on 12/25/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kragerPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

- (void) setData: (NSArray*) data;
- (NSString*)getSelectedItem;
@end
