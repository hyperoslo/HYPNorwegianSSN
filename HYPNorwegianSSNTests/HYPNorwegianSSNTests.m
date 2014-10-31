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
    XCTAssertTrue([HYPNorwegianSSN validateWithString:@"01015000232"]);
}

- (void)testAgePresence
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertGreaterThan([ssn.age integerValue], 0);
}

- (void)testAgeCalculation
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertEqualObjects(ssn.age, @64);
}

- (void)testIfFemale
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertTrue(ssn.isFemale);
}

- (void)testIfMale
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertFalse(ssn.isMale);
}

- (void)testDNumber
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertFalse(ssn.isDNumber);
}

- (void)testDateOfBirthString
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertEqualObjects(ssn.dateOfBirthString, @"010150");
}

- (void)testDateOfBirthStringWithCentury
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertEqualObjects(ssn.dateOfBirthStringWithCentury, @"01011950");
}

- (void)testBirthdate
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"DDMMyyyy";
    NSDate *date = [formatter dateFromString:ssn.dateOfBirthStringWithCentury];

    XCTAssertNotNil(date);
}

- (void)testAgeDateConversion
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"14028849959"];

    XCTAssertEqualObjects(ssn.age, @26);
}

@end
