//
//  HYPNorwegianSSNTests.m
//  HYPNorwegianSSNTests
//
//  Created by Christoffer Winterkvist on 10/5/14.
//
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "HYPNorwegianSSN.h"

@interface HYPNorwegianSSNTests : XCTestCase

@property (nonatomic, strong) HYPNorwegianSSN *SSN;

@end

@implementation HYPNorwegianSSNTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSSNValidation
{
    XCTAssert([HYPNorwegianSSN validateWithString:@"01015000232"], @"SSN is valid");
}

- (void)testAgePresence
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssert(([ssn.age integerValue] > 0), @"Age is higher than zero");
}

- (void)testAgeCalculation
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssert(([ssn.age isEqualToNumber:@64]), @"Age is 64");
}

- (void)testIfFemale
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssert(ssn.isFemale, @"Is Female");
}

- (void)testIfMale
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssert(!ssn.isMale, @"Is not Male");
}

- (void)testDNumber
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssert(!ssn.isDNumber, @"Is not D-Number (not a party swede, thank god)");
}

- (void)testDateOfBirthString
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssert([ssn.dateOfBirthString isEqualToString:@"010150"], @"Sucessfully extracted date of birth");
}

- (void)testDateOfBirthStringWithCentury
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssert([ssn.dateOfBirthStringWithCentury isEqualToString:@"01011950"], @"Sucessfully extracted date of birth");
}

- (void)testBirthdate
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"DDMMyyyy";
    NSDate *date = [formatter dateFromString:ssn.dateOfBirthStringWithCentury];

    XCTAssert(date, @"Date of birth is an NSDate");
}

- (void)testAgeDateConversion
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"14028849959"];

    XCTAssert(([ssn.age isEqualToNumber:@26]), @"Age is %@", [ssn.age stringValue]);
}

@end
