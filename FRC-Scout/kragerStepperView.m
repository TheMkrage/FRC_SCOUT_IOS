//
//  kragerStepperView.m
//  FRC-Scout
//
//  Created by Matthew Krager on 12/23/14.
//  Copyright (c) 2014 Matthew Krager. All rights reserved.
//

#import "kragerStepperView.h"
@interface kragerStepperView() {
    IBOutlet UIButton *minusButton;
    IBOutlet UIButton *plusButton;
    IBOutlet UILabel *number;
    NSInteger value;
}
@end

@implementation kragerStepperView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        value = 0;
        // Initialization code
    }
    
    return self;
}





-(IBAction)plusButton:(id)sender {
    value++;
    number.text = [[NSString alloc]initWithFormat:@"%ld",(long)value];
    
}

-(IBAction)minusButton:(id)sender {
    value--;
    number.text = [[NSString alloc]initWithFormat:@"%ld",(long)value];
}

-(NSInteger)getCurrentValue {
    return value;
}
-(void)setCurrentValue:(NSInteger*) num {
    value = *num;
    number.text = [[NSString alloc]initWithFormat:@"%ld",(long)value];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
