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

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"DDMMYY";
    NSDate *birthday = [formatter dateFromString:self.dateOfBirthString];
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
    NSUInteger firstDigit = [[self.SSN substringToIndex:1] intValue];

    return (firstDigit > 3);
}

- (BOOL)isFemale
{
    NSInteger personalNumber = [self.personalNumberString integerValue];
    return !(personalNumber % 2);
}

- (BOOL)isMale
{
    return ![self isFemale];
}

- (BOOL)isValid
{
    return NO;
}

#pragma mark - Private methods

- (NSString *)dateOfBirthString
{
    return [self.SSN substringToIndex:6];
}

- (NSString *)personalNumberString
{
    return [self.SSN substringWithRange:NSMakeRange(6,3)];
}

- (NSString *)controlNumberString
{
    return [self.SSN substringFromIndex:9];
}

@end
