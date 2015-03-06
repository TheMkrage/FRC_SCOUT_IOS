//
//  KragerSwitchView.h
//  FRC-Scout
//
//  Created by Matthew Krager on 3/5/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KragerSwitchView : UISwitch

-(NSString*) getCode;
-(void) setCode:(NSString *)code;
@end
