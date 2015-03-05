//
//  kragerTextField.m
//  FRC-Scout
//
//  Created by Matthew Krager on 3/5/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "kragerTextField.h"
@interface kragerTextField() {
    
}
@property (strong, nonatomic) NSString* code;
@end

@implementation kragerTextField

-(id) initWithCode: (NSString*) code {
    self = [super init];
    self.code = code;
    return self;
}

-(void) setCode:(NSString *)code {
    self.code = code;
}

-(NSString*) getCode {
    return self.code;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
