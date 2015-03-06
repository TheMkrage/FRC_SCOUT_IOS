//
//  kragerTextField.m
//  FRC-Scout
//
//  Created by Matthew Krager on 3/5/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

#import "KragerTextField.h"
@interface KragerTextField() {
    NSString* code;
}

@end

@implementation KragerTextField

-(id) initWithCode: (NSString*) code1 {
    self = [super init];
    code = code1;
    return self;
}

-(void) setCode:(NSString *)code1 {
    code = code1;
}

-(NSString*) getCode {
    return code;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
