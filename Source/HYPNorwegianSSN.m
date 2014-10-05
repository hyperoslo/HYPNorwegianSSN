//
//  HYPNorwegianSSN.m
//  HYPNorwegianSSN
//
//  Created by Christoffer Winterkvist on 10/5/14.
//
//

#import "HYPNorwegianSSN.h"

@implementation HYPNorwegianSSN

- (instancetype)initWithSSN:(NSString *)string
{
    self = [super init];
    if (!self) return nil;

    self.SSN = string;

    return self;
}

- (NSUInteger)age
{
    return 0;
}

- (BOOL)isDNumber
{
    return NO;
}

- (BOOL)isFemale
{
    return NO;
}

- (BOOL)isMale
{
    return NO;
}

- (BOOL)isValid
{
    return NO;
}

@end
