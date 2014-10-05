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
    if ([self.SSN length] != 11) {
        NSLog(@"%s:%d -> %@",  __FUNCTION__, __LINE__, @"Unable to calculate age because SSN is not long enough");
    }

    NSString *dateCharactersString = [self.SSN substringToIndex:6];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"DDMMYY";
    NSDate *birthday = [formatter dateFromString:dateCharactersString];
    NSDate *now = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                   components:NSYearCalendarUnit
                                   fromDate:birthday
                                   toDate:now
                                   options:0];
    NSUInteger age = [ageComponents year];

    return age;
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
