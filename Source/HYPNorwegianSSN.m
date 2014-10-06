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

    SSNCenturyType century = [self bornInCentury:self.personalNumber];

    NSMutableString *birthdayString = [[NSMutableString alloc] initWithString:self.dateOfBirthString];

    switch (century) {
        case SSNNineteenthCenturyType:
            [birthdayString insertString:@"18" atIndex:4];
            break;
        case SSNTwentiethCenturyType:
        case SSNTwentiethCenturyAlternateType:
            [birthdayString insertString:@"19" atIndex:4];
            break;
        case SSNTwentyFirstCenturyType:
            [birthdayString insertString:@"20" atIndex:4];
            break;
        case SSNDefaultCenturyType:
            break;
    }

    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"DDMMYYYY";
    NSDate *birthday = [formatter dateFromString:[birthdayString copy]];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                   components:NSYearCalendarUnit
                                   fromDate:birthday
                                   toDate:[NSDate date]
                                   options:0];
    NSUInteger age = ageComponents.year;

    return age;
}

- (BOOL)isDNumber
{
    return (self.DNumberValue > 3);
}

- (BOOL)isFemale
{
    return !(self.personalNumber % 2);
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

- (NSUInteger)personalNumber
{
    return [self.personalNumberString integerValue];
}

- (NSUInteger)DNumberValue
{
    return [[self.SSN substringToIndex:1] intValue];
}

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

- (SSNCenturyType)bornInCentury:(NSUInteger)personalNumber
{
    NSRange twentiethCenturyRange = NSMakeRange(0, 499);
    NSRange nineteenthCenturyRange = NSMakeRange(500, 749-500);
    NSRange twentyFirstCenturyRange = NSMakeRange(500, 999-500);
    NSRange twentiethCenturyAlternateRange = NSMakeRange(900, 999-900);

    if (NSLocationInRange(personalNumber, twentiethCenturyRange)) {
        return SSNTwentiethCenturyType;
    } else if (NSLocationInRange(personalNumber, nineteenthCenturyRange)) {
        return SSNNineteenthCenturyType;
    } else if (NSLocationInRange(personalNumber, twentyFirstCenturyRange)) {
        return SSNTwentyFirstCenturyType;
    } else if (NSLocationInRange(personalNumber, twentiethCenturyAlternateRange)) {
        return SSNTwentiethCenturyAlternateType;
    }

    return SSNDefaultCenturyType;
}

@end
