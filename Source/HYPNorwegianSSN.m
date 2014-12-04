//
//  HYPNorwegianSSN.m
//  HYPNorwegianSSN
//
//  Reference http://www.kith.no/upload/5588/KITH1001-2010_Identifikatorer-for-personer_v1.pdf
//
//  Created by Christoffer Winterkvist on 10/5/14.
//
//

#import "HYPNorwegianSSN.h"

NSRange HYPTwentiethCenturyRange = {0, 500};
NSRange HYPNineteenthCenturyRange = {500, 749-500+1};
NSRange HYPTwentyFirstCenturyRange = {500, 999-500+1};
NSRange HYPTwentiethCenturyAlternateRange = {900, 999-900+1};

NSUInteger HYPValidSSNLength = 11;
NSUInteger HYPValidSSNControlNumber = 11;

typedef NS_ENUM(NSInteger, SSNCenturyType) {
    SSNDefaultCenturyType = 0,
    SSNNineteenthCenturyType,
    SSNTwentiethCenturyType,
    SSNTwentyFirstCenturyType,
    SSNTwentiethCenturyAlternateType
};

@implementation HYPNorwegianSSN

+ (NSArray *)firstControlWeightNumbers
{
    return @[@3,@7,@6,@1,@8,@9,@4,@5,@2];
}

+ (NSArray *)secondControlWeightNumbers
{
    return @[@5,@4,@3,@2,@7,@6,@5,@4,@3,@2];
}

+ (BOOL)validateWithString:(NSString *)string
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:string];
    return ssn.isValid;
}

- (instancetype)initWithString:(NSString *)string
{
    self = [super init];
    if (!self) return nil;

    self.SSN = string;

    return self;
}

- (NSNumber *)age
{
    if ([self.SSN length] != HYPValidSSNLength) {
        NSLog(@"%s:%d -> %@",  __FUNCTION__, __LINE__, @"Unable to calculate age because SSN is not long enough");
    }

    if (!self.dateOfBirthStringWithCentury) return nil;

    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"DDMMyyyy";
    NSDate *birthday = [formatter dateFromString:self.dateOfBirthStringWithCentury];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:birthday
                                       toDate:[NSDate date]
                                       options:0];

    return @(ageComponents.year);
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
    if (!self.SSN || self.SSN.length != HYPValidSSNLength) return NO;

    NSInteger firstControlDigit, secondControlDigit;
    NSString *ssn = [self.SSN substringToIndex:9];

    firstControlDigit = [self calculateSSN:ssn withWeightNumbers:[HYPNorwegianSSN firstControlWeightNumbers]];
    firstControlDigit = [self modulusEleven:firstControlDigit];

    NSArray *secondControlWeightNumbers = [HYPNorwegianSSN secondControlWeightNumbers];
    secondControlDigit  = [self calculateSSN:ssn withWeightNumbers:secondControlWeightNumbers];
    secondControlDigit += [[secondControlWeightNumbers lastObject] integerValue] * firstControlDigit;
    secondControlDigit = [self modulusEleven:secondControlDigit];

    return (firstControlDigit == self.firstControlNumber &&
            secondControlDigit == self.secondControlNumber);
}

- (NSString *)dateOfBirthString
{
    NSString *extractedDateString = [self extractDateOfBirth];
    if (!extractedDateString) return nil;

    NSMutableString *birthdayString = [[NSMutableString alloc] initWithString:extractedDateString];

    if (self.isDNumber) {
        NSString *replacementString = [NSString stringWithFormat:@"%lu", (unsigned long)(self.DNumberValue - 4)];
        [birthdayString replaceCharactersInRange:NSMakeRange(0, 1) withString:replacementString];
    }

    return [birthdayString copy];
}

- (NSString *)dateOfBirthStringWithCentury
{
    NSMutableString *birthdayString = [[NSMutableString alloc] initWithString:self.dateOfBirthString];
    SSNCenturyType century = [self bornInCentury:self.personalNumber];

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

    return [birthdayString copy];
}

- (NSDate *)birthdate
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"DDMMyyyy";
    NSDate *date = [formatter dateFromString:self.dateOfBirthStringWithCentury];

    return date;
}

#pragma mark - Private methods

- (NSUInteger)calculateSSN:(NSString *)SSN withWeightNumbers:(NSArray *)weightNumbers
{
    NSUInteger result = 0;

    for (int index=0; index < SSN.length; ++index) {
        NSUInteger currentDigit = (NSUInteger)[[SSN substringWithRange:NSMakeRange(index,1)] integerValue];
        result += [weightNumbers[index] integerValue] * currentDigit;
    }

    return result;
}

- (NSUInteger)personalNumber
{
    return [self.personalNumberString integerValue];
}

- (NSUInteger)DNumberValue
{
    return (self.SSN.length >= 1) ? [[self.SSN substringToIndex:1] integerValue] : 0;
}

- (NSString *)extractDateOfBirth
{
    return (self.SSN.length >= 6) ? [self.SSN substringToIndex:6] : nil;
}

- (NSString *)personalNumberString
{
    return (self.SSN.length >= 9) ? [self.SSN substringWithRange:NSMakeRange(6,3)] : nil;
}

- (NSString *)controlNumberString
{
    return (self.SSN.length == HYPValidSSNLength) ? [self.SSN substringFromIndex:9] : nil;
}

- (NSUInteger)firstControlNumber
{
    return [[self.controlNumberString substringToIndex:1] integerValue];
}

- (NSUInteger)secondControlNumber
{
    return [[self.controlNumberString substringFromIndex:1] integerValue];
}

- (NSUInteger)modulusEleven:(NSUInteger)controlDigit
{
    controlDigit = 11 - (controlDigit % 11);

    return (controlDigit == 11) ? 0 : controlDigit;
}

- (SSNCenturyType)bornInCentury:(NSUInteger)personalNumber
{
    if (NSLocationInRange(personalNumber, HYPTwentiethCenturyRange)) {
        return SSNTwentiethCenturyType;
    } else if (NSLocationInRange(personalNumber, HYPNineteenthCenturyRange)) {
        return SSNNineteenthCenturyType;
    } else if (NSLocationInRange(personalNumber, HYPTwentyFirstCenturyRange)) {
        return SSNTwentyFirstCenturyType;
    } else if (NSLocationInRange(personalNumber, HYPTwentiethCenturyAlternateRange)) {
        return SSNTwentiethCenturyAlternateType;
    }

    return SSNDefaultCenturyType;
}

@end
